import 'dart:async';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/location/location_callback_handler.dart';
import 'package:flutter_my_tracker/pages/index/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/pages/index/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/index/components/pace_gradient_bar.dart';
import 'package:flutter_my_tracker/pages/index/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:location_permissions/location_permissions.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isRunning = false;
  LocationDto? lastLocation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    syncServiceRunningState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  Future<void> syncServiceRunningState() async {
    final isServiceRunning = await BackgroundLocator.isServiceRunning();
    if (context.mounted) {
      setState(() {
        isRunning = isServiceRunning;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final trackStatCubit =
                BlocProvider.of<TrackStatCubit>(context, listen: false);
            if (isRunning) {
              _onStop().then((value) => trackStatCubit.stop());
            } else {
              _onStart().then((value) => trackStatCubit.start());
            }
          },
          backgroundColor: _determineButtonColor(),
          child: (isRunning)
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
        ),
        bottomSheet: Container(
          color: Theme.of(context).colorScheme.background,
          child: DraggableScrollableSheet(
            // maxChildSize: 0.6,
            minChildSize: 0.4,
            expand: false,
            snap: true,
            snapSizes: const [0.4],
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [MainInfoCard()],
                  ),
                ),
              );
            },
          ),
        ),
        body: const SizedBox.expand(
            child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: TrajectoryPanel(),
                ),
              ],
            )
          ],
        )));
  }

  Color _determineButtonColor() {
    return isRunning ? Colors.red : Colors.green;
  }

  Future<bool> _onStop() async {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    await BackgroundLocator.unRegisterLocationUpdate();
    final isServiceRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = isServiceRunning;
    });
    return isServiceRunning;
  }

  Future<bool> _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final isServiceRunning = await BackgroundLocator.isServiceRunning();

      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        // 每秒触发一次的逻辑
        print(DateTime.now());
      });

      setState(() {
        isRunning = isServiceRunning;
        lastLocation = null;
      });

      return isServiceRunning;
    } else {
      // show error
    }
    return false;
  }

  Future<bool> _checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        return (permission == PermissionStatus.granted);
      case PermissionStatus.granted:
        return true;
      default:
        return false;
    }
  }

  Future<void> _startLocator() async {
    logger.d('_startLocator');
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: const IOSSettings(
            showsBackgroundLocationIndicator: true,
            accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 0),
        autoStop: false,
        androidSettings: const AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}

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
import 'package:flutter_my_tracker/models/enums/operation.dart';
import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:flutter_my_tracker/pages/index/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/index/components/recent_record_card.dart';
import 'package:flutter_my_tracker/pages/index/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/pages/settings/settings_page.dart';
import 'package:flutter_my_tracker/providers/operation_record_provider.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final trackStatCubit =
                BlocProvider.of<TrackStatCubit>(context, listen: false);
            if (isRunning) {
              _onStop().then((value) {
                OperationRecordProvider.instance().insert(OperationRecord(
                    time: DateTime.now(), operation: Operation.stop));
                trackStatCubit.stop();
              });
            } else {
              _onStart().then((value) {
                OperationRecordProvider.instance().insert(OperationRecord(
                    time: DateTime.now(), operation: Operation.start));
                trackStatCubit.start();
              });
            }
          },
          backgroundColor: _determineButtonColor(Theme.of(context).colorScheme),
          child: (isRunning)
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
        ),
        bottomSheet: Container(
          color: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
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
                    children: [MainInfoCard(), RecentRecordCard()],
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

  Color _determineButtonColor(ColorScheme colorScheme) {
    return isRunning
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;
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
        final trackStatCubit =
            BlocProvider.of<TrackStatCubit>(context, listen: false);
        trackStatCubit.tick();
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
    final locationStatusGranted = await _checkPermission(Permission.location);
    if (locationStatusGranted) {
      return await _checkPermission(Permission.locationAlways);
    }
    return locationStatusGranted;
  }

  Future<bool> _checkPermission(Permission permission) async {
    final access = await permission.status;
    logger.d('----$access');

    switch (access) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permissionStatus = await permission.request();
        logger.d('--===--$permissionStatus');
        return (permissionStatus == PermissionStatus.granted);
      case PermissionStatus.permanentlyDenied:
        return false;
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
            client: LocationClient.android,
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

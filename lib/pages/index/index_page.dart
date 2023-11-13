import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:cactus_locator/background_locator.dart';
import 'package:cactus_locator/location_dto.dart';
import 'package:cactus_locator/settings/android_settings.dart';
import 'package:cactus_locator/settings/ios_settings.dart';
import 'package:cactus_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/components/location/location_callback_handler.dart';
import 'package:flutter_my_tracker/models/enums/operation.dart';
import 'package:flutter_my_tracker/models/enums/track_state.dart';
import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:flutter_my_tracker/pages/index/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/index/components/recent_record_card.dart';
import 'package:flutter_my_tracker/pages/index/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/pages/settings/settings_page.dart';
import 'package:flutter_my_tracker/providers/operation_record_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with WidgetsBindingObserver {
  bool isRunning = false;
  LocationDto? lastLocation;
  Timer? _timer;
  bool? _locationEnable;
  bool? _permissionGranted;
  bool? _permissionAlwaysGranted;

  late final List<StreamSubscription> streamSubscriptions;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncServiceState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncServiceState();
    }
  }

  Future<bool> syncServiceRunningState() async {
    final isServiceRunning = await BackgroundLocator.isServiceRunning();
    if (mounted) {
      setState(() {
        isRunning = isServiceRunning;
      });
    }
    return isServiceRunning;
  }

  @override
  Widget build(BuildContext context) {
    // logger.d(
    //     '----${_locationEnable} ${_permissionGranted} ${_permissionAlwaysGranted}');
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          onPressed: () {
            final trackStatCubit = BlocProvider.of<TrackStatCubit>(context);
            if (isRunning) {
              _onStop().then((value) {
                OperationRecordProvider.instance().insert(OperationRecord(
                    time: DateTime.now(), operation: Operation.stop));
                trackStatCubit.stop(context);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
              });
            } else {
              _onStart().then((value) {
                OperationRecordProvider.instance().insert(OperationRecord(
                    time: DateTime.now(), operation: Operation.start));
                trackStatCubit.start();
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
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
        body: SizedBox.expand(
            child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: TrajectoryPanel(isServiceRunning: isRunning),
                ),
              ],
            ),
            if (_locationEnable == false)
              MaterialBanner(
                  content: Text(S.of(context).locationServiceDisabled),
                  actions: [
                    TextButton(
                        onPressed: () {
                          // 跳到系统定位服务设置页
                          AppSettings.openAppSettings(
                              type: AppSettingsType.location);
                        },
                        child: Text(S.of(context).goOpen))
                  ]),
            if (_locationEnable != false &&
                (_permissionGranted == false ||
                    _permissionAlwaysGranted == false))
              MaterialBanner(
                  content: (_permissionGranted ?? false)
                      ? Text(S.of(context).unauthorizedLocationAlways)
                      : Text(S.of(context).unauthorizedLocation),
                  actions: [
                    TextButton(
                        onPressed: () {
                          // 打开应用权限设置页
                          openAppSettings();
                        },
                        child: Text(S.of(context).goOpen))
                  ])
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
    // logger.d('-----${isServiceRunning}');
    if (mounted) {
      setState(() {
        isRunning = isServiceRunning;
      });
    }
    return isServiceRunning;
  }

  Future<bool> _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final isServiceRunning = await BackgroundLocator.isServiceRunning();

      _tickTimer();

      if (mounted) {
        setState(() {
          isRunning = isServiceRunning;
          lastLocation = null;
        });
      }

      return isServiceRunning;
    } else {
      if (mounted) {
        setState(() {
          isRunning = false;
          lastLocation = null;
        });
      }
    }
    return false;
  }

  void _tickTimer() {
    if (_timer?.isActive ?? false) {
      return;
    }
    _timer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      // 每秒触发一次的逻辑
      final trackStatCubit =
          BlocProvider.of<TrackStatCubit>(context, listen: false);
      trackStatCubit.tick();
    });
  }

  Future<bool> _checkLocationPermission() async {
    final locationStatusGranted = await _checkPermission(Permission.location);
    if (mounted) {
      setState(() {
        _permissionGranted = locationStatusGranted;
      });
    }
    if (locationStatusGranted) {
      final locationAlwaysStatusGranted =
          await _checkPermission(Permission.locationAlways);
      if (mounted) {
        setState(() {
          _permissionAlwaysGranted = locationAlwaysStatusGranted;
        });
      }
      return locationAlwaysStatusGranted;
    }
    return locationStatusGranted;
  }

  Future<bool> _checkPermission(Permission permission) async {
    final access = await permission.status;
    logger.d('[checkPermission] access: $access');

    switch (access) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permissionStatus = await permission.request();
        logger.d('[checkPermission] permissionStatus: $permissionStatus');
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
    logger.d('[_startLocator]');
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
            interval: 5,
            distanceFilter: 0,
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

  void _syncServiceState() {
    Permission.location.serviceStatus.isEnabled.then(
      (isEnabled) {
        if (mounted) {
          setState(() {
            _locationEnable = isEnabled;
          });
        }
      },
    );
    Permission.location.isGranted.then(
      (permissionGranted) {
        if (mounted) {
          setState(() {
            _permissionGranted = permissionGranted;
          });
        }
      },
    );
    Permission.locationAlways.isGranted.then(
      (permissionGranted) {
        if (mounted) {
          setState(() {
            _permissionAlwaysGranted = permissionGranted;
          });
        }
      },
    );
    syncServiceRunningState().then((isServiceRunning) {
      if (isServiceRunning) {
        OperationRecordProvider.instance().insert(OperationRecord(
            time: DateTime.now(), operation: Operation.autoResume));
        // final trackStatCubit = BlocProvider.of<TrackStatCubit>(context);
        // trackStatCubit.start();
        _tickTimer();
      } else {
        // 当前定位服务关闭时，读取最新记录，如果是未正常关闭，则自动启动定位服务
        TrackStatProvider.instance()
            .getRunningTrackStat()
            .then((runningTrackStat) {
          if (runningTrackStat?.state == TrackState.started) {
            final trackStatCubit = BlocProvider.of<TrackStatCubit>(context);
            trackStatCubit.resume(runningTrackStat!);
            _onStart();
          }
        });
      }
    });
  }
}

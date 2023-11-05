// import 'dart:isolate';
// import 'dart:math';
// import 'dart:ui';
// import 'dart:collection';

// import 'package:background_locator/background_locator.dart';
// import 'package:background_locator/location_dto.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_my_tracker/components/location/location_state.dart';
// import 'package:flutter_my_tracker/components/sensor/pojos/coordinates.dart';
// import 'package:flutter_my_tracker/components/sensor/pojos/sensor_gps_data_item.dart';
// import 'package:flutter_my_tracker/components/sensor/sensor_gps_kalman_filter.dart';
// import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
// import 'package:flutter_my_tracker/cubit/theme/theme_cubit.dart';
// import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
// import 'package:flutter_my_tracker/cubit/track_stat/track_stat_cubit.dart';
// import 'package:flutter_my_tracker/generated/l10n.dart';
// import 'package:flutter_my_tracker/components/location/location_service_repository.dart';
// import 'package:flutter_my_tracker/models/enums/track_state.dart';
// import 'package:flutter_my_tracker/models/pojos/position.dart';
// import 'package:flutter_my_tracker/pages/index/index_page.dart';
// import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
// import 'package:flutter_my_tracker/utils/logger.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// import 'dart:async';

// class MyTrackerApp extends StatefulWidget {
//   const MyTrackerApp({super.key});

//   @override
//   State<MyTrackerApp> createState() => _MyTrackerAppState();
// }

// class _MyTrackerAppState extends State<MyTrackerApp> {
//   ReceivePort port = ReceivePort();
//   bool isRunning = false;

//   List<double>? _userAccelerometerValues = List.filled(4, 0);
//   List<double>? _accelerometerValues = List.filled(4, 0);
//   List<double>? _gyroscopeValues = List.filled(4, 0);
//   List<double>? _magnetometerValues = List.filled(4, 0);

//   Queue<SensorGpsDataItem> _sensorDataQueue = Queue<SensorGpsDataItem>();

//   GPSAccKalmanFilter? m_kalmanFilter;
//   double m_magneticDeclination = 0.0;

//   final _streamSubscriptions = <StreamSubscription<dynamic>>[];

//   @override
//   void initState() {
//     super.initState();
//     try {
//       context.read<ThemeCubit>().loadTheme();
//       context.read<LocaleCubit>().loadLocales();
//     } catch (e) {
//       logger.e('[initCubits]', error: e);
//     }
//     try {
//       // 监听传感器
//       _registSensorListeners();

//       // 监听定位
//       _initLocationIsolate();

//       // 设置初始状态
//       initPlatformState();
//     } catch (e) {
//       logger.e('[initState]', error: e);
//     }
//   }

//   void _initLocationIsolate() {
//     if (IsolateNameServer.lookupPortByName(
//             LocationServiceRepository.isolateName) !=
//         null) {
//       IsolateNameServer.removePortNameMapping(
//           LocationServiceRepository.isolateName);
//     }

//     IsolateNameServer.registerPortWithName(
//         port.sendPort, LocationServiceRepository.isolateName);

//     final trackStatCubit =
//         BlocProvider.of<TrackStatCubit>(context, listen: false);

//     port.listen(
//       (dynamic data) async {
//         await updateUI(data);
//         Position? position = (data != null) ? Position.fromJson(data) : null;
//         if (position != null) {
//           m_kalmanFilter ??= GPSAccKalmanFilter(true, 0, 0, 0, 0, 0, 0,
//               DateTime.now().millisecondsSinceEpoch.toDouble(), 0, 0);
//           trackStatCubit.update(position);
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     for (final subscription in _streamSubscriptions) {
//       subscription.cancel();
//     }
//     try {
//       port.close();
//     } catch (e) {
//       logger.e('[dispose]', error: e);
//     }

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TrackStatCubit, TrackStatState>(
//         builder: (context, trackStatState) {
//       if (trackStatState is TrackStatStart) {
//         _toggleSensorListeners(true);
//       } else if (trackStatState is TrackStatStop) {
//         _toggleSensorListeners(false);
//       }
//       return BlocBuilder<ThemeCubit, ThemeState>(
//           builder: (context, themeState) {
//         final themeMode =
//             (themeState is DarkTheme) ? ThemeMode.dark : ThemeMode.light;
//         return BlocBuilder<LocaleCubit, LocaleState>(
//             builder: (context, localeState) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData.light(
//               useMaterial3: true,
//             ).copyWith(
//                 colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
//             darkTheme: ThemeData.dark(
//               useMaterial3: true,
//             ),
//             themeMode: themeMode,
//             localizationsDelegates: const [
//               S.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: S.delegate.supportedLocales,
//             locale: localeState.locale,
//             home: const IndexPage(),
//           );
//         });
//       });
//     });
//   }

//   Future<void> updateUI(dynamic data) async {
//     if (data == null) {
//       return;
//     }
//     try {
//       LocationDto locationDto = LocationDto.fromJson(data);
//       await _updateNotificationText(locationDto);
//     } catch (e) {
//       logger.e('[updateUI]', error: e);
//     }
//   }

//   Future<void> _updateNotificationText(LocationDto data) async {
//     // logger.d("${data.toJson()}");
//     await BackgroundLocator.updateNotificationText(
//         title: "New location received",
//         msg: "${DateTime.now()}",
//         bigMsg: "${data.latitude}, ${data.longitude}");
//   }

//   Future<void> initPlatformState() async {
//     logger.d('Initializing...');
//     await BackgroundLocator.initialize();
//     logger.d('Initialization done');
//     final isServiceRunning = await BackgroundLocator.isServiceRunning();
//     setState(() {
//       isRunning = isServiceRunning;
//     });
//     logger.d('Running ${isRunning.toString()}');
//     _toggleSensorListeners(isServiceRunning);
//   }

//   void _handlePredict(SensorGpsDataItem sdi) {
//     m_kalmanFilter?.predict(sdi.timestamp, sdi.absEastAcc, sdi.absNorthAcc);
//   }

//   void _handleUpdate(SensorGpsDataItem sdi) {
//     double xVel = sdi.getSpeed() * cos(sdi.getCourse());
//     double yVel = sdi.getSpeed() * sin(sdi.getCourse());
//     m_kalmanFilter?.update(
//         sdi.timestamp,
//         Coordinates.longitudeToMeters(sdi.gpsLon),
//         Coordinates.latitudeToMeters(sdi.gpsAlt),
//         xVel,
//         yVel,
//         sdi.posErr,
//         sdi.velErr);
//   }

//   void _locationAfterUpdateStep(SensorGpsDataItem sdi) {
//     double xVel, yVel;
//     // LocationDto loc = LocationDto();
//     //         GeoPoint pp = Coordinates.metersToGeoPoint(m_kalmanFilter.getCurrentX(),
//     //                 m_kalmanFilter.getCurrentY());
//     //         loc.setLatitude(pp.latitude);
//     //         loc.setLongitude(pp.longitude);
//     //         loc.setAltitude(sdi.getGpsAlt());
//     //         xVel = m_kalmanFilter.getCurrentXVel();
//     //         yVel = m_kalmanFilter.getCurrentYVel();
//     //         double speed = sqrt(xVel * xVel + yVel * yVel); //scalar speed without bearing
//     //         loc.setBearing((float) sdi.getCourse());
//     //         loc.setSpeed((float) speed);
//     //         loc.setTime(System.currentTimeMillis());
//     //         loc.setElapsedRealtimeNanos(System.nanoTime());
//     //         loc.setAccuracy((float) sdi.getPosErr());

//     //         if (m_geoHashRTFilter != null) {
//     //             m_geoHashRTFilter.filter(loc);
//     //         }

//     //         return loc;
//   }

//   void _registSensorListeners() {
//     _streamSubscriptions.add(
//       userAccelerometerEvents.listen(
//         (UserAccelerometerEvent event) {
//           if (m_kalmanFilter == null) {
//             return;
//           }
//           logger.d('[userAccelerometerEvents] $event');
//           final sdi = SensorGpsDataItem(
//               timestamp: DateTime.now().microsecondsSinceEpoch.toDouble(),
//               absEastAcc: event.x,
//               absNorthAcc: event.y,
//               absUpAcc: event.z,
//               declination: 0);
//           // _sensorDataQueue.add(sdi);
//         },
//         onError: (e) {
//           logger.w('[userAccelerometerEvents]', error: e);
//         },
//         cancelOnError: true,
//       ),
//     );
//     _streamSubscriptions.add(
//       accelerometerEvents.listen(
//         (AccelerometerEvent event) {
//           logger.d('[accelerometerEvents] $event');
//           setState(() {
//             _accelerometerValues = <double>[event.x, event.y, event.z];
//           });
//         },
//         onError: (e) {
//           logger.w('[accelerometerEvents]', error: e);
//         },
//         cancelOnError: true,
//       ),
//     );
//     _streamSubscriptions.add(
//       gyroscopeEvents.listen(
//         (GyroscopeEvent event) {
//           logger.d('[gyroscopeEvents] $event');
//           setState(() {
//             _gyroscopeValues = <double>[event.x, event.y, event.z];
//           });
//         },
//         onError: (e) {
//           logger.w('[gyroscopeEvents]', error: e);
//         },
//         cancelOnError: true,
//       ),
//     );
//     _streamSubscriptions.add(
//       magnetometerEvents.listen(
//         (MagnetometerEvent event) {
//           logger.d('[magnetometerEvents] $event');
//           setState(() {
//             _magnetometerValues = <double>[event.x, event.y, event.z];
//           });
//         },
//         onError: (e) {
//           logger.w('[magnetometerEvents]', error: e);
//         },
//         cancelOnError: true,
//       ),
//     );
//   }

//   void _toggleSensorListeners(bool open) {
//     for (final subscription in _streamSubscriptions) {
//       if (subscription.isPaused && open) {
//         subscription.resume();
//       } else if (!open) {
//         subscription.pause();
//       }
//     }
//   }

// }

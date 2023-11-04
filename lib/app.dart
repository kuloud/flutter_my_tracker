import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_cubit.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
import 'package:flutter_my_tracker/cubit/track_stat/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/components/location/location_service_repository.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/index/index_page.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'dart:async';

class MyTrackerApp extends StatefulWidget {
  const MyTrackerApp({super.key});

  @override
  State<MyTrackerApp> createState() => _MyTrackerAppState();
}

class _MyTrackerAppState extends State<MyTrackerApp> {
  ReceivePort port = ReceivePort();
  bool isRunning = false;

  List<double>? _userAccelerometerValues;
  List<double>? _accelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    try {
      context.read<ThemeCubit>().loadTheme();
      context.read<LocaleCubit>().loadLocales();

      if (IsolateNameServer.lookupPortByName(
              LocationServiceRepository.isolateName) !=
          null) {
        IsolateNameServer.removePortNameMapping(
            LocationServiceRepository.isolateName);
      }

      IsolateNameServer.registerPortWithName(
          port.sendPort, LocationServiceRepository.isolateName);

      final trackStatCubit =
          BlocProvider.of<TrackStatCubit>(context, listen: false);

      port.listen(
        (dynamic data) async {
          await updateUI(data);
          Position? position = (data != null) ? Position.fromJson(data) : null;
          if (position != null) {
            trackStatCubit.update(position);
          }
        },
      );

      initPlatformState();
    } catch (e) {
      logger.e('[initState]', error: e);
    }

    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          logger.d('[userAccelerometerEvents] $event');
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          logger.w('[userAccelerometerEvents]', error: e);
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          logger.d('[accelerometerEvents] $event');
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          logger.w('[accelerometerEvents]', error: e);
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          logger.d('[gyroscopeEvents] $event');
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          logger.w('[gyroscopeEvents]', error: e);
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          logger.d('[magnetometerEvents] $event');
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          logger.w('[magnetometerEvents]', error: e);
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    try {
      port.close();
    } catch (e) {
      logger.e('[dispose]', error: e);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(
            useMaterial3: true,
          ).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: (state is DarkTheme) ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: localeState.locale,
          home: const IndexPage(),
        );
      });
    });
  }

  Future<void> updateUI(dynamic data) async {
    if (data == null) {
      return;
    }
    try {
      LocationDto locationDto = LocationDto.fromJson(data);
      await _updateNotificationText(locationDto);
    } catch (e) {
      logger.e('[updateUI]', error: e);
    }
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    logger.d("${data.toJson()}");

    await BackgroundLocator.updateNotificationText(
        title: "New location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    logger.d('Initializing...');
    await BackgroundLocator.initialize();
    logger.d('Initialization done');
    final isServiceRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = isServiceRunning;
    });
    logger.d('Running ${isRunning.toString()}');
  }
}

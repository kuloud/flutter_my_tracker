import 'dart:isolate';
import 'dart:ui';

import 'package:cactus_locator/background_locator.dart';
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
import 'package:flutter_my_tracker/utils/format.dart';

import 'dart:async';

import 'package:x_common/utils/logger.dart';

class MyTrackerApp extends StatefulWidget {
  const MyTrackerApp({super.key});

  @override
  State<MyTrackerApp> createState() => _MyTrackerAppState();
}

class _MyTrackerAppState extends State<MyTrackerApp> {
  ReceivePort port = ReceivePort();
  bool isRunning = false;
  Locale? currentLocale;

  @override
  void initState() {
    super.initState();
    try {
      context.read<ThemeCubit>().loadTheme();
      context.read<LocaleCubit>().loadLocales();
    } catch (e) {
      logger.e('[initCubits]', error: e);
    }
    try {
      // 监听定位
      _initLocationIsolate();

      // 设置初始状态
      initPlatformState();
    } catch (e) {
      logger.e('[initState]', error: e);
    }
  }

  void _initLocationIsolate() {
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
        Position? position = (data != null) ? Position.fromJson(data) : null;
        if (position != null) {
          _updateNotificationText(trackStatCubit.state);
          trackStatCubit.update(position);
        }
      },
    );
  }

  @override
  void dispose() {
    try {
      port.close();
    } catch (e) {
      logger.e('[dispose]', error: e);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
        builder: (context, trackStatState) {
      return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
        final themeMode =
            (themeState is DarkTheme) ? ThemeMode.dark : ThemeMode.light;
        return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
          currentLocale = localeState.locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(
              useMaterial3: true,
            ).copyWith(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            themeMode: themeMode,
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
    });
  }

  Future<void> _updateNotificationText(trackStatState) async {
    // logger.d("${data.toJson()}");

    if (trackStatState is TrackStatUpdated) {
      if (currentLocale == null) {
        return;
      }
      try {
        final s = await S.load(currentLocale!);
        final totalDistance =
            distanceFormat(s, trackStatState.trackStat.totalDistance);
        // final totalTime =
        //     formatMilliseconds(trackStatState.trackStat.totalTime.toInt());
        await BackgroundLocator.updateNotificationText(
            title: s.newLocationReceived,
            msg: s.notificationTotalDiatance(totalDistance));
      } catch (e) {
        //
        logger.e('[_updateNotificationText]', error: e);
      }
    }
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

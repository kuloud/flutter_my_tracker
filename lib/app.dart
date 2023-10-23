import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/keys.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/location/location_service_repository.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/index/index_page.dart';
import 'package:flutter_my_tracker/pages/test.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

import 'dart:async';

import 'package:get_it/get_it.dart';

class MyTrackerApp extends StatefulWidget {
  const MyTrackerApp({super.key});

  @override
  State<MyTrackerApp> createState() => _MyTrackerAppState();
}

class _MyTrackerAppState extends State<MyTrackerApp> {
  ReceivePort port = ReceivePort();
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    context.read<ThemeBloc>().loadTheme();
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
  }

  @override
  void dispose() {
    port.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
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
          // home: const TrajectoryPage(),
          // home: MyApp(),
        );
      });
    });
  }

  Future<void> updateUI(dynamic data) async {
    if (data == null) {
      return;
    }
    LocationDto locationDto = LocationDto.fromJson(data);
    await _updateNotificationText(locationDto);
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

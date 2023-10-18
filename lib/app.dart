import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/location/location_callback_handler.dart';
import 'package:flutter_my_tracker/location/location_service_repository.dart';
import 'package:flutter_my_tracker/pages/index/index_page.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:location_permissions/location_permissions.dart';

import 'dart:async';

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
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );

    initPlatformState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const IndexPage(),
    );
  }

  Future<void> updateUI(dynamic data) async {
    LocationDto? locationDto =
        (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto);
  }

  Future<void> _updateNotificationText(LocationDto? data) async {
    if (data == null) {
      return;
    }

    // logger.d("${data.latitude}, ${data.longitude}");

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
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

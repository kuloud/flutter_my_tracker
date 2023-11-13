// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FlyMove`
  String get appName {
    return Intl.message(
      'FlyMove',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Love, yourself.`
  String get appSlogan {
    return Intl.message(
      'Love, yourself.',
      name: 'appSlogan',
      desc: '',
      args: [],
    );
  }

  /// `A minimalist-style activity tracking app that follows the design language of Material You.`
  String get labelAppDescription {
    return Intl.message(
      'A minimalist-style activity tracking app that follows the design language of Material You.',
      name: 'labelAppDescription',
      desc: '',
      args: [],
    );
  }

  /// `View Readme`
  String get viewReadme {
    return Intl.message(
      'View Readme',
      name: 'viewReadme',
      desc: '',
      args: [],
    );
  }

  /// `Version {{ version }}, Build #{{ buildNumber }}`
  String versionBuild(Object version, Object buildNumber) {
    return Intl.message(
      'Version {$version}, Build #{$buildNumber}',
      name: 'versionBuild',
      desc: '',
      args: [version, buildNumber],
    );
  }

  /// `© {{ author }}, {{ year }}`
  String authorYear(Object author, Object year) {
    return Intl.message(
      '© {$author}, {$year}',
      name: 'authorYear',
      desc: '',
      args: [author, year],
    );
  }

  /// `View Changelog`
  String get viewChangelog {
    return Intl.message(
      'View Changelog',
      name: 'viewChangelog',
      desc: '',
      args: [],
    );
  }

  /// `View Privacy Policy`
  String get viewPrivacyPolicy {
    return Intl.message(
      'View Privacy Policy',
      name: 'viewPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Total Duration`
  String get totalDuration {
    return Intl.message(
      'Total Duration',
      name: 'totalDuration',
      desc: '',
      args: [],
    );
  }

  /// `Slow`
  String get slow {
    return Intl.message(
      'Slow',
      name: 'slow',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get fast {
    return Intl.message(
      'Fast',
      name: 'fast',
      desc: '',
      args: [],
    );
  }

  /// `Pace`
  String get pace {
    return Intl.message(
      'Pace',
      name: 'pace',
      desc: '',
      args: [],
    );
  }

  /// `Min Pace`
  String get minPace {
    return Intl.message(
      'Min Pace',
      name: 'minPace',
      desc: '',
      args: [],
    );
  }

  /// `Max Pace`
  String get maxPace {
    return Intl.message(
      'Max Pace',
      name: 'maxPace',
      desc: '',
      args: [],
    );
  }

  /// `Altitude`
  String get altitude {
    return Intl.message(
      'Altitude',
      name: 'altitude',
      desc: '',
      args: [],
    );
  }

  /// `Min Altitude`
  String get minAltitude {
    return Intl.message(
      'Min Altitude',
      name: 'minAltitude',
      desc: '',
      args: [],
    );
  }

  /// `Max Altitude`
  String get maxAltitude {
    return Intl.message(
      'Max Altitude',
      name: 'maxAltitude',
      desc: '',
      args: [],
    );
  }

  /// `({unit})`
  String unit(Object unit) {
    return Intl.message(
      '($unit)',
      name: 'unit',
      desc: '',
      args: [unit],
    );
  }

  /// `Average Pace`
  String get averagePace {
    return Intl.message(
      'Average Pace',
      name: 'averagePace',
      desc: '',
      args: [],
    );
  }

  /// `Recent Activity`
  String get recentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `All Activities`
  String get allActivities {
    return Intl.message(
      'All Activities',
      name: 'allActivities',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get meters {
    return Intl.message(
      'm',
      name: 'meters',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get kilometers {
    return Intl.message(
      'km',
      name: 'kilometers',
      desc: '',
      args: [],
    );
  }

  /// `to Now`
  String get toNow {
    return Intl.message(
      'to Now',
      name: 'toNow',
      desc: '',
      args: [],
    );
  }

  /// `Activity Summary`
  String get activitySummary {
    return Intl.message(
      'Activity Summary',
      name: 'activitySummary',
      desc: '',
      args: [],
    );
  }

  /// `{times} Activities`
  String activityTimes(Object times) {
    return Intl.message(
      '$times Activities',
      name: 'activityTimes',
      desc: '',
      args: [times],
    );
  }

  /// `Total Distance`
  String get totalDistance {
    return Intl.message(
      'Total Distance',
      name: 'totalDistance',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `,`
  String get comma {
    return Intl.message(
      ',',
      name: 'comma',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `/km`
  String get minutePerKilometer {
    return Intl.message(
      '/km',
      name: 'minutePerKilometer',
      desc: '',
      args: [],
    );
  }

  /// `km/h`
  String get kilometerPerHour {
    return Intl.message(
      'km/h',
      name: 'kilometerPerHour',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get meter {
    return Intl.message(
      'm',
      name: 'meter',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get kilometer {
    return Intl.message(
      'km',
      name: 'kilometer',
      desc: '',
      args: [],
    );
  }

  /// `East`
  String get east {
    return Intl.message(
      'East',
      name: 'east',
      desc: '',
      args: [],
    );
  }

  /// `North`
  String get north {
    return Intl.message(
      'North',
      name: 'north',
      desc: '',
      args: [],
    );
  }

  /// `Sky`
  String get sky {
    return Intl.message(
      'Sky',
      name: 'sky',
      desc: '',
      args: [],
    );
  }

  /// `Distance is too short, data will not be recorded.`
  String get toastDistanceTooShort {
    return Intl.message(
      'Distance is too short, data will not be recorded.',
      name: 'toastDistanceTooShort',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get unitKm {
    return Intl.message(
      'km',
      name: 'unitKm',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get unitM {
    return Intl.message(
      'm',
      name: 'unitM',
      desc: '',
      args: [],
    );
  }

  /// `workouts`
  String get workoutsTimes {
    return Intl.message(
      'workouts',
      name: 'workoutsTimes',
      desc: '',
      args: [],
    );
  }

  /// `Pace`
  String get labelPace {
    return Intl.message(
      'Pace',
      name: 'labelPace',
      desc: '',
      args: [],
    );
  }

  /// `Avg Pace`
  String get labelAvgPace {
    return Intl.message(
      'Avg Pace',
      name: 'labelAvgPace',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get labelStep {
    return Intl.message(
      'Steps',
      name: 'labelStep',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get min {
    return Intl.message(
      'm',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get hour {
    return Intl.message(
      'h',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Lab`
  String get lab {
    return Intl.message(
      'Lab',
      name: 'lab',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get refuse {
    return Intl.message(
      'Refuse',
      name: 'refuse',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized permission to access device location.`
  String get unauthorizedLocation {
    return Intl.message(
      'Unauthorized permission to access device location.',
      name: 'unauthorizedLocation',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized permission to access device location when the app is running in the background.`
  String get unauthorizedLocationAlways {
    return Intl.message(
      'Unauthorized permission to access device location when the app is running in the background.',
      name: 'unauthorizedLocationAlways',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access your outdoor location. Please go to FlyMove - Permissions to grant location access.`
  String get unauthorizedLocationDescription {
    return Intl.message(
      'Unable to access your outdoor location. Please go to FlyMove - Permissions to grant location access.',
      name: 'unauthorizedLocationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Location Services Disabled`
  String get locationServiceDisabled {
    return Intl.message(
      'Location Services Disabled',
      name: 'locationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Go Open`
  String get goOpen {
    return Intl.message(
      'Go Open',
      name: 'goOpen',
      desc: '',
      args: [],
    );
  }

  /// `New location received`
  String get newLocationReceived {
    return Intl.message(
      'New location received',
      name: 'newLocationReceived',
      desc: '',
      args: [],
    );
  }

  /// `Total Distance: {distance}`
  String notificationTotalDiatance(Object distance) {
    return Intl.message(
      'Total Distance: $distance',
      name: 'notificationTotalDiatance',
      desc: '',
      args: [distance],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

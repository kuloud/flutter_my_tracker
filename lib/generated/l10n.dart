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

  /// `Flit`
  String get appName {
    return Intl.message(
      'Flit',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get bottomNavigationBarLabelMap {
    return Intl.message(
      'Map',
      name: 'bottomNavigationBarLabelMap',
      desc: '',
      args: [],
    );
  }

  /// `Tracks`
  String get bottomNavigationBarLabelTracks {
    return Intl.message(
      'Tracks',
      name: 'bottomNavigationBarLabelTracks',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get bottomNavigationBarLabelHistory {
    return Intl.message(
      'History',
      name: 'bottomNavigationBarLabelHistory',
      desc: '',
      args: [],
    );
  }

  /// `关于`
  String get titleAbout {
    return Intl.message(
      '关于',
      name: 'titleAbout',
      desc: '',
      args: [],
    );
  }

  /// `A minimalist movement tracking software that 100% follows the Material You design language.`
  String get labelAppDescription {
    return Intl.message(
      'A minimalist movement tracking software that 100% follows the Material You design language.',
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

  /// `Version {{ version }}, build #{{ buildNumber }}`
  String versionBuild(Object version, Object buildNumber) {
    return Intl.message(
      'Version {$version}, build #{$buildNumber}',
      name: 'versionBuild',
      desc: '',
      args: [version, buildNumber],
    );
  }

  /// `Copyright © {{ author }}, {{ year }}`
  String authorYear(Object author, Object year) {
    return Intl.message(
      'Copyright © {$author}, {$year}',
      name: 'authorYear',
      desc: '',
      args: [author, year],
    );
  }

  /// `KM`
  String get unitKm {
    return Intl.message(
      'KM',
      name: 'unitKm',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get unitM {
    return Intl.message(
      'M',
      name: 'unitM',
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

  /// `Step`
  String get labelStep {
    return Intl.message(
      'Step',
      name: 'labelStep',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
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

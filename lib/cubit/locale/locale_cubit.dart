import 'package:bloc/bloc.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(S.delegate.supportedLocales.first));

  final _shared = GetIt.instance.get<SharedPreferences>();

  loadLocales() async {
    String? langCode = _shared.getString('appLang');
    String? countryCode = _shared.getString('appCountry');
    logger.d('${S.delegate.supportedLocales}');
    Locale locale = S.delegate.supportedLocales.firstWhere(
        (e) => e.languageCode == langCode,
        orElse: () => S.delegate.supportedLocales.first);
    logger.d('[loadLocales] ${langCode}_${countryCode}');
    changeLocale(LocaleState.findState(locale));
  }

  changeLocale(LocaleState state) {
    _shared.setString('appLang', state.locale.languageCode);
    if (state.locale.countryCode != null) {
      _shared.setString('appCountry', state.locale.countryCode!);
    } else {
      _shared.remove('appCountry');
    }

    emit(state);
  }
}

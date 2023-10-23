part of 'locale_cubit.dart';

class LocaleState {
  Locale locale;

  LocaleState(this.locale);

  static LocaleState findState(Locale locale) {
    if (S.delegate.isSupported(locale)) {
      return LocaleState(locale);
    } else {
      return LocaleState(S.delegate.supportedLocales.first);
    }
  }
}

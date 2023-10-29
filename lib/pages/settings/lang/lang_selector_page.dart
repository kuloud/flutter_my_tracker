import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  _LanguageSettingsPageState createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).language,
        ),
      ),
      body: Material(child: SafeArea(child:
          BlocBuilder<LocaleCubit, LocaleState>(builder: (context, state) {
        return ListView(
          children: S.delegate.supportedLocales
              .map(
                (e) => ListTile(
                  title: Text(
                    _getLanguageTitle(e),
                  ),
                  trailing: Radio<Locale>(
                      value: e,
                      groupValue: state.locale,
                      onChanged: (locale) => changeLanguage(locale)),
                  onTap: () => changeLanguage(e),
                ),
              )
              .toList(),
        );
      }))),
    );
  }

  changeLanguage(Locale? locale) {
    if (locale != null) {
      final bloc = BlocProvider.of<LocaleCubit>(context, listen: false);
      bloc.changeLocale(LocaleState.findState(locale));
    }
  }
}

String _getLanguageTitle(Locale e) {
  // logger.d('${e.toLanguageTag()}');
  switch (e.languageCode) {
    case 'zh':
      if (e.countryCode == 'HK') {
        return '中文（繁体）';
      } else {
        return '中文（简体）';
      }
    case 'en':
      return 'English';
    case 'ja':
      return '日本語';
    default:
      return '';
  }
}

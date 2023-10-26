import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/about/about_page.dart';
import 'package:flutter_my_tracker/pages/lab/lab_dashboard_page.dart';
import 'package:flutter_my_tracker/pages/settings/lang/lang_selector_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return SwitchListTile(
              title: state is DarkTheme
                  ? Text(S.of(context).darkTheme)
                  : Text(S.of(context).lightTheme),
              onChanged: (open) {
                final themeBloc = context.read<ThemeBloc>();
                themeBloc.changeTheme(open ? DarkTheme() : LightTheme());
              },
              value: state is DarkTheme,
              secondary: state is DarkTheme
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
            );
          }),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(S.of(context).language),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LanguageSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.developer_board),
            title: Text(S.of(context).lab),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LabDashboardPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(S.of(context).about),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

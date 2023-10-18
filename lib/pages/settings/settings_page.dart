import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
import 'package:flutter_my_tracker/pages/about/about_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return SwitchListTile(
              title:
                  state is DarkTheme ? const Text('深色主题') : const Text('浅色主题'),
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
            leading: const Icon(Icons.info),
            title: const Text('关于'),
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

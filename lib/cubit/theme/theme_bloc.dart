import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(LightTheme());

  final _shared = GetIt.instance.get<SharedPreferences>();

  void loadTheme() async {
    bool isDarkMode = _shared.getBool('kIsDarkMode') ?? false;
    changeTheme(isDarkMode ? DarkTheme() : LightTheme());
  }

  void changeTheme(ThemeState state) {
    _shared.setBool('kIsDarkMode', state is DarkTheme);
    emit(state);
  }
}

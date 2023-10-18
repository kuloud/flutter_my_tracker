import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/app.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TrackStatCubit()),
      BlocProvider(create: (context) => ThemeBloc()),
    ],
    child: const MyTrackerApp(),
  ));
}

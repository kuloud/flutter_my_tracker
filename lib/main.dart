import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/app.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_cubit.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/di/di.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/providers/operation_record_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await openDatabases();

  final localeCubit = LocaleCubit();
  await localeCubit.loadLocales();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TrackStatCubit()),
      BlocProvider(create: (context) => ThemeCubit()),
      BlocProvider(create: (context) => localeCubit),
    ],
    child: const MyTrackerApp(),
  ));
}

openDatabases() async {
  await OperationRecordProvider.instance().open();
  await PositionProvider.instance().open();
  await TrackStatProvider.instance().open();
}

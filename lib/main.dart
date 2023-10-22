import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/app.dart';
import 'package:flutter_my_tracker/cubit/theme/theme_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/di/di.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/providers/operation_record_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

import 'package:pubspec_parse/pubspec_parse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await openDatabases();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TrackStatCubit()),
      BlocProvider(create: (context) => ThemeBloc()),
    ],
    child: const MyTrackerApp(),
  ));
}

openDatabases() async {
  await OperationRecordProvider.instance().open();
  await PositionProvider.instance().open();
  await TrackStatProvider.instance().open();
}

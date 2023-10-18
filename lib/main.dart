import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/app.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TrackStatCubit()),
    ],
    child: const MyTrackerApp(),
  ));
}

import 'package:flutter_my_tracker/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
Future<void> configureDependencies() async => await GetIt.instance.init();

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:background_locator/location_dto.dart';
import 'package:flutter_my_tracker/components/location/location_state.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class LocationServiceRepository {
  static final LocationServiceRepository _instance =
      LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  Future<void> init(Map<dynamic, dynamic> params) async {
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> dispose() async {
    logger.d("Dispose callback handler");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> callback(LocationDto locationDto) async {
    final position = await PositionProvider.instance()
        .insert(Position.fromJson(locationDto.toJson()));

    logger.d('[LocationService] callback: ${position.toJson()}');

    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(position.toJson());
  }
}

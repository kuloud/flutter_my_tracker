import 'dart:io';

import 'package:background_locator_2/keys.dart';

class Position {
  static const String ARG_ID = 'id';

  int? id;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;
  final double time;
  final bool isMocked;
  final String provider;

  Position(
      {this.id,
      required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.altitude,
      required this.speed,
      required this.speedAccuracy,
      required this.heading,
      required this.time,
      required this.isMocked,
      required this.provider});

  factory Position.fromJson(Map<dynamic, dynamic> json) {
    bool isLocationMocked =
        Platform.isAndroid ? (json[Keys.ARG_IS_MOCKED] == 1) : false;

    final p = Position(
      id: json[ARG_ID],
      latitude: json[Keys.ARG_LATITUDE],
      longitude: json[Keys.ARG_LONGITUDE],
      accuracy: json[Keys.ARG_ACCURACY],
      altitude: json[Keys.ARG_ALTITUDE],
      speed: json[Keys.ARG_SPEED],
      speedAccuracy: json[Keys.ARG_SPEED_ACCURACY],
      heading: json[Keys.ARG_HEADING],
      time: json[Keys.ARG_TIME],
      isMocked: isLocationMocked,
      provider: json[Keys.ARG_PROVIDER],
    );
    return p;
  }

  Map<String, dynamic> toJson() {
    return {
      ARG_ID: id,
      Keys.ARG_LATITUDE: latitude,
      Keys.ARG_LONGITUDE: longitude,
      Keys.ARG_ACCURACY: accuracy,
      Keys.ARG_ALTITUDE: altitude,
      Keys.ARG_SPEED: speed,
      Keys.ARG_SPEED_ACCURACY: speedAccuracy,
      Keys.ARG_HEADING: heading,
      Keys.ARG_TIME: time,
      Keys.ARG_IS_MOCKED: isMocked,
      Keys.ARG_PROVIDER: provider,
    };
  }
}

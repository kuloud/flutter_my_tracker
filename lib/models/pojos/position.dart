import 'package:geolocator/geolocator.dart';

class KPosition extends Position {
  int? id;

  KPosition(
      {this.id,
      required super.longitude,
      required super.latitude,
      required super.timestamp,
      required super.accuracy,
      required super.altitude,
      required super.altitudeAccuracy,
      required super.heading,
      required super.headingAccuracy,
      required super.speed,
      required super.speedAccuracy});
}

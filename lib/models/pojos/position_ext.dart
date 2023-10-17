import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:geolocator/geolocator.dart';

extension PositionExt on Position {
  KPosition copyWith({int? id}) {
    return KPosition(
        id: id,
        longitude: longitude,
        latitude: latitude,
        timestamp: timestamp,
        accuracy: accuracy,
        altitude: altitude,
        altitudeAccuracy: altitudeAccuracy,
        heading: heading,
        headingAccuracy: headingAccuracy,
        speed: speed,
        speedAccuracy: speedAccuracy);
  }
}

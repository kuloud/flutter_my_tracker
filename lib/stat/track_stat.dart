import 'dart:math';

import 'package:flutter_my_tracker/calc/distance_calc.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class TrackStat {
  int positionsCount = 0;
  double minSpeed = double.infinity;
  double maxSpeed = 0;
  double minAltitude = double.infinity;
  double maxAltitude = 0;
  double totalDistance = 0;

  double startTime = double.infinity;
  double endTime = 0;
  double totalTime = 0;

  Position? lastPosition;

  TrackStat addPosition(Position position) {
    positionsCount++;
    minSpeed = (minSpeed != double.infinity)
        ? min(minSpeed, position.speed)
        : position.speed;
    maxSpeed = max(maxSpeed, position.speed);
    minAltitude = (minAltitude != double.infinity)
        ? min(minAltitude, position.altitude)
        : position.altitude;
    maxAltitude = max(maxAltitude, position.altitude);
    startTime = (startTime != double.infinity)
        ? min(startTime, position.time)
        : position.time;
    endTime = max(endTime, position.time);
    totalTime = endTime - startTime;
    if (lastPosition != null) {
      totalDistance += calculateDistance(lastPosition!, position);
    }
    lastPosition = position;

    return this;
  }

  TrackStat addPositions(List<Position> positions) {
    positions.map((e) => addPosition(e));

    return this;
  }

  Map<String, dynamic> toPrintJson() {
    return {
      'positionsCount': positionsCount,
      'minSpeed': formatPace(minSpeed),
      'maxSpeed': formatPace(maxSpeed),
      'minAltitude': minAltitude,
      'maxAltitude': maxAltitude,
      // 'totalDistance': distanceFormat(totalDistance),
      'startTime': DateTime.fromMillisecondsSinceEpoch(startTime.toInt()),
      'endTime': DateTime.fromMillisecondsSinceEpoch(endTime.toInt()),
      'totalTime': formatMilliseconds(totalTime.toInt()),
    };
  }
}

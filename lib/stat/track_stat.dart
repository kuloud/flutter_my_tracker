import 'dart:math';

import 'package:flutter_my_tracker/calc/distance_calc.dart';
import 'package:flutter_my_tracker/models/enums/track_state.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class TrackStat {
  int? id;
  int positionsCount;
  double minSpeed;
  double maxSpeed;
  double minAltitude;
  double maxAltitude;
  double totalDistance;

  double startTime;
  double endTime;

  double totalTime;
  double avgSpeed;
  Position? lastPosition;

  TrackState state;

  TrackStat({
    this.id,
    this.positionsCount = 0,
    this.minSpeed = double.infinity,
    this.maxSpeed = 0,
    this.minAltitude = double.infinity,
    this.maxAltitude = 0,
    this.totalDistance = 0,
    this.startTime = double.infinity,
    this.avgSpeed = 0,
    this.endTime = 0,
    this.totalTime = 0,
    this.state = TrackState.unkonwn,
  });

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
    avgSpeed = 1000.0 * totalDistance / totalTime;
    lastPosition = position;

    return this;
  }

  void tick() {
    final now = double.parse('${DateTime.now().millisecondsSinceEpoch}');
    startTime = (startTime != double.infinity) ? min(startTime, now) : now;
    endTime = max(endTime, now);
    totalTime = endTime - startTime;
    avgSpeed = 1000.0 * totalDistance / totalTime;
  }

  TrackStat addPositions(List<Position> positions) {
    positions.map((e) => addPosition(e));

    return this;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'positionsCount': positionsCount,
      'minSpeed': minSpeed,
      'maxSpeed': maxSpeed,
      'minAltitude': minAltitude,
      'maxAltitude': maxAltitude,
      'totalDistance': totalDistance,
      'startTime': startTime.toInt(),
      'endTime': endTime.toInt(),
      'totalTime': totalTime,
      'avgSpeed': avgSpeed,
      'state': state.name,
    };
  }

  factory TrackStat.fromJson(Map<dynamic, dynamic> json) {
    return TrackStat(
      id: json['id'],
      positionsCount: json['positionsCount'],
      minSpeed: json['minSpeed'],
      maxSpeed: json['maxSpeed'],
      minAltitude: json['minAltitude'],
      maxAltitude: json['maxAltitude'],
      totalDistance: json['totalDistance'],
      startTime: double.parse('${json['startTime']}'),
      endTime: double.parse('${json['endTime']}'),
      totalTime: json['totalTime'],
      avgSpeed: json['avgSpeed'],
      state: TrackState.getTypeByName(json['state']),
    );
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
      'state': state.name
    };
  }
}

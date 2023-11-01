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

  List<Position>
      positionBuffer; // Buffer to store last 3 seconds of speed values
  double currentSpeed = 0;

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
  }) : positionBuffer = [];

  TrackStat addPosition(Position position) {
    positionsCount++;

    _refreshPositionBuffer(position);

    /// android上provider为'network和'gps'，基站定位点没有速度信息，
    /// ios上provider为''
    if ('network' != position.provider) {
      _updateByPositionWithSpeed(position);
    } else {
      // 按3s内定位点计算速度均值
      currentSpeed = _currentSpeedFromBuffer();
    }

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

  void _updateByPositionWithSpeed(Position position) {
    positionBuffer.add(position);

    if (position.speedAccuracy < 0.01) {
      // 定位点精度小于0.1 m/s, 使用定位点速度
      currentSpeed = position.speed;
    } else {
      // 按3s内定位点计算速度均值
      currentSpeed = _currentSpeedFromBuffer();
    }

    minSpeed = (minSpeed != double.infinity)
        ? min(minSpeed, currentSpeed)
        : currentSpeed;
    maxSpeed = max(maxSpeed, currentSpeed);
    minAltitude = (minAltitude != double.infinity)
        ? min(minAltitude, position.altitude)
        : position.altitude;
    maxAltitude = max(maxAltitude, position.altitude);
  }

  void _refreshPositionBuffer(Position position) {
    const double bufferTimeLimit = 3000; // 3 seconds

    while (positionBuffer.isNotEmpty &&
        position.time - positionBuffer.first.time > bufferTimeLimit) {
      positionBuffer.removeAt(0);
    }
  }

  double _currentSpeedFromBuffer() {
    return positionBuffer.isNotEmpty
        ? positionBuffer
                .map(
                  (e) => e.speed,
                )
                .reduce((a, b) => a + b) /
            positionBuffer.length
        : 0;
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

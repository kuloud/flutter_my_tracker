import 'dart:math';

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/color.dart';
import 'package:vector_math/vector_math_64.dart';

extension PositionExtension on Position {
  Point3D toPoint3D() {
    return Point3D(
      toVector3(),
      color: generateSpeedColor(speed),
    );
  }

  Vector3 toVector3() {
    return Vector3(
      longitude,
      altitude * 0.000009, // 海拔密度和经纬度拉齐，否则D3D显示会因为坐标系问题显示异常
      latitude,
    );
  }
}

extension IterablePoint3DExtension on Iterable<Point3D> {
  Iterable<Line3D> bottomGrid() sync* {
    final positions = map((e) => e.position);
    var bounds = Aabb3.minMax(positions.first, positions.first);
    for (var p in positions) {
      bounds.hullPoint(p);
    }
    final size = max(bounds.max.x - bounds.min.x, bounds.max.z - bounds.min.z);
    const num = 6;
    final interval = size / num / 2;
    for (var i = -num; i <= num; i++) {
      yield Line3D(
          Vector3.copy(bounds.center)
            ..x += i * interval
            ..z += -num * interval
            ..y = bounds.min.y,
          Vector3.copy(bounds.center)
            ..x += i * interval
            ..z += num * interval
            ..y = bounds.min.y,
          color: m.Colors.grey.withOpacity(0.1));
      yield Line3D(
          Vector3.copy(bounds.center)
            ..x += -num * interval
            ..z += i * interval
            ..y = bounds.min.y,
          Vector3.copy(bounds.center)
            ..x += num * interval
            ..z += i * interval
            ..y = bounds.min.y,
          color: m.Colors.grey.withOpacity(0.1));
    }
    final bottomCenter = Vector3.copy(bounds.center)..y = bounds.min.y;
    yield Line3D(Vector3.copy(bottomCenter),
        Vector3.copy(bottomCenter)..x += num * interval,
        width: 2, color: m.Colors.green);
    yield Line3D(Vector3.copy(bottomCenter),
        Vector3.copy(bottomCenter)..z += num * interval,
        width: 2, color: m.Colors.blue);
    yield Line3D(Vector3.copy(bottomCenter),
        Vector3.copy(bottomCenter)..y = num * interval,
        width: 2, color: m.Colors.red);
  }
}

import 'package:flutter_my_tracker/calc/distance_calc.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

/// m/s
double getAvgSpeed(List<Position> sortedPoints) {
  double totalDistance = 0;
  double totalTime = 0;

  // 遍历每个点
  for (int i = 0; i < sortedPoints.length - 1; i++) {
    Position currentPoint = sortedPoints[i];
    Position nextPoint = sortedPoints[i + 1];

    // 计算两点之间的距离（使用经纬度计算公式，例如 Haversine 公式）
    double distance = calculateDistance(currentPoint, nextPoint);

    // 累加距离
    totalDistance += distance;

    // 计算两点之间的时间差（假设时间以毫秒为单位）
    double timeDifference = nextPoint.time - currentPoint.time;

    // 累加时间
    totalTime += timeDifference;
  }

  double avgSpeed = 1000 * totalDistance / totalTime;

  return avgSpeed;
}

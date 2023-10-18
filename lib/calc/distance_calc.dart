import 'dart:math';

import 'package:flutter_my_tracker/models/pojos/position.dart';

double calculateTrajectoryDistance(List<Position> gpsPoints) {
  int degree = 2; // 多项式的阶数
  List<double> coefficients = polynomialFit(gpsPoints, degree);
  double fittingDistance = calculateFittingDistance(gpsPoints, coefficients);
  print('Fitting Distance: $fittingDistance');
  return fittingDistance;
}

List<double> polynomialFit(List<Position> gpsPoints, int degree) {
  List<double> x = [];
  List<double> y = [];

  for (int i = 0; i < gpsPoints.length; i++) {
    x.add(i.toDouble());
    y.add(calculateDistance(gpsPoints[i], gpsPoints[0]));
  }

  int n = x.length;
  List<double> coefficients = [];

  for (int i = 0; i <= degree; i++) {
    double sumX = 0;
    double sumY = 0;
    for (int j = 0; j < n; j++) {
      sumX += pow(x[j], i);
      sumY += y[j] * pow(x[j], i);
    }
    coefficients.add(sumY / sumX);
  }

  return coefficients;
}

double calculateFittingDistance(
    List<Position> gpsPoints, List<double> coefficients) {
  double fittingDistance = 0;

  for (int i = 0; i < gpsPoints.length; i++) {
    double fittedValue = 0;
    for (int j = 0; j < coefficients.length; j++) {
      fittedValue += coefficients[j] * pow(i.toDouble(), j);
    }
    fittingDistance +=
        (fittedValue - calculateDistance(gpsPoints[i], gpsPoints[0])).abs();
  }

  return fittingDistance;
}

double calculateDistance(Position point1, Position point2) {
  double earthRadius = 6371; // 地球半径，单位为千米

  double lat1 = point1.latitude * pi / 180;
  double lon1 = point1.longitude * pi / 180;
  double lat2 = point2.latitude * pi / 180;
  double lon2 = point2.longitude * pi / 180;

  double deltaLat = lat2 - lat1;
  double deltaLon = lon2 - lon1;

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  distance = (distance * 10000) / 10;
  return distance;
}

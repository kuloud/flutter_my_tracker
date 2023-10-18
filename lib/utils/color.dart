import 'package:flutter/material.dart';

List<Color> generateGradientColors(double pace) {
  double normalizedPace = pace / 10; // 将配速标准化到 0-1 范围内
  Color green = Colors.green;
  Color yellow = Colors.yellow;
  Color red = Colors.red;

  return [
    Color.lerp(green, yellow, normalizedPace)!,
    Color.lerp(yellow, red, normalizedPace)!,
  ];
}

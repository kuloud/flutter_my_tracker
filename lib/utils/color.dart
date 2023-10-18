import 'dart:math';

import 'package:flutter/material.dart';

/// m/s
Color generateSpeedColor(double speed) {
  if (speed > 3) {
    // 快速跑
    double normalizedPace = (min(speed, 4.5) - 3) * 0.66;
    return Color.lerp(Colors.yellow, Colors.red, normalizedPace)!;
  } else if (speed > 0.5) {
    double normalizedPace = (max(speed, 0.5) - 0.5) * 0.4;
    return Color.lerp(Colors.green, Colors.yellow, normalizedPace)!;
  } else {
    return const Color.fromARGB(255, 200, 200, 200);
  }
}

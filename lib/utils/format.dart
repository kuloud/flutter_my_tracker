import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:intl/intl.dart';

String formatMilliseconds(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr:$secondsStr';
}

String formatMillisecondsCN(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return (hours > 0)
      ? '$hours时$minutes分$seconds秒'
      : (minutes > 0)
          ? '$minutes分$seconds秒'
          : '$seconds秒';
}

String formatMillisecondsDateTime(int milliseconds) {
  return DateFormat('yyyy:MM:dd HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(milliseconds.toInt()));
}

Object distanceFormat(S s, double meters) {
  if (meters > 1000) {
    return '${dp(meters / 1000, 2)} ${s.unitKm}';
  }
  return '${meters.toInt()} ${s.unitM}';
}

double dp(double val, int places) {
  double mod = pow(10.0, places) as double;
  return ((val * mod).round().toDouble() / mod);
}

String formatPace(double speed) {
  if (speed <= 0 || speed == double.infinity || speed.isNaN) {
    return 'N/A';
  }
  int minutes = (1000 / speed / 60).floor();
  int seconds = (1000 / speed % 60).floor();

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  return '$minutesStr\'$secondsStr"';
}

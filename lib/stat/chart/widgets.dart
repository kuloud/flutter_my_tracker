import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildBottomTimeTitlesWidget(
    BuildContext context, int time, TitleMeta meta) {
  final axisSize = (meta.max - meta.min) / meta.appliedInterval;
  final currentIndex =
      (meta.axisPosition / meta.parentAxisSize * axisSize).floor();
  if (meta.axisPosition == 0 || meta.axisPosition == meta.parentAxisSize) {
    return Container();
  }
  if (axisSize > 7) {
    final ratio = (axisSize / 6).ceil();
    if ((currentIndex % ratio) != 0) {
      return Container();
    }
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(time)),
      style: Theme.of(context).textTheme.labelSmall,
    ),
  );
}

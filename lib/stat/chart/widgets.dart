import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildBottomTitlesWidget(
    BuildContext context, int seconds, TitleMeta meta) {
  String title = '';
  int intervalInSeconds = 60;
  String suffix = '';

  if (seconds <= 10 * 60) {
    intervalInSeconds = 60;
    suffix = '分';
  } else if (seconds <= 20 * 60) {
    intervalInSeconds = 5 * 50;
    suffix = '分';
  } else if (seconds <= 60 * 60) {
    intervalInSeconds = 10 * 60;
    suffix = '分';
  } else if (seconds <= 2 * 60 * 60) {
    intervalInSeconds = 30 * 60;
    suffix = '分';
  } else {
    intervalInSeconds = 60 * 60;
    suffix = '小时';
  }

  if (seconds > 0 && seconds % intervalInSeconds == 0) {
    title =
        '${((seconds / intervalInSeconds) * (intervalInSeconds / 60)).toInt()}$suffix';
  }

  return SideTitleWidget(
    fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
    axisSide: meta.axisSide,
    child: Text(
      title,
      style: Theme.of(context).textTheme.labelSmall,
    ),
  );
}

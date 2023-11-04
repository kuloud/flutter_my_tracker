import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

Widget buildBottomTimeTitlesWidget(
    BuildContext context, int index, TitleMeta meta, int size, int unit) {
  String title = '';
  int intervalInSeconds = 60;
  int value = index;
  double? hValue;
  String suffix = S.of(context).min;
  // logger.d('[buildBottomTimeTitlesWidget]: $index $size');

  if (size <= 10 * unit) {
    intervalInSeconds = 1 * unit;
  } else if (size <= 20 * unit) {
    intervalInSeconds = 5 * unit;
  } else if (size <= 60 * unit) {
    intervalInSeconds = 10 * unit;
  } else {
    intervalInSeconds = 60 * unit;
    value = index ~/ 60;
    if (index >= 60 * (60 * unit)) {
      hValue = dp(1.0 * value / 60 / unit, 1);
      suffix = S.of(context).hour;
    }
  }

  if (index % intervalInSeconds == 0) {
    title = '${hValue ?? (value ~/ unit)}$suffix';
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

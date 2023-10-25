import 'package:ditredi/ditredi.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/calc/speed_calc.dart';
import 'package:flutter_my_tracker/calc/stat_calc.dart';
import 'package:flutter_my_tracker/calc/time_calc.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/region_summary_data.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/chart/gradient_colors.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class BarChartRegionSummary extends StatefulWidget {
  const BarChartRegionSummary({super.key, required this.trackStats});

  final List<TrackStat> trackStats;

  @override
  State<BarChartRegionSummary> createState() => _BarChartRegionSummaryState();
}

class _BarChartRegionSummaryState extends State<BarChartRegionSummary> {
  late RegionSummaryData summaryData;
  late BarChartData data;
  // TODO 选择时间、距离 自动切换图表视图
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    buildChartData();
  }

  void buildChartData() {
    summaryData = summaryTrackStat(widget.trackStats);
    final groupTrackStats = groupTracksByDay(widget.trackStats);

    data = BarChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(
          show: false,
        ),
        titlesData: const FlTitlesData(
            topTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            rightTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            ))),
        barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
                distanceFormat(S.of(context), rod.toY),
                Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: commonGradientColors.first));
          },
        )),
        barGroups: groupTrackStats
            .mapIndexed((g, i) => BarChartGroupData(
                groupVertically: true, x: i + 1, barRods: getBarRods(g)))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CardTitleBar(
            title: S.of(context).altitude,
            subtitle: S.of(context).unit(S.of(context).meter),
            items: [
              {
                'title': '${dp(summaryData.minAltitude, 1)}',
                'label': S.of(context).minAltitude,
              },
              {
                'title': '${dp(summaryData.maxAltitude, 1)}',
                'label': S.of(context).maxAltitude,
              }
            ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              data,
            ),
          ),
        ),
      ]),
    );
  }

  List<BarChartRodData> getBarRods(List<TrackStat> g) {
    double totalDistance = 0;
    return g.mapIndexed((e, i) {
      final rodData = BarChartRodData(
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: commonGradientColors,
          ),
          fromY: totalDistance,
          toY: totalDistance + e.totalDistance);
      totalDistance += e.totalDistance;
      return rodData;
    }).toList();
  }
}

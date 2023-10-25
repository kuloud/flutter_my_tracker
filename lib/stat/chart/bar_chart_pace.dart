import 'package:ditredi/ditredi.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/calc/speed_calc.dart';
import 'package:flutter_my_tracker/calc/time_calc.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class BarChartPace extends StatefulWidget {
  const BarChartPace(
      {super.key, required this.trackStat, required this.points});

  final TrackStat trackStat;
  final List<Position> points;

  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<BarChartPace> createState() => _BarChartPaceState();
}

class _BarChartPaceState extends State<BarChartPace> {
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  late BarChartData data;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    try {
      buildChartData();
    } catch (e) {}
  }

  void buildChartData() {
    final startTime = widget.trackStat.startTime.toInt() / 1000; // s
    final endTime = widget.trackStat.endTime.toInt() / 1000; // s
    final maxAltitude = widget.trackStat.maxAltitude; // 米
    final minAltitude = widget.trackStat.minAltitude; // 米

    final groupPoints = groupPointsByMinute(widget.points);

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
                formatPace(rod.toY),
                Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: gradientColors.first));
          },
        )),
        barGroups: groupPoints
            .mapIndexed((e, i) =>
                BarChartGroupData(groupVertically: true, x: i, barRods: [
                  BarChartRodData(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: gradientColors,
                      ),
                      fromY: 0,
                      toY: dp(getAvgSpeed(e), 1))
                ]))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CardTitleBar(
            title: S.of(context).pace,
            subtitle: S.of(context).unit(S.of(context).minutePerKilometer),
            items: [
              {
                'title': formatPace(widget.trackStat.minSpeed),
                'label': S.of(context).minPace,
              },
              {
                'title': formatPace(widget.trackStat.maxSpeed),
                'label': S.of(context).maxPace,
              }
            ]),
        Container(
          height: 200,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          // TODO: fl_chart 不支持水平条状图表
          child: AspectRatio(
            aspectRatio: 2,
            child: BarChart(data),
          ),
        )
      ]),
    );
  }
}

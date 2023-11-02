import 'package:ditredi/ditredi.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/calc/speed_calc.dart';
import 'package:flutter_my_tracker/calc/time_calc.dart';
import 'package:flutter_my_tracker/components/widgets/empty_view.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/chart/widgets.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class ChartPace extends StatefulWidget {
  const ChartPace({super.key, required this.trackStat, required this.points});

  final TrackStat trackStat;
  final List<Position> points;

  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<ChartPace> createState() => _ChartPaceState();
}

class _ChartPaceState extends State<ChartPace> {
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  BarChartData? _barChartData;
  LineChartData? _lineChartData;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    try {
      buildChartData();
    } catch (e) {
      //
      logger.w('[buildChartData]', error: e);
    }
  }

  void buildChartData() {
    final startTime = widget.trackStat.startTime.toInt() / 1000; // s

    final groupPoints = groupPointsByMinute(widget.points);

    final spots = widget.points.where((e) => 'network' != e.provider).map((e) {
      return FlSpot((e.time / 1000) - startTime, dp(e.speed, 1));
    }).toList();

    if (groupPoints.length > 60) {
      _lineChartData = LineChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(
            show: false,
          ),
          titlesData: _buildTitleData(groupPoints),
          lineBarsData: [
            LineChartBarData(
                isStrokeCapRound: true,
                spots: spots,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                dotData: const FlDotData(show: false))
          ]);
    } else {
      _barChartData = BarChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(
            show: false,
          ),
          titlesData: _buildTitleData(groupPoints),
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
                  BarChartGroupData(groupVertically: true, x: i + 1, barRods: [
                    BarChartRodData(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: gradientColors,
                        ),
                        fromY: 0,
                        toY: e.isNotEmpty ? dp(getAvgSpeed(e), 1) : 0)
                  ]))
              .toList());
    }
  }

  FlTitlesData _buildTitleData(List<List<Position>> groupPoints) {
    return FlTitlesData(
        topTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        leftTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
          getTitlesWidget: (value, titleMeta) => buildBottomTimeTitlesWidget(
              context, value.toInt(), titleMeta, groupPoints.length, 1),
        )));
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
          child: AspectRatio(
            aspectRatio: 2,
            child: _buildChart(),
          ),
        )
      ]),
    );
  }

  Widget _buildChart() {
    if (_barChartData != null) {
      return BarChart(_barChartData!);
    } else if (_lineChartData != null) {
      return LineChart(_lineChartData!);
    } else {
      return const EmptyView();
    }
  }
}

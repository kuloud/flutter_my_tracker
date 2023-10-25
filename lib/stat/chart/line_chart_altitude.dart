import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/chart/widgets.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class LineChartAltitude extends StatefulWidget {
  const LineChartAltitude(
      {super.key, required this.trackStat, required this.points});

  final TrackStat trackStat;
  final List<Position> points;

  @override
  State<LineChartAltitude> createState() => _LineChartAltitudeState();
}

class _LineChartAltitudeState extends State<LineChartAltitude> {
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  late LineChartData data;

  @override
  void initState() {
    super.initState();
    buildLineChartData();
  }

  void buildLineChartData() {
    final startTime = widget.trackStat.startTime.toInt() / 1000; // s
    final endTime = widget.trackStat.endTime.toInt() / 1000; // s
    final maxAltitude = widget.trackStat.maxAltitude; // 米
    final minAltitude = widget.trackStat.minAltitude; // 米

    final spots = widget.points.map((e) {
      return FlSpot(
          (e.time / 1000) - startTime, dp(e.altitude - minAltitude, 1));
    }).toList();

    data = LineChartData(
        titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              // axisNameWidget: Text('海拔'),
              sideTitles: SideTitles(
                  reservedSize: 40,
                  showTitles: false,
                  getTitlesWidget: buildLeftTitlesWidget),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                // axisNameWidget: Text('时间'),
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, titleMeta) =>
                  buildBottomTitlesWidget(context, value.toInt(), titleMeta),
            ))),
        lineBarsData: [
          LineChartBarData(
              isStrokeCapRound: true,
              spots: spots,
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              dotData: const FlDotData(show: false))
        ],
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false));
  }

  Widget buildLeftTitlesWidget(double value, TitleMeta meta) {
    return SideTitleWidget(
      fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
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
                'title': '${dp(widget.trackStat.minAltitude, 1)}',
                'label': S.of(context).minAltitude,
              },
              {
                'title': '${dp(widget.trackStat.maxAltitude, 1)}',
                'label': S.of(context).maxAltitude,
              }
            ]),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              data,
            ),
          ),
        )
      ]),
    );
  }
}

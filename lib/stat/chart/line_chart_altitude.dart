import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
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
      return FlSpot((e.time / 1000) - startTime, e.altitude - minAltitude);
    }).toList();

    data = LineChartData(
        titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: true)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: buildBottomTitlesWidget,
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
        borderData: FlBorderData(
            show: true, border: Border.all(color: Colors.blueGrey.shade200)));
  }

  Widget buildBottomTitlesWidget(double value, TitleMeta meta) {
    int seconds = value.toInt();
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
          '${(seconds / intervalInSeconds) * (intervalInSeconds / 60)}$suffix';
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1.70,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            data,
          ),
        ),
      ),
    );
  }
}

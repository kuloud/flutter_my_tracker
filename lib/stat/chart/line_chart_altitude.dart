import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/chart/widgets.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';

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
    final spots = widget.points.where((e) => 'network' != e.provider).map((e) {
      return FlSpot(e.time, dp(e.altitude, 1));
    }).toList();

    data = LineChartData(
        titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, titleMeta) {
                return buildBottomTimeTitlesWidget(
                    context, value.toInt(), titleMeta);
              },
            ))),
        lineBarsData: [
          LineChartBarData(
            isStrokeCapRound: true,
            spots: spots,
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          )
        ],
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false));
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

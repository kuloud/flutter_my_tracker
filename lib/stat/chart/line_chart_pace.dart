import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/card_title_bar.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

class LineChartPace extends StatefulWidget {
  const LineChartPace(
      {super.key, required this.trackStat, required this.points});

  final TrackStat trackStat;
  final List<Position> points;

  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<LineChartPace> createState() => _LineChartPaceState();
}

class _LineChartPaceState extends State<LineChartPace> {
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
    buildChartData();
  }

  void buildChartData() {
    final startTime = widget.trackStat.startTime.toInt() / 1000; // s
    final endTime = widget.trackStat.endTime.toInt() / 1000; // s
    final maxAltitude = widget.trackStat.maxAltitude; // 米
    final minAltitude = widget.trackStat.minAltitude; // 米

    final spots = widget.points.map((e) {
      return FlSpot(
          (e.time / 1000) - startTime, dp(e.altitude - minAltitude, 1));
    }).toList();

    data = BarChartData(
      titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            // axisNameWidget: Text('海拔'),
            sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                getTitlesWidget: buildLeftTitlesWidget),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              // axisNameWidget: Text('时间'),
              sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            getTitlesWidget: buildBottomTitlesWidget,
          ))),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CardTitleBar(title: '配速', subtitle: '(分/公里)', items: [
          {
            'title': formatPace(widget.trackStat.minSpeed),
            'label': '最低配速',
          },
          {
            'title': formatPace(widget.trackStat.maxSpeed),
            'label': '最高配速',
          }
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: AspectRatio(
            aspectRatio: 2,
            child: Center(
              child: Text('TODO'),
            )
            // BarChart(
            //   data,
            // )
            ,
          ),
        )
      ]),
    );
  }
}

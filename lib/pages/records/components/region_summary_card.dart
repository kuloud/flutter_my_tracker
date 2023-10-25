import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/region_summary_data.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class RegionSummaryCard extends StatefulWidget {
  const RegionSummaryCard({super.key, required this.trackStats});

  final List<TrackStat> trackStats;

  @override
  State<RegionSummaryCard> createState() => _RegionSummaryCardState();
}

class _RegionSummaryCardState extends State<RegionSummaryCard> {
  List<TrackStat>? selectedTrackStats;

  @override
  void initState() {
    super.initState();
    selectedTrackStats = widget.trackStats;
  }

  @override
  Widget build(BuildContext context) {
    final summary = selectedTrackStats!.fold<RegionSummaryData>(
        RegionSummaryData(totalTime: 0, totalDistance: 0, totalTimes: 0),
        (d, t) {
      d.totalTime += t.totalTime;
      d.totalDistance += t.totalDistance;
      d.totalTimes += 1;
      return d;
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatMilliseconds(summary.totalTime.toInt()),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              HighlightNumberText(
                text: distanceFormat(
                    S.of(context), double.parse('${summary.totalDistance}')),
                hightlightTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                textStyle: Theme.of(context).textTheme.labelSmall,
              ),
              HighlightNumberText(
                text: '${summary.totalTimes} ${S.of(context).workoutsTimes}',
                hightlightTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                textStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          // BarChart(BarChartData(barGroups: []))
        ],
      ),
    );
  }
}

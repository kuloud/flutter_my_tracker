import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/calc/stat_calc.dart';
import 'package:flutter_my_tracker/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/stat/chart/bar_chart_region_summary.dart';
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
  TrackStat? touchedTrackStat;

  @override
  void initState() {
    super.initState();
    selectedTrackStats = widget.trackStats;
  }

  @override
  Widget build(BuildContext context) {
    final summary = summaryTrackStat(selectedTrackStats ?? []);
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: touchedTrackStat != null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    formatMilliseconds(
                        (touchedTrackStat?.totalTime ?? summary.totalTime)
                            .toInt()),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: Center(
                      child: HighlightNumberText(
                        text: distanceFormat(
                            S.of(context),
                            double.parse(
                                '${touchedTrackStat?.totalDistance ?? summary.totalDistance}')),
                        hightlightTextStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                        textStyle: Theme.of(context).textTheme.labelSmall,
                      ),
                    )),
                Flexible(
                  fit: FlexFit.tight,
                  child: (touchedTrackStat == null)
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: HighlightNumberText(
                            text:
                                '${touchedTrackStat?.totalDistance ?? summary.totalTimes} ${S.of(context).workoutsTimes}',
                            hightlightTextStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold),
                            textStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      : const SizedBox(
                          width: 60,
                        ),
                )
              ],
            ),
          ),
        ),
        BarChartRegionSummary(
            trackStats: selectedTrackStats ?? [],
            onTrackStatTouch: (trackStat) {
              setState(() {
                touchedTrackStat = trackStat;
              });
            }),
      ],
    );
  }
}

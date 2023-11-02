import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/components/widgets/grid_tile_label_title.dart';
import 'package:flutter_my_tracker/calc/stat_calc.dart';
import 'package:flutter_my_tracker/components/widgets/highlighted_number_text.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/region_summary_data.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  Future<RegionSummaryData>? _recordFuture;

  @override
  void initState() {
    super.initState();

    _recordFuture = queryTotalSummary();
  }

  Future<RegionSummaryData> queryTotalSummary() async {
    // logger.d('-------queryTotalSummary');
    List<TrackStat> allTrackStats = await TrackStatProvider.instance().getAll();

    return summaryTrackStat(allTrackStats);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recordFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final stat = snapshot.data!;
            final List<Map<String, String>> items = [
              {
                'title': formatMilliseconds(stat.totalTime.toInt()),
                'label': S.of(context).totalDuration
              },
              {
                'title': distanceFormat(
                    S.of(context), double.parse('${stat.totalDistance}')),
                'label': S.of(context).totalDistance
              },
            ];

            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 8),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).activitySummary,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          HighlightNumberText(
                            text: S.of(context).activityTimes(stat.totalTimes),
                            hightlightTextStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold),
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 32,
                      ),
                      GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          children: items
                              .mapIndexed((e, i) => SkyGridTileLabelTitle(
                                    data: e,
                                    textAlign: CrossAxisAlignment.center,
                                  ))
                              .toList())
                    ]),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}

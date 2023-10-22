import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/components/grid_tile_label_title.dart';
import 'package:flutter_my_tracker/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/data/query/stat.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  Future<Map<String, dynamic>>? _recordFuture;

  @override
  void initState() {
    super.initState();

    _recordFuture = queryTotalSummary();
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
                'title': formatMilliseconds(stat['totalTime'].toInt()),
                'label': '总时长'
              },
              {
                'title': distanceFormat(S.of(context),
                    double.parse('${stat['totalDistance'] ?? 0}')),
                'label': '总距离'
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
                            '运动总结',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          HighlightNumberText(
                            text: '运动${stat['totalMotionTimes']}次',
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

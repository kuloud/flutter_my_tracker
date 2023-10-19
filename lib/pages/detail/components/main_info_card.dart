import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/index/components/grid_tile.dart';
import 'package:flutter_my_tracker/pages/index/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/pages/index/components/pace_gradient_bar.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class MainInfoCard extends StatelessWidget {
  const MainInfoCard({
    super.key,
    required this.trackStat,
  });

  final TrackStat trackStat;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'title': formatMilliseconds(trackStat.totalTime.toInt()),
        'label': '总时长'
      },
      {
        'title': formatPace(trackStat.avgSpeed ?? 0),
        'label': S.of(context).labelPace
      },
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: [
              HighlightNumberText(
                text:
                    '${distanceFormat(S.of(context), trackStat.totalDistance)}',
                hightlightTextStyle: Theme.of(context).textTheme.displayMedium,
                textStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: PaceGradientBar(),
          ),
          GridView.count(
              mainAxisSpacing: 8,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: items
                  .mapIndexed((e, i) => SkyGridTile(
                        data: e,
                        textAlign: _determineTextAlign(i),
                      ))
                  .toList())
        ]),
      ),
    );
    ;
  }

  TextAlign _determineTextAlign(int i) {
    return (i % 3 == 0)
        ? TextAlign.start
        : ((i % 3 == 1) ? TextAlign.center : TextAlign.end);
  }
}

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/components/grid_tile_label_title.dart';
import 'package:flutter_my_tracker/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/pages/index/components/pace_gradient_bar.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class MainInfoCard extends StatelessWidget {
  const MainInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
        bloc: BlocProvider.of<TrackStatCubit>(context, listen: false),
        builder: (context, state) {
          switch (state) {
            case TrackStatUpdated():
              final List<Map<String, String>> items = [
                {
                  'title':
                      formatMilliseconds(state.trackStat.totalTime.toInt()),
                  'label': '总时长'
                },
                {
                  'title': formatPace(state.trackStat.lastPosition?.speed ?? 0),
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
                          text: distanceFormat(
                              S.of(context), state.trackStat.totalDistance),
                          hightlightTextStyle:
                              Theme.of(context).textTheme.displayMedium,
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
                            .mapIndexed((e, i) => SkyGridTileLabelTitle(
                                  data: e,
                                  textAlign: _determineTextAlign(i),
                                ))
                            .toList())
                  ]),
                ),
              );
            default:
              return const SizedBox();
          }
        });
  }

  CrossAxisAlignment _determineTextAlign(int i) {
    return (i % 3 == 0)
        ? CrossAxisAlignment.start
        : ((i % 3 == 1) ? CrossAxisAlignment.center : CrossAxisAlignment.end);
  }
}

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/index/components/grid_tile.dart';
import 'package:flutter_my_tracker/pages/index/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/pages/index/components/pace_gradient_bar.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class RecentRecordCard extends StatelessWidget {
  const RecentRecordCard({
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
                // {'title': '0', 'label': S.of(context).labelStep},
                // {'title': '0', 'label': '总时长'}
              ];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${distanceFormat(S.of(context), state.trackStat.totalDistance)}, ${formatMillisecondsCN(state.trackStat.totalTime.toInt())}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '最近运动, ${formatMillisecondsDateTime(state.trackStat.startTime.toInt())}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '全部运动记录',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        )
                      ]),
                ),
              );
            default:
              return const SizedBox();
          }
        });
  }

  TextAlign _determineTextAlign(int i) {
    return (i % 3 == 0)
        ? TextAlign.start
        : ((i % 3 == 1) ? TextAlign.center : TextAlign.end);
  }
}

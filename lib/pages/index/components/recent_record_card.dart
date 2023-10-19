import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/enums/operation.dart';
import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:flutter_my_tracker/pages/index/components/grid_tile.dart';
import 'package:flutter_my_tracker/pages/index/components/highlighted_number_text.dart';
import 'package:flutter_my_tracker/pages/index/components/pace_gradient_bar.dart';
import 'package:flutter_my_tracker/pages/records/records_page.dart';
import 'package:flutter_my_tracker/providers/operation_record_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class RecentRecordCard extends StatefulWidget {
  const RecentRecordCard({
    super.key,
  });

  @override
  State<RecentRecordCard> createState() => _RecentRecordCardState();
}

class _RecentRecordCardState extends State<RecentRecordCard> {
  Future<TrackStat?>? _recordFuture;

  @override
  void initState() {
    super.initState();

    _recordFuture = TrackStatProvider.instance().getLastestTrackStat();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
      builder: (context, state) {
        if (state is TrackStatStop) {
          _recordFuture = TrackStatProvider.instance().getLastestTrackStat();
        }
        return FutureBuilder(
            future: _recordFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final stat = snapshot.data!;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 8),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${distanceFormat(S.of(context), stat.totalDistance)}, ${formatPace(stat.avgSpeed)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '最近运动, ${formatMillisecondsDateTime(stat.startTime.toInt())}',
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RecordsPage()),
                              );
                            },
                          )
                        ]),
                  ),
                );
              } else {
                return const SizedBox();
              }
            });
      },
    );
  }
}

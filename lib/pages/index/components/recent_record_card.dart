import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/detail/detail_page.dart';
import 'package:flutter_my_tracker/pages/records/records_page.dart';
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          trackStat: stat,
                                        )),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Text(
                                      '${distanceFormat(S.of(context), stat.totalDistance)}, 平均配速 ${formatPace(stat.avgSpeed)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Text(
                                      '最近运动, ${formatMillisecondsDateTime(stat.startTime.toInt())}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              '全部运动记录',
                              style: Theme.of(context).textTheme.titleMedium,
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

import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/detail/detail_page.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/pages/records/records_page.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class RecordListView extends StatefulWidget {
  const RecordListView({super.key, required this.data});

  final SubTabData data;

  @override
  State<RecordListView> createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: TrackStatProvider.instance().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final records = snapshot.data;
              return ListView.builder(
                  itemCount: records?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '${distanceFormat(S.of(context), records![index].totalDistance)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        trackStat: records![index],
                                      )),
                            );
                          },
                        ),
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/pages/records/components/summary_card.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/utils/format.dart';

class SummaryTabView extends StatelessWidget {
  const SummaryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FutureBuilder(
                future: TrackStatProvider.instance().getOldestTrackStat(),
                builder: (context, snapshot) {
                  var sinceTime = '';
                  if (snapshot.hasData) {
                    sinceTime = formatMillisecondsDate(
                        snapshot.data!.startTime.toInt());
                  }
                  return Text(
                    '$sinceTime至今',
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                }),
          ),
          const SummaryCard()
        ],
      ),
    );
  }
}

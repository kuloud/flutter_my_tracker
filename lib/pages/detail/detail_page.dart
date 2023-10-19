import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/detail/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.trackStat});

  final TrackStat trackStat;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();

    print('----${widget.trackStat.toPrintJson()}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
          actions: [],
        ),
        bottomSheet: Container(
          color: Theme.of(context).colorScheme.background,
          child: DraggableScrollableSheet(
            // maxChildSize: 0.6,
            // minChildSize: 0.4,
            minChildSize: 0.32,
            expand: false,
            snap: true,
            // snapSizes: const [0.4],
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MainInfoCard(
                        trackStat: widget.trackStat,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        body: SizedBox.expand(
            child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: TrajectoryPanel(
                    trackStat: widget.trackStat,
                  ),
                ),
              ],
            )
          ],
        )));
  }
}

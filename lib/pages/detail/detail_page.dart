import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/detail/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/color_label.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/stat/chart/line_chart_altitude.dart';
import 'package:flutter_my_tracker/stat/chart/chart_pace.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.trackStat});

  final TrackStat trackStat;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<List<Position>?>? _fetchTrackPoints;
  bool isAxisShow = false;

  @override
  void initState() {
    super.initState();
    _fetchTrackPoints = PositionProvider.instance().getAllPositions(
        startTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.startTime.toInt()),
        endTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.endTime.toInt()));
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
        ),
        bottomSheet: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
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
                      ),
                      FutureBuilder(
                          future: _fetchTrackPoints,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  ChartPace(
                                      trackStat: widget.trackStat,
                                      points: snapshot.data!),
                                  LineChartAltitude(
                                      trackStat: widget.trackStat,
                                      points: snapshot.data!)
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AspectRatio(
                aspectRatio: 1,
                child: TrajectoryPanel(
                  onAxisShow: (show) {
                    setState(() {
                      isAxisShow = show;
                    });
                  },
                  trackStat: widget.trackStat,
                ),
              ),
            ),
            if (isAxisShow)
              const Positioned(top: 0, right: 0, child: ColorLabels()),
          ],
        )));
  }
}

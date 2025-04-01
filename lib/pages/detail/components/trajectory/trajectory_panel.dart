
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({super.key, required this.trackStat, this.onAxisShow});

  final TrackStat trackStat;
  final Function(bool show)? onAxisShow;

  @override
  State<TrajectoryPanel> createState() => _TrajectoryPanelState();
}

class _TrajectoryPanelState extends State<TrajectoryPanel> {

  Future<List<Position>?>? _recordFuture;
  bool _showAxis = false;

  @override
  void initState() {
    super.initState();

    _recordFuture = PositionProvider.instance().getAllPositions(
        startTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.startTime.toInt()),
        endTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.endTime.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recordFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final positions = snapshot.data!;
            // if (positions.isNotEmpty) {
            //   final List<Model3D<Model3D<dynamic>>> lines = [];
            //   for (int i = 0; i < positions.length - 1; i++) {
            //     final start = positions[i].toPoint3D();
            //     final end = positions[i + 1].toPoint3D();
            //     lines.add(Line3D(start.position, end.position,
            //         color: end.color, width: 2));
            //   }
            //   _points.addAll(lines);
            //   if (_showAxis) {
            //     final points = snapshot.data!.map((e) => e.toPoint3D());
            //     _points.addAll(points.bottomGrid());
            //   }
            // } else {
            //   _points.addAll(
            //       _generateCubes().map((e) => e.toLines()).flatten().toList());
            // }

          return const SizedBox();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}


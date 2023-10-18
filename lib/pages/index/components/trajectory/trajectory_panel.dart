import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({Key? key}) : super(key: key);

  @override
  State<TrajectoryPanel> createState() => _TrajectoryPanelState();
}

class _TrajectoryPanelState extends State<TrajectoryPanel> {
  final List<Model3D<Model3D<dynamic>>> _points = [];

  final _controller = DiTreDiController(
    rotationX: -20,
    rotationY: 30,
    light: vector.Vector3(-0.5, -0.5, 0.5),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
        bloc: BlocProvider.of<TrackStatCubit>(context, listen: false),
        builder: (context, state) {
          switch (state) {
            case TrackStatUpdated():
              final p = state.trackStat.lastPosition;
              if (p != null) {
                _points.add(Point3D(
                  vector.Vector3(
                    p.latitude,
                    p.longitude,
                    p.altitude,
                  ),
                ));
              }

              return DiTreDiDraggable(
                controller: _controller,
                child: DiTreDi(
                  figures: _points,
                  controller: _controller,
                  config: const DiTreDiConfig(
                    defaultPointWidth: 4,
                    supportZIndex: false,
                  ),
                ),
              );
            default:
              _points.clear();
              return const SizedBox();
          }
        });
  }
}

Iterable<Point3D> _generatePoints() sync* {
  for (var x = -10; x < 10; x++) {
    for (var y = -20; y < 10; y++) {
      for (var z = -6; z < 10; z++) {
        yield Point3D(
          vector.Vector3(
            x.toDouble() * 2,
            y.toDouble() * 2,
            z.toDouble() * 2,
          ),
        );
      }
    }
  }
}

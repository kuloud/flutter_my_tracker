import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/render.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({super.key, required this.trackStat, this.onAxisShow});

  final TrackStat trackStat;
  final Function(bool show)? onAxisShow;

  @override
  State<TrajectoryPanel> createState() => _TrajectoryPanelState();
}

class _TrajectoryPanelState extends State<TrajectoryPanel> {
  final List<Model3D<Model3D<dynamic>>> _points = [];

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
    _controller.addListener(() {
      // logger.d(
      //     '---${_controller.rotationX},${_controller.rotationY},${_controller.rotationZ}');
      if (_showAxis != (_controller.rotationX != -90)) {
        widget.onAxisShow?.call(_controller.rotationX != -90);
        setState(() {
          _showAxis = _controller.rotationX != -90;
        });
      }
    });
  }

  final _controller =
      DiTreDiController(rotationX: -90, rotationY: 0, rotationZ: 0);

  vector.Vector3 createVector3(Position p) {
    return vector.Vector3(
      p.latitude,
      p.altitude * 0.000009,
      p.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recordFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            _points.clear();
            final positions = snapshot.data!;
            if (positions.isNotEmpty) {
              final List<Model3D<Model3D<dynamic>>> lines = [];
              for (int i = 0; i < positions.length - 1; i++) {
                final start = positions[i].toPoint3D();
                final end = positions[i + 1].toPoint3D();
                lines.add(Line3D(start.position, end.position,
                    color: end.color, width: 2));
              }
              _points.addAll(lines);
              if (_showAxis) {
                final points = snapshot.data!.map((e) => e.toPoint3D());
                _points.addAll(points.bottomGrid());
              }
            } else {
              _points.addAll(
                  _generateCubes().map((e) => e.toLines()).flatten().toList());
            }

            return DiTreDiDraggable(
              controller: _controller,
              child: DiTreDi(
                figures: _points,
                controller: _controller,
                config: const DiTreDiConfig(
                  defaultPointWidth: 4,
                  supportZIndex: true,
                ),
              ),
            );
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

Iterable<Cube3D> _generateCubes() sync* {
  final colors = [
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade300,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade500,
    Colors.lightBlue.shade600,
    Colors.lightBlue.shade700,
    Colors.lightBlue.shade800,
    Colors.lightBlue.shade900,
  ];

  const count = 4;
  for (var x = count; x > 0; x--) {
    for (var y = count; y > 0; y--) {
      for (var z = count; z > 0; z--) {
        yield Cube3D(
          0.9,
          vector.Vector3(
            x.toDouble(),
            y.toDouble(),
            z.toDouble(),
          ),
          color: colors[(colors.length - y) % colors.length].withOpacity(0.3),
        );
      }
    }
  }
}

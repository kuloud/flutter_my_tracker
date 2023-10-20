import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat_cubit.dart';
import 'package:flutter_my_tracker/location/location_service_repository.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/color.dart';
import 'package:flutter_my_tracker/utils/file.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({Key? key}) : super(key: key);

  @override
  State<TrajectoryPanel> createState() => _TrajectoryPanelState();
}

class _TrajectoryPanelState extends State<TrajectoryPanel>
    with WidgetsBindingObserver {
  final List<Model3D<Model3D<dynamic>>> _points = [];
  TrackStat? _trackStat;
  late final DateTime startTime;
  List<Position>? _cachePoints;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_trackStat != null) {
        PositionProvider.instance()
            .getAllPositions(
                startTime: DateTime.fromMillisecondsSinceEpoch(
                    _trackStat!.startTime.toInt()))
            .then((value) {
          _cachePoints = value;
        });
      }
    }
  }

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
          final cachePoints =
              _cachePoints?.map((e) => creatPoint3D(e)).toList();
          _cachePoints = null;
          if (cachePoints?.isNotEmpty ?? false) {
            _points.clear();
            _points.addAll(cachePoints!);
          }
          if (state is TrackStatUpdated) {
            _trackStat = state.trackStat;
            // 运动中
            final p = state.trackStat.lastPosition;
            if (p != null) {
              _points.add(creatPoint3D(p));
            }
          } else if (state is TrackStatStart) {
            _points.clear();
          } else if (state is TrackStatStop || state is TrackStatInitial) {
            _points.clear();
            _points.addAll(_generateCubes()
                .map((e) => e.toLines())
                .flatten()
                .map((e) => e.copyWith(color: Colors.lightBlue.withAlpha(30)))
                .toList());
          }

          return DiTreDiDraggable(
            controller: _controller,
            child: DiTreDi(
              figures: _points,
              controller: _controller,
              config: const DiTreDiConfig(
                defaultPointWidth: 2,
                supportZIndex: false,
              ),
            ),
          );
        });
  }

  Point3D creatPoint3D(Position p) {
    return Point3D(
      vector.Vector3(
        p.latitude,
        p.longitude,
        p.altitude,
      ),
      color: generateSpeedColor(p.speed),
    );
  }
}

Iterable<Cube3D> _generateCubes() sync* {
  final colors = [
    Colors.grey.shade200,
    Colors.grey.shade300,
    Colors.grey.shade400,
    Colors.grey.shade500,
    Colors.grey.shade600,
    Colors.grey.shade700,
    Colors.grey.shade800,
    Colors.grey.shade900,
  ];

  const count = 4;
  for (var x = count; x > 0; x--) {
    for (var y = count; y > 0; y--) {
      for (var z = count; z > 0; z--) {
        yield Cube3D(
          0.9,
          vector.Vector3(
            x.toDouble() * 2,
            y.toDouble() * 2,
            z.toDouble() * 2,
          ),
          color: colors[(colors.length - y) % colors.length],
        );
      }
    }
  }
}

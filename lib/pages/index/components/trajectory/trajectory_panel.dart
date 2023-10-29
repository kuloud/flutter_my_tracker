import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat/track_stat_cubit.dart';
import 'package:flutter_my_tracker/location/location_service_repository.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/color.dart';
import 'package:flutter_my_tracker/utils/file.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:flutter_my_tracker/utils/render.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({Key? key, this.isServiceRunning = false})
      : super(key: key);

  final bool isServiceRunning;

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
          if (mounted) {
            setState(() {
              _cachePoints = value;
            });
          }
        });
      }
    }
  }

  final _controller = DiTreDiController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
        builder: (context, state) {
      final cachePoints = _cachePoints?.map((e) => e.toPoint3D()).toList();
      _cachePoints = null;
      if (cachePoints?.isNotEmpty ?? false) {
        _points.clear();
        _points.addAll(cachePoints!);
      }
      // logger.d('[trackStat] state: $state');
      if (state is TrackStatUpdated) {
        _trackStat = state.trackStat;
        // 运动中
        final p = state.trackStat.lastPosition;
        if (p != null) {
          // logger.d('[trackStat] lastPosition: ${p.toJson()}');
          _points.add(p.toPoint3D());
        }
      } else if (state is TrackStatStart) {
        _points.clear();
      } else if (state is TrackStatStop || state is TrackStatInitial) {
        _points.clear();
        if (!widget.isServiceRunning) {
          _points.addAll(
              _generateCubes().map((e) => e.toLines()).flatten().toList());
        }
      }

      return DiTreDiDraggable(
        controller: _controller,
        child: DiTreDi(
          figures: _points,
          controller: _controller,
          config: const DiTreDiConfig(
            defaultPointWidth: 1,
            supportZIndex: true,
          ),
        ),
      );
    });
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

  const count = 3;
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
          color: colors[(colors.length - z) % colors.length].withOpacity(0.2),
        );
      }
    }
  }
}

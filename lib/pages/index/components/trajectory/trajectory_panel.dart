
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/track_stat/track_stat_cubit.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';

class TrajectoryPanel extends StatefulWidget {
  const TrajectoryPanel({super.key, this.isServiceRunning = false});

  final bool isServiceRunning;

  @override
  State<TrajectoryPanel> createState() => _TrajectoryPanelState();
}

class _TrajectoryPanelState extends State<TrajectoryPanel>
    with WidgetsBindingObserver {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackStatCubit, TrackStatState>(
        builder: (context, state) {
      // final cachePoints = _cachePoints?.map((e) => e.toPoint3D()).toList();
      // _cachePoints = null;
      // if (cachePoints?.isNotEmpty ?? false) {
      //   _points.clear();
      //   _points.addAll(cachePoints!);
      // }
      // // logger.d('[trackStat] state: $state');
      // if (state is TrackStatUpdated) {
      //   _trackStat = state.trackStat;
      //   // 运动中
      //   final p = state.trackStat.lastPosition;
      //   if (p != null) {
      //     // logger.d('[trackStat] lastPosition: ${p.toJson()}');
      //     _points.add(p.toPoint3D());
      //   }
      // } else if (state is TrackStatStart) {
      //   _points.clear();
      // } else if (state is TrackStatStop || state is TrackStatInitial) {
      //   _points.clear();
      //   if (!widget.isServiceRunning) {
      //     _points.addAll(
      //         _generateCubes().map((e) => e.toLines()).flatten().toList());
      //   }
      // }

      return SizedBox();
    });
  }
}


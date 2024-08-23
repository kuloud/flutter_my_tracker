import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/enums/track_state.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/services/tts_service.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/format.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

part 'track_stat_state.dart';

class TrackStatCubit extends Cubit<TrackStatState> {
  TrackStatCubit() : super(TrackStatInitial());

  TrackStat? _trackStat;
  final TtsService _ttsService = TtsService();

  /// 记录启动，只能被调用一次
  Future<bool> start(BuildContext context) async {
    try {
      _trackStat = await TrackStatProvider.instance().insert(TrackStat()
        ..startTime = double.parse('${DateTime.now().millisecondsSinceEpoch}')
        ..state = TrackState.started);
      emit(TrackStatStart());
      if (context.mounted) {
        _ttsService.speak(S.of(context).ttsStartRun);
      }

      return true;
    } catch (e) {
      logger.e('[TrackStatCubit] [start] error', error: e);
    }
    return false;
  }

  Future<bool> resume(TrackStat trackStat) async {
    try {
      _trackStat = trackStat;
      emit(TrackStatStart());
      return true;
    } catch (e) {
      logger.e('[TrackStatCubit] [start] error', error: e);
    }
    return false;
  }

  /// 记录过程中持续更新持久化
  update(Position position) async {
    try {
      // 应用恢复前台时的补充逻辑
      _trackStat ??= await TrackStatProvider.instance().getRunningTrackStat();

      if (_trackStat != null) {
        _trackStat?.addPosition(position);
        TrackStatProvider.instance().update(_trackStat!);
        emit(TrackStatUpdated(trackStat: _trackStat!));
      }
    } catch (e) {
      logger.e('[TrackStatCubit] [update] error', error: e);
    }
  }

  /// 结束本次记录
  stop(BuildContext context) {
    if (_trackStat != null) {
      try {
        if ((_trackStat?.totalDistance ?? 0) < 100) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).toastDistanceTooShort)));
          TrackStatProvider.instance()
              .update(_trackStat!..state = TrackState.ignored);
        } else {
          TrackStatProvider.instance()
              .update(_trackStat!..state = TrackState.finish);
          _ttsService.speak(S.of(context).ttsEndRun(
              distanceFormat(S.of(context), _trackStat!.totalDistance),
              formatMilliseconds(_trackStat!.totalTime.toInt())));
        }

        emit(TrackStatStop(trackStat: _trackStat!));
      } catch (e) {
        logger.e('[TrackStatCubit] [stop] error', error: e);
      }
    }

    _trackStat = null;
  }

  void tick() {
    if (_trackStat != null) {
      try {
        _trackStat!.tick();
        emit(TrackStatUpdated(trackStat: _trackStat!));
      } catch (e) {
        logger.e('[TrackStatCubit] [tick] error', error: e);
      }
    }
  }
}

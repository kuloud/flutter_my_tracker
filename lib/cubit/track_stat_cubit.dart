import 'package:bloc/bloc.dart';
import 'package:flutter_my_tracker/models/enums/track_state.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:meta/meta.dart';

part 'track_stat_state.dart';

class TrackStatCubit extends Cubit<TrackStatState> {
  TrackStatCubit() : super(TrackStatInitial());

  TrackStat? _trackStat;

  /// 记录启动，只能被调用一次
  Future<bool> start() async {
    try {
      _trackStat = await TrackStatProvider.instance().insert(TrackStat()
        ..startTime = double.parse('${DateTime.now().millisecondsSinceEpoch}')
        ..state = TrackState.started);
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
  stop() {
    if (_trackStat != null) {
      try {
        TrackStatProvider.instance()
            .update(_trackStat!..state = TrackState.finish);
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

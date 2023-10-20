import 'package:bloc/bloc.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'track_stat_state.dart';

class TrackStatCubit extends Cubit<TrackStatState> {
  TrackStatCubit() : super(TrackStatInitial());

  TrackStat? _trackStat;

  void start() {
    _trackStat = TrackStat();
    emit(TrackStatStart());
  }

  update(Position position) {
    _trackStat?.addPosition(position);
    if (_trackStat != null) {
      emit(TrackStatUpdated(trackStat: _trackStat!));
    }
  }

  stop() {
    if (_trackStat != null) {
      TrackStatProvider.instance().insert(_trackStat!);
      emit(TrackStatStop(trackStat: _trackStat!));
    }

    _trackStat = null;
  }

  void tick() {
    if (_trackStat != null) {
      _trackStat!.tick();
      emit(TrackStatUpdated(trackStat: _trackStat!));
    }
  }
}

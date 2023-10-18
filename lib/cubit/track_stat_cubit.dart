import 'package:bloc/bloc.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
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
    emit(TrackStatStop(trackStat: _trackStat!));
    _trackStat = null;
  }
}

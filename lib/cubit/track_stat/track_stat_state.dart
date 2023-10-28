part of 'track_stat_cubit.dart';

@immutable
sealed class TrackStatState {}

final class TrackStatInitial extends TrackStatState {}

final class TrackStatStart extends TrackStatState {}

final class TrackStatUpdated extends TrackStatState {
  final TrackStat trackStat;

  TrackStatUpdated({required this.trackStat});
}

final class TrackStatStop extends TrackStatState {
  final TrackStat trackStat;

  TrackStatStop({required this.trackStat});
}

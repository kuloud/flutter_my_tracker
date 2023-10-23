enum TrackState {
  unkonwn('unkonwn'),
  started('started'),
  finish('finish');

  const TrackState(this.name);

  final String name;

  static TrackState getTypeByName(String name) => TrackState.values
      .firstWhere((e) => e.name == name, orElse: () => TrackState.unkonwn);
}

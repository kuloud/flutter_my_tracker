enum LocationState {
  start('start'),
  end('end'),
  unknown('unknown');

  const LocationState(this.name);

  final String name;

  toJson() => name;

  static LocationState fromJson(String name) {
    return LocationState.values
        .firstWhere((e) => e.name == name, orElse: () => unknown);
  }
}

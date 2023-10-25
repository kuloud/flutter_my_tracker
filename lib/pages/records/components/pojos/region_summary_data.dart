class RegionSummaryData {
  double totalTime;
  double totalDistance;
  int totalTimes;
  double minAltitude;
  double maxAltitude;
  double minSpeed;
  double maxSpeed;

  RegionSummaryData({
    this.totalTime = 0,
    this.totalDistance = 0,
    this.totalTimes = 0,
    this.minAltitude = 0,
    this.maxAltitude = 0,
    this.minSpeed = 0,
    this.maxSpeed = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegionSummaryData &&
        other.totalTime == totalTime &&
        other.totalDistance == totalDistance &&
        other.totalTimes == totalTimes &&
        other.minAltitude == minAltitude &&
        other.maxAltitude == maxAltitude &&
        other.minSpeed == minSpeed &&
        other.maxSpeed == maxSpeed;
  }

  @override
  int get hashCode {
    return totalTime.hashCode ^
        totalDistance.hashCode ^
        totalTimes.hashCode ^
        minAltitude.hashCode ^
        maxAltitude.hashCode ^
        minSpeed.hashCode ^
        maxSpeed.hashCode;
  }

  @override
  String toString() {
    return '$totalTime $totalDistance $totalTimes $minAltitude $maxAltitude $minSpeed $maxSpeed';
  }
}

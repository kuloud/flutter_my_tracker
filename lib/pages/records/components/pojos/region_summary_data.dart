class RegionSummaryData {
  double totalTime;
  double totalDistance;
  int totalTimes;

  RegionSummaryData(
      {required this.totalTime,
      required this.totalDistance,
      required this.totalTimes});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegionSummaryData &&
        other.totalTime == totalTime &&
        other.totalDistance == totalDistance &&
        other.totalTimes == totalTimes;
  }

  @override
  int get hashCode {
    return totalTime.hashCode ^ totalDistance.hashCode ^ totalTimes.hashCode;
  }

  @override
  String toString() {
    return '$totalTime $totalDistance $totalTimes';
  }
}

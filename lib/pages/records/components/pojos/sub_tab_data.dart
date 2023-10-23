class SubTabData {
  String title;
  DateTime startDate;
  DateTime endDate;

  SubTabData(
      {required this.title, required this.startDate, required this.endDate});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubTabData &&
        other.title == title &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^ startDate.hashCode ^ endDate.hashCode;
  }

  @override
  String toString() {
    return '$title $startDate $endDate';
  }
}

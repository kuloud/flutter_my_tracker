class SubTabData {
  String title;
  DateTime startDate;
  DateTime endDate;

  SubTabData(
      {required this.title, required this.startDate, required this.endDate});

  @override
  String toString() {
    return '$title $startDate $endDate';
  }
}

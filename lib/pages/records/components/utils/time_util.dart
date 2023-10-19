import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:intl/intl.dart';

List<SubTabData> getWeekDataList(DateTime startDate, DateTime endDate) {
  List<SubTabData> weekDataList = [];

  DateTime currentStartDate = startDate;
  DateTime currentEndDate =
      getNextWeekStartDate(startDate).subtract(const Duration(days: 1));

  while (
      currentEndDate.isBefore(endDate) || !currentStartDate.isAfter(endDate)) {
    String title =
        '${DateFormat('M/d').format(currentStartDate)}-${DateFormat('M/d').format(currentEndDate)}';

    SubTabData weekData = SubTabData(
      title: title,
      startDate: currentStartDate,
      endDate: currentEndDate,
    );

    weekDataList.add(weekData);

    currentStartDate = getNextWeekStartDate(currentStartDate);
    currentEndDate = currentStartDate.add(const Duration(days: 6));
  }

  return weekDataList;
}

DateTime getNextWeekStartDate(DateTime date) {
  int daysUntilNextMonday = DateTime.monday - date.weekday + 7;
  DateTime nextMonday = date.add(Duration(days: daysUntilNextMonday));
  return DateTime(nextMonday.year, nextMonday.month, nextMonday.day);
}

List<SubTabData> getMonthDataList(DateTime startDate, DateTime endDate) {
  List<SubTabData> monthDataList = [];
  DateTime currentMonthStart = DateTime(startDate.year, startDate.month);

  while (currentMonthStart.isBefore(endDate)) {
    String month = DateFormat('M月').format(currentMonthStart);
    var currentMonthEnd =
        DateTime(currentMonthStart.year, currentMonthStart.month + 1)
            .subtract(const Duration(days: 1));
    SubTabData monthData = SubTabData(
        startDate: currentMonthStart,
        title: month.toString(),
        endDate: currentMonthEnd);
    monthDataList.add(monthData);
    currentMonthStart =
        DateTime(currentMonthStart.year, currentMonthStart.month + 1);
  }

  return monthDataList;
}

List<SubTabData> getYearDataList(DateTime startDate, DateTime endDate) {
  List<SubTabData> yearDataList = [];
  DateTime currentYearStart = DateTime(startDate.year);

  while (currentYearStart.isBefore(endDate)) {
    String year = DateFormat('yyyy').format(currentYearStart);
    var currentYearEnd =
        DateTime(currentYearStart.year + 1).subtract(const Duration(days: 1));
    SubTabData yearData = SubTabData(
        startDate: currentYearStart, title: year, endDate: currentYearEnd);
    yearDataList.add(yearData);
    currentYearStart = DateTime(currentYearStart.year + 1);
  }

  return yearDataList;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:intl/intl.dart';

SubTabData getWeekData(DateTime date) {
  final nextWeekStartDate = getNextWeekStartDate(date);

  DateTime currentStartDate =
      nextWeekStartDate.subtract(const Duration(days: 7));
  DateTime currentEndDate =
      getNextWeekStartDate(date).subtract(const Duration(seconds: 1));

  String title =
      '${DateFormat('M/d').format(currentStartDate)}-${DateFormat('M/d').format(currentEndDate)}';

  SubTabData weekData = SubTabData(
    title: title,
    startDate: currentStartDate,
    endDate: currentEndDate,
  );

  return weekData;
}

SubTabData getMonthData(String? locale, DateTime date) {
  DateTime currentMonthStart = DateTime(date.year, date.month);
  DateTime currentMonthEnd =
      DateTime(date.year, date.month + 1).subtract(const Duration(seconds: 1));
  logger.d('[getMonthData] $locale');

  String month = DateFormat('M', locale).format(currentMonthStart);
  SubTabData monthData = SubTabData(
      startDate: currentMonthStart,
      title: month.toString(),
      endDate: currentMonthEnd);

  return monthData;
}

SubTabData getYearData(DateTime date) {
  DateTime currentYearStart = DateTime(date.year);
  DateTime currentYearEnd =
      DateTime(date.year + 1).subtract(const Duration(seconds: 1));
  String year = DateFormat('yyyy').format(currentYearStart);
  SubTabData yearData = SubTabData(
      startDate: currentYearStart, title: year, endDate: currentYearEnd);

  return yearData;
}

List<SubTabData> getWeekDataList(DateTime startDate, DateTime endDate) {
  List<SubTabData> weekDataList = [];

  DateTime currentStartDate =
      DateTime(startDate.year, startDate.month, startDate.day);

  DateTime currentEndDate =
      getNextWeekStartDate(startDate).subtract(const Duration(seconds: 1));

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
    currentEndDate = currentStartDate
        .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
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
            .subtract(const Duration(days: 1))
            .add(const Duration(hours: 23, minutes: 59, seconds: 59));
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
    String year = DateFormat('yyyy年').format(currentYearStart);
    var currentYearEnd = DateTime(currentYearStart.year + 1)
        .subtract(const Duration(days: 1))
        .add(const Duration(hours: 23, minutes: 59, seconds: 59));
    SubTabData yearData = SubTabData(
        startDate: currentYearStart, title: year, endDate: currentYearEnd);
    yearDataList.add(yearData);
    currentYearStart = DateTime(currentYearStart.year + 1);
  }

  return yearDataList;
}

import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

List<List<Position>> groupPointsByMinute(List<Position> sortedPoints) {
  // 计算每分钟的毫秒数
  double millisecondsInMinute = 60 * 1000;

  int minutes = ((sortedPoints.last.time - sortedPoints.first.time) /
          millisecondsInMinute)
      .ceil();
  logger.d('[groupPointsByMinute] minutes: $minutes');
  List<List<Position>> groupPoints = List.generate(minutes, (index) => []);

  int i = 0;
  // 遍历每个点
  for (Position point in sortedPoints) {
    int currentMinutes =
        ((point.time - sortedPoints.first.time) / millisecondsInMinute).ceil();
    // logger
    //     .d('---- ${++i} ${sortedPoints.length} ${point.time} $currentMinutes');
    if (currentMinutes == 0) {
      logger.w('[groupPointsByMinute] same time.');
      currentMinutes = 1;
    }
    groupPoints[currentMinutes - 1].add(point);
  }

  // try {
  //   logger.d(
  //       '[groupPointsByMinute] groupPoints: ${groupPoints.map((e) => '${e.length} ${e.first.time}-${e.last.time}').toList()}');
  // } catch (e) {
  //   logger.w('[groupPointsByMinute]', error: e);
  // }
  return groupPoints;
}

List<List<TrackStat>> groupTracksByDay(List<TrackStat> sortedTrackStats) {
  if (sortedTrackStats.isEmpty) {
    return List.generate(0, (index) => []);
  }

  sortedTrackStats.sort((a, b) => a.startTime.compareTo(b.startTime));

  // 计算每分钟的毫秒数
  double millisecondsInDay = 24 * 60 * 60 * 1000;

  int days =
      ((sortedTrackStats.last.startTime - sortedTrackStats.first.startTime) /
              millisecondsInDay)
          .ceil();
  logger.d('[groupTracksByDay] days: $days');
  List<List<TrackStat>> groupPoints = List.generate(days, (index) => []);

  // 遍历每个点
  for (TrackStat point in sortedTrackStats) {
    int currentDays = ((point.startTime - sortedTrackStats.first.startTime) /
            millisecondsInDay)
        .ceil();
    // logger.d('---- ${point.time} $currentMinutes');
    if (currentDays == 0) {
      logger.w('[groupTracksByDay] same time.');
      currentDays = 1;
    }
    groupPoints[currentDays - 1].add(point);
  }

  // logger.d(
  //     '[groupTracksByDay] groupPoints: ${groupPoints.map((e) => '${e.length} ${e.first.startTime}-${e.last.startTime}').toList()}');
  return groupPoints;
}

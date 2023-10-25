import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

List<List<Position>> groupPointsByMinute(List<Position> sortedPoints) {
  // 计算每分钟的毫秒数
  double millisecondsInMinute = 60 * 1000;

  int minutes = ((sortedPoints.last.time - sortedPoints.first.time) /
          millisecondsInMinute)
      .ceil();
  logger.d('[groupPointsByMinute] minutes: $minutes');
  List<List<Position>> groupPoints = List.generate(minutes, (index) => []);

  // 遍历每个点
  for (Position point in sortedPoints) {
    int currentMinutes =
        ((point.time - sortedPoints.first.time) / millisecondsInMinute).ceil();
    logger.d('---- ${point.time} $currentMinutes');
    if (currentMinutes == 0) {
      logger.w('[groupPointsByMinute] same time.');
      currentMinutes = 1;
    }
    groupPoints[currentMinutes - 1].add(point);
  }

  logger.d(
      '[groupPointsByMinute] groupPoints: ${groupPoints.map((e) => '${e.length} ${e.first.time}-${e.last.time}').toList()}');
  return groupPoints;
}

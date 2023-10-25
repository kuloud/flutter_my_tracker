import 'package:flutter_my_tracker/providers/track_stat_provider.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

Future<int> queryTotalMotionTimes() async {
  return 0;
}

Future<double> queryTotalTime() async {
  return 0;
}

Future<double> queryTotalDistance() async {
  return 0;
}

Future<Map<String, dynamic>> queryTotalSummary() async {
  // logger.d('-------queryTotalSummary');
  List<TrackStat> allTrackStats = await TrackStatProvider.instance().getAll();
  // logger.d('-------${allTrackStats}');
  int totalMotionTimes = allTrackStats.length;
  double totalTime =
      allTrackStats.fold(0, (sum, trackStat) => sum + trackStat.totalTime);
  double totalDistance =
      allTrackStats.fold(0, (sum, trackStat) => sum + trackStat.totalDistance);

  return {
    'totalMotionTimes': totalMotionTimes,
    'totalTime': totalTime,
    'totalDistance': totalDistance
  };
}

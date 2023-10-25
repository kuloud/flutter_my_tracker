import 'package:flutter_my_tracker/pages/records/components/pojos/region_summary_data.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';

RegionSummaryData summaryTrackStat(List<TrackStat> trackStats) {
  return trackStats.fold<RegionSummaryData>(RegionSummaryData(), (d, t) {
    d.totalTime += t.totalTime;
    d.totalDistance += t.totalDistance;
    d.totalTimes += 1;
    return d;
  });
}

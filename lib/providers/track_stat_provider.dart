import 'package:flutter_my_tracker/models/enums/operation.dart';
import 'package:flutter_my_tracker/models/enums/track_state.dart';
import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/pages/records/components/utils/time_util.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TrackStatProvider {
  Database? _database;
  bool isCreated = false;

  TrackStatProvider._internal();

  static TrackStatProvider? _instance;

  factory TrackStatProvider.instance() {
    _instance ??= TrackStatProvider._internal();
    return _instance!;
  }

  Future<void> open() async {
    if (_database == null) {
      String path = await getDatabasesPath();
      String dbPath = join(path, 'track_stats_database.db');
      _database = await openDatabase(
        dbPath,
        version: 2,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE track_stats (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              positionsCount INTEGER,
              minSpeed REAL,
              maxSpeed REAL,
              minAltitude REAL,
              maxAltitude REAL,
              totalDistance REAL,
              startTime INTEGER,
              endTime INTEGER,
              totalTime REAL,
              avgSpeed REAL,
              state TEXT,
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            // 版本 2 添加 state，持久化Tracker状态，历史记录默认变成已完成状态
            await db.execute(
                'ALTER TABLE track_stats ADD COLUMN state TEXT DEFAULT "${TrackState.finish.name}"');
          }
        },
      );
    }
  }

  Future<TrackStat?> getRunningTrackStat() async {
    return await getLastestTrackStatByState(TrackState.started);
  }

  Future<TrackStat> insert(TrackStat trackStat) async {
    await open();
    trackStat.id = await _database!.insert('track_stats', trackStat.toJson());
    return trackStat;
  }

  Future<TrackStat> update(TrackStat trackStat) async {
    await open();
    await _database!.update(
      'track_stats',
      trackStat.toJson(),
      where: 'id = ?',
      whereArgs: [trackStat.id],
    );
    return trackStat;
  }

  @Deprecated("use getLastestFinishedTrackStat")
  Future<TrackStat?> getLastestTrackStat() async {
    return getLastestTrackStatByState(TrackState.finish);
  }

  Future<TrackStat?> getLastestFinishedTrackStat() async {
    return getLastestTrackStatByState(TrackState.finish);
  }

  Future<TrackStat?> getLastestTrackStatByState(TrackState state) async {
    await open();
    List<Map<String, dynamic>> maps = await _database!.query('track_stats',
        where: 'state = ?',
        whereArgs: [state.name],
        limit: 1,
        orderBy: 'startTime DESC');
    if (maps.isNotEmpty) {
      return TrackStat.fromJson(maps.first);
    }
    return null;
  }

  Future<TrackStat?> getOldestTrackStat() async {
    await open();
    List<Map<String, dynamic>> maps = await _database!.query('track_stats',
        where: 'state = ?',
        whereArgs: [TrackState.finish.name],
        limit: 1,
        orderBy: 'startTime ASC');
    if (maps.isNotEmpty) {
      return TrackStat.fromJson(maps.first);
    }
    return null;
  }

  Future<List<TrackStat>> getAll(
      {DateTime? startTime, DateTime? endTime}) async {
    await open();

    logger.d('[TrackStat] getAll, startTime: $startTime, endTime; $endTime');
    List<Map<String, dynamic>>? maps;
    if (startTime != null && endTime != null) {
      maps = await _database?.query('track_stats',
          where: 'startTime >= ? AND startTime <= ? AND state = ?',
          whereArgs: [
            startTime.millisecondsSinceEpoch,
            endTime.millisecondsSinceEpoch,
            TrackState.finish.name
          ],
          orderBy: 'startTime DESC');
    } else if (startTime != null) {
      maps = await _database?.query('track_stats',
          where: 'startTime >= ? AND state = ?',
          whereArgs: [startTime.millisecondsSinceEpoch, TrackState.finish.name],
          orderBy: 'startTime DESC');
    } else if (endTime != null) {
      maps = await _database?.query('track_stats',
          where: 'startTime <= ? AND state = ?',
          whereArgs: [endTime.millisecondsSinceEpoch, TrackState.finish.name],
          orderBy: 'startTime DESC');
    } else {
      maps = await _database?.query('track_stats',
          where: 'state = ?',
          whereArgs: [TrackState.finish.name],
          orderBy: 'startTime DESC');
    }
    if (maps?.isEmpty ?? true) {
      return [];
    }

    return List.generate(maps!.length, (i) {
      return TrackStat(
        id: maps![i]['id'],
        positionsCount: maps[i]['positionsCount'],
        minSpeed: maps[i]['minSpeed'],
        maxSpeed: maps[i]['maxSpeed'],
        minAltitude: maps[i]['minAltitude'],
        maxAltitude: maps[i]['maxAltitude'],
        totalDistance: maps[i]['totalDistance'],
        startTime: double.parse('${maps[i]['startTime']}'),
        endTime: double.parse('${maps[i]['endTime']}'),
        totalTime: maps[i]['totalTime'],
        avgSpeed: maps[i]['avgSpeed'],
      );
    });
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<List<SubTabData>?> getSecondTabs(int? firstTabIndex) async {
    DateTime endDate = DateTime.now(); // 当前时间
    final oldestTrackStat =
        await TrackStatProvider.instance().getOldestTrackStat();
    DateTime startDate = DateTime.now();
    if (oldestTrackStat?.startTime != null) {
      startDate = DateTime.fromMillisecondsSinceEpoch(
          oldestTrackStat!.startTime.toInt());
    }
    if (firstTabIndex == 0) {
      return getWeekDataList(startDate, endDate);
    } else if (firstTabIndex == 1) {
      return getMonthDataList(startDate, endDate);
    } else if (firstTabIndex == 2) {
      return getYearDataList(startDate, endDate);
    }
    return null;
  }
}

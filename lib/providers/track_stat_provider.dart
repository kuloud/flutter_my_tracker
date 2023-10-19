import 'package:flutter_my_tracker/models/enums/operation.dart';
import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
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
        version: 1,
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
              avgSpeed REAL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          // if (oldVersion < 2) {
          //   // 如果旧版本小于2，则执行升级操作
          //   await db.execute('ALTER TABLE track_stats ADD COLUMN avgSpeed REAL');
          // }
        },
      );
    }
  }

  Future<int> insert(TrackStat trackStat) async {
    await open();
    print('[insert]-----------${trackStat.toJson()}');
    return await _database!.insert('track_stats', trackStat.toJson());
  }

  Future<TrackStat?> getLastestTrackStat() async {
    await open();
    List<Map<String, dynamic>> maps = await _database!
        .query('track_stats', limit: 1, orderBy: 'startTime DESC');
    if (maps.isNotEmpty) {
      return TrackStat.fromJson(maps.first);
    }
    return null;
  }

  Future<List<TrackStat>> getAll() async {
    await open();
    List<Map<String, dynamic>> maps = await _database!.query('track_stats');
    return List.generate(maps.length, (i) {
      return TrackStat(
        positionsCount: maps[i]['positionsCount'],
        minSpeed: maps[i]['minSpeed'],
        maxSpeed: maps[i]['maxSpeed'],
        minAltitude: maps[i]['minAltitude'],
        maxAltitude: maps[i]['maxAltitude'],
        totalDistance: maps[i]['totalDistance'],
        startTime: maps[i]['startTime'],
        endTime: maps[i]['endTime'],
        totalTime: maps[i]['totalTime'],
      );
    });
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

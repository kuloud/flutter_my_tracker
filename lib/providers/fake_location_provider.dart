import 'package:background_locator/keys.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PositionProvider {
  Database? db;
  bool isCreated = false;

  PositionProvider._internal();

  static PositionProvider? _instance;

  factory PositionProvider.instance() {
    _instance ??= PositionProvider._internal();
    return _instance!;
  }

  Future open() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), 'location_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${Keys.ARG_LATITUDE} REAL,
            ${Keys.ARG_LONGITUDE} REAL,
            ${Keys.ARG_ACCURACY} REAL,
            ${Keys.ARG_ALTITUDE} REAL,
            ${Keys.ARG_SPEED} REAL,
            ${Keys.ARG_SPEED_ACCURACY} REAL,
            ${Keys.ARG_HEADING} REAL,
            ${Keys.ARG_TIME} REAL,
            ${Keys.ARG_IS_MOCKED} INTEGER,
            ${Keys.ARG_PROVIDER} TEXT
          )
        ''');
        isCreated = true;
        return;
      },
    );
  }

  bool isOpen() {
    return db != null && (db?.isOpen ?? false) && isCreated;
  }

  Future<Position> insert(Position position) async {
    await open();

    position.id = await db?.insert('locations', position.toJson());

    return position;
  }

  Future<Position?> getPositionById(int id) async {
    await open();
    List<Map<String, dynamic>>? maps = await db?.query(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps?.isNotEmpty ?? false) {
      return Position.fromJson(maps!.first);
    }
    return null;
  }

  Future<List<Position>?> getAllPositions(
      {DateTime? startTime, DateTime? endTime}) async {
    await open();
    List<Map<String, dynamic>>? maps;
    if (startTime != null && endTime != null) {
      maps = await db?.query(
        'locations',
        where: 'time >= ? AND time <= ?',
        whereArgs: [
          startTime.millisecondsSinceEpoch,
          endTime.millisecondsSinceEpoch
        ],
      );
    } else if (startTime != null) {
      maps = await db?.query(
        'locations',
        where: 'time >= ?',
        whereArgs: [startTime.millisecondsSinceEpoch],
      );
    } else if (endTime != null) {
      maps = await db?.query(
        'locations',
        where: 'time <= ?',
        whereArgs: [endTime.millisecondsSinceEpoch],
      );
    } else {
      maps = await db?.query('locations');
    }
    return maps?.map((map) => Position.fromJson(map)).toList();
  }

  Future<int?> delete(int id) async {
    await open();
    return await db?.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int?> update(Position position) async {
    await open();
    return await db?.update(
      'locations',
      position.toJson(),
      where: 'id = ?',
      whereArgs: [position.id],
    );
  }

  Future close() async {
    await db?.close();
  }
}

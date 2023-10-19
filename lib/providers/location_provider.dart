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
    db = await openDatabase(
      join(await getDatabasesPath(), 'location_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL,
            longitude REAL,
            accuracy REAL,
            altitude REAL,
            speed REAL,
            speedAccuracy REAL,
            heading REAL,
            time REAL,
            isMocked INTEGER,
            provider TEXT
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
    position.id = await db?.insert('positions', position.toJson());
    return position;
  }

  Future<Position?> getPositionById(int id) async {
    List<Map<String, dynamic>>? maps = await db?.query(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps?.isNotEmpty ?? false) {
      return Position.fromJson(maps!.first);
    }
    return null;
  }

  Future<List<Position>?> getAllPositions() async {
    List<Map<String, dynamic>>? maps = await db?.query('positions');
    return maps?.map((map) => Position.fromJson(map)).toList();
  }

  Future<int?> delete(int id) async {
    return await db?.delete(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int?> update(Position position) async {
    return await db?.update(
      'positions',
      position.toJson(),
      where: 'id = ?',
      whereArgs: [position.id],
    );
  }

  Future close() async {
    await db?.close();
  }
}

import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/models/pojos/position_ext.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PositionProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(
      join(await getDatabasesPath(), path),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE positions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            longitude REAL NOT NULL,
            latitude REAL NOT NULL,
            timestamp TEXT NOT NULL,
            accuracy REAL NOT NULL,
            altitude REAL NOT NULL,
            altitudeAccuracy REAL NOT NULL,
            heading REAL NOT NULL,
            headingAccuracy REAL NOT NULL,
            speed REAL NOT NULL,
            speedAccuracy REAL NOT NULL,
            floor INTEGER,
            isMocked INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<KPosition> insert(KPosition position) async {
    position.id = await db.insert('positions', position.toJson());
    return position;
  }

  Future<KPosition?> getPositionById(int id) async {
    List<Map<String, dynamic>> maps = await db.query(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Position.fromMap(maps.first).copyWith(id: id);
    }
    return null;
  }

  Future<List<KPosition>> getAllPositions() async {
    List<Map<String, dynamic>> maps = await db.query('positions');
    return maps.map((map) => Position.fromMap(map).copyWith()).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(KPosition position) async {
    return await db.update(
      'positions',
      position.toJson(),
      where: 'id = ?',
      whereArgs: [position.id],
    );
  }

  Future close() async {
    await db.close();
  }
}

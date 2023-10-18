import 'package:flutter_my_tracker/models/pojos/operation_record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OperationRecordProvider {
  Database? db;
  bool isCreated = false;

  Future open(String path) async {
    db = await openDatabase(
      join(await getDatabasesPath(), path),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS operation_records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            time TEXT,
            action TEXT
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

  Future<OperationRecord> insert(OperationRecord record) async {
    record.id = await db?.insert('operation_records', record.toJson());
    return record;
  }

  Future<OperationRecord?> getOperationRecordById(int id) async {
    List<Map<String, dynamic>>? maps = await db?.query(
      'operation_records',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps?.isNotEmpty ?? false) {
      return OperationRecord.fromJson(maps!.first);
    }
    return null;
  }

  Future<List<OperationRecord>?> getOperationRecords() async {
    List<Map<String, dynamic>>? maps = await db?.query('operation_records');
    return maps?.map((map) => OperationRecord.fromJson(map)).toList();
  }

  Future<int?> delete(int id) async {
    return await db?.delete(
      'operation_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int?> update(OperationRecord record) async {
    return await db?.update(
      'operation_records',
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future close() async {
    await db?.close();
  }
}

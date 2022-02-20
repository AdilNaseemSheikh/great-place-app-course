import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelpers {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "places.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE table1(id TEXT PRIMARY KEY,title TEXT,image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final db = await DBHelpers.database();
    db.insert(tableName, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,Object>>> getData(String tableName) async {
    final db=await DBHelpers.database();
    return db.query(tableName);
  }
}

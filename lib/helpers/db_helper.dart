import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getConnection({String createQuery = ''}) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(createQuery);
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.getConnection(createQuery: 'CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, loc_address TEXT)');
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.getConnection();
    return db.query(table);
  }
}

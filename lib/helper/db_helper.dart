import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'praises.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE praise_table(id INTEGER PRIMARY KEY , praiseName TEXT, praiseValue TEXT)');
        }, version: 1);
  }

  static Future<void> addPraise(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
    );
  }

  static Future<void> removePraise(int id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM praise_table WHERE id = '+id.toString());
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<bool> checkMovieExist(int id) async{
    final db = await DBHelper.database();
    var result = await db.rawQuery('SELECT praiseName FROM praise_table WHERE id = '+id.toString());
    if(result.length>0){
      return true;
    } else {
      return false;
    }
  }
}
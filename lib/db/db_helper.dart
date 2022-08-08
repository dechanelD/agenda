import 'package:agenda/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creation d'une nouvelle");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING, note TEXT, date STRING,"
                "startime STRING, endTime STRING,"
                "remind INTEGER, repeat STRING,"
                "color INTEGER,"
                "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async{
    print("appel de l'insertion");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("appel de la fonction query");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id)async{
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id =?
    ''',[1, id]);
  }

}
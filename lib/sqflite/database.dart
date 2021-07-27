import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'datamodel.dart';

class DB {
/*   static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  } */

  Future<Database> initDB() async {
    String dbfile = await getDatabasesPath();
    final path = join(dbfile, "MYDbe.db");
    return openDatabase(
      (path),
      onCreate: (database, verison) async {
        await database.execute("""
        CREATE TABLE MYTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT NOT NULL
        )
        """);
      },
      version: 1,
    );
  }

  Future<bool> insertData(DataModel dataModel) async {
    final Database db = await initDB();
    db.insert("MYTable", dataModel.toMap());
    return true;
  }


  Future <List<DataModel>> getData()async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> datas = await db.query("MYTable");
    return datas.map((e) => DataModel.fromJson(e)).toList();
  }
}

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:fermentation/models/project_to_use.dart';

class DatabaseHelper {
  static Database? _myDB;

  final String _projectTable = 'projectTable';
  final String _projectIdColumn = "projectIdColumn";
  final String _projectStartColumn = "projectStartColumn";
  final String _projectEndColumn = "projectEndColumn";
  final String _projectNameColumn = "projectNameColumn";

  Future<Database?> get myDb async {
    if (_myDB != null) {
      return _myDB;
    } else {
      _myDB = await initMyDB();
      return _myDB;
    }
  }

  initMyDB() async {
    String path = ("/fermentation/lib/myDatabase.db");
    var myownDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return myownDB;
  }

  void _createDB(Database db, int newversion) async {
    String sql =
        "CREATE TABLE $_projectTable($_projectIdColumn INTEGER PRIMARY KEY,$_projectNameColumn TEXT,"
        "$_projectStartColumn TEXT, $_projectEndColumn TEXT)";
    await db.execute(sql);
  }

  Future<int> insertProject(ProjectToUse projectToUse) async {
    var db = await myDb;
    int result = await db!.insert(_projectTable, projectToUse.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<ProjectToUse?> getProject(int id) async {
    var db = await myDb;
    String sql = "SELECT * FROM $_projectTable WHERE $_projectIdColumn=$id";
    var result = await db?.rawQuery(sql);
    if (result!.isEmpty) {
      return null;
    }
    return ProjectToUse.fromMap(result.first);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';

//Class for Projects
const String projectTable = "project";
const String projectId = "_id";
const String projectName = "name";
const String projectStart = "start";
const String projectEnd = "end";

class Project {
  late int _projectId;
  late String _projectName;
  late String _projectStart;
  late String _projectEnd;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      projectName: _projectName,
      projectStart: _projectStart,
      projectEnd: _projectEnd
    };
    if (_projectId != null) {
      map[projectId] = _projectId;
    }
    return map;
  }

  Project();

  Project.fromMap(Map<dynamic, dynamic> map) {
    _projectId = map[projectId];
    _projectName = map[projectName].toString();
    _projectStart = map[projectStart].toString();
    _projectEnd = map[projectEnd].toString();
  }
  void setParams(int id, String name, String start, String end) {
    _projectId = id;
    _projectName = name;
    _projectStart = start;
    _projectEnd = end;
  }
}

class Databasehelper {
  static const _databaseName = "myDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'project_table';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnStart = 'start';
  static const columnEnd = 'end';
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();
  static Database? _database;

  Future<Database?> get getDatabase async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase('/myDatabase.db',
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnStart TEXT NOT NULL,
            $columnEnd TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Project project) async {
    Database? db = await instance.getDatabase;
    return await db!
        .insert(table, {'name': project._projectName, 'start': projectStart});
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.getDatabase;
    return await db!.query(table);
  }
}

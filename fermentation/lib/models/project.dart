import 'package:sqflite/sqflite.dart';

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

class ProjectProvider {
  static Database? db;

  Future<Database?> get _db async {
    if (db == null) {
      db = await intialDb();
      return db;
    } else {
      return db;
    }
  }

  intialDb() async {
    Database db = await openDatabase("fermentation\lib\myDatabase.db",
        onCreate: (Database db, int? version) async {
      await db.execute('''
create table $projectTable ( 
  $projectId integer primary key autoincrement, 
  $projectName text not null,
  $projectStart text not null,
  $projectEnd text not null)
''');
    });
    return db;
  }

  Future<Project> insert(
    Project project,
  ) async {
    project._projectId = await db!.insert(projectTable, project.toMap());
    return project;
  }

  Future<Project?> getProject(int id) async {
    List<Map> maps = await db!.query(projectTable,
        columns: [projectId, projectName, projectStart, projectEnd],
        where: '$projectId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Project.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db!
        .delete(projectTable, where: '$projectId = ?', whereArgs: [id]);
  }

  Future<int> update(Project project) async {
    return await db!.update(projectTable, project.toMap(),
        where: '$projectId = ?', whereArgs: [project._projectId]);
  }

  Future close() async => db!.close();
}

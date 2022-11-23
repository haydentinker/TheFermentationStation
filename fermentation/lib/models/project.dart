//Class for Projects
class Project {
  int _projectId;
  String _projectName;
  String _projectStart;
  String _projectEnd;

  Project(
      this._projectId, this._projectName, this._projectStart, this._projectEnd);

  // ignore: unnecessary_getters_setters
  int get projectId => _projectId;
  // ignore: unnecessary_getters_setters
  String get projectName => _projectName;
  // ignore: unnecessary_getters_setters
  String get projectStart => _projectStart;
  String get projectEnd => _projectEnd;

  set projectId(int newProjectId) {
    _projectId = newProjectId;
  }

  set projectName(String newProjectName) {
    _projectName = newProjectName;
  }

  set projectStart(String newProjectStart) {
    _projectStart = newProjectStart;
  }

  set projectEnnd(String newProjectEnd) {
    _projectEnd = newProjectEnd;
  }
}

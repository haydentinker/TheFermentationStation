class ProjectToUse {
  late int _projectId;
  late String _projectName;
  late String _projectStart;
  late String _projectEnd;
  ProjectToUse(
      this._projectId, this._projectName, this._projectStart, this._projectEnd);
  int get projectId => _projectId;
  String get projectName => _projectName;
  String get projectStart => _projectStart;
  String get projectEnd => _projectEnd;

  ProjectToUse.fromMap(Map<String, dynamic> mymap) {
    _projectId = mymap['projectId'];
    _projectName = mymap['projectName'];
    _projectStart = mymap['projectStart'];
    _projectEnd = mymap['projectEnd'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic>? myMap;
    myMap!['projectId'] = _projectId;
    myMap['projectName'] = _projectName;
    myMap['projectStart'] = _projectStart;
    myMap['projectEnd'] = _projectEnd;

    return myMap;
  }
}

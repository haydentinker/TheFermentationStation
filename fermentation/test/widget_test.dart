// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fermentation/main.dart';
import 'package:fermentation/models/project.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('testing database', () async {
    Project kombucha = Project();
    kombucha.setParams(5, "kombucha", "start", "end");
    Databasehelper mydb = Databasehelper.instance;
    mydb.getDatabase;
    mydb.insert(kombucha);
    var dbQuery = await mydb.queryAllRows();
    expect(dbQuery[1]["name"], "kombucha");
  });
}

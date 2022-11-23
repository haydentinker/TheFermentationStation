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
    kombucha.setParams(1, "kombucha", "01-10-2001", "01-10-2001");
    // Databasehelper mydb = Databasehelper.instance;
    // mydb.getDatabase;

    // databaseHelper.insert(kombucha);
    // var result = databaseHelper.getProject(1);
    // print(result);
  });
}

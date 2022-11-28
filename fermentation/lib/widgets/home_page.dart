import 'package:flutter/material.dart';
import 'package:fermentation/models/project.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Databasehelper dbHelper = Databasehelper.instance;
  List entries = [];
  @override
  Widget build(BuildContext context) {
    _queryAll();
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.deepOrange,
            Colors.orangeAccent,
          ],
        )),
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            final item = entries[index];
            return Card(
                child: ListTile(
              title: Text(item["name"]),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print("hello");
              },
            ));
          },
        ),
      ),
    );
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    entries.clear();
    allRows.forEach((row) => entries.add(row));
  }
}

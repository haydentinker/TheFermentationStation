import 'package:fermentation/main.dart';
import 'package:flutter/material.dart';
import 'package:fermentation/models/project.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  final Databasehelper dbHelper = Databasehelper.instance;
  List entries = [];
  bool customTileExpanded = false;
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
            final start = item["start"];
            final end = item["end"];
            return Card(
                child: ExpansionTile(
              title: Text(item["name"]),
              trailing: const Icon(Icons.arrow_drop_down),
              children: <Widget>[
                ListTile(
                  title: Text('Start date: $start End date: $end'),
                )
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => customTileExpanded = expanded);
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
    setState(() {});
  }
}

import 'package:fermentation/main.dart';
import 'package:flutter/material.dart';
import 'package:fermentation/models/project.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Projects"),
          titleTextStyle: const TextStyle(fontSize: 35),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
        ),
        body: Center(
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
                final controller1 = TextEditingController();
                final controller2 = TextEditingController();
                final controller3 = TextEditingController();
                final item = entries[index];
                final start = item["start"];
                final end = item["end"];
                final id = item['_id'];
                return Card(
                    child: ExpansionTile(
                  title: Text(item["name"]),
                  trailing: const Icon(Icons.arrow_drop_down),
                  children: <Widget>[
                    TextFormField(
                      controller: controller1,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your project name',
                      ),
                    ),
                    TextFormField(
                      controller: controller2,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your project start date',
                      ),
                    ),
                    TextFormField(
                      controller: controller3,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your project end date',
                      ),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState() {}
                    ;
                  },
                ));
              },
            ),
          ),
        ));
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    entries.clear();
    allRows.forEach((row) => entries.add(row));
    setState(() {});
  }
}

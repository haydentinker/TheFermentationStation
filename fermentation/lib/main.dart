import 'package:flutter/material.dart';
import 'package:fermentation/models/project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  final dbHelper = Databasehelper.instance;
  List entries = [];

  //controllers used in insert operation UI
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _insert("kombucha", "end");
    _queryAll();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
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
                Colors.pink,
              ],
            )),
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(child: Text('Entry ${entries[index]}'));
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calender',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 230, 71, 23),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _insert(name, end) async {
    // row to insert
    Project project = Project();
    project.setParams(1, "Kombucha", "start", "end");
    await dbHelper.insert(project);
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    entries.clear();
    allRows.forEach((row) => entries.add(row));
    print(entries[0]["name"]);
  }

  void _deleteProject(int id) async {
    dbHelper.delete(id);
  }

  void _updateProject(Project project) {
    dbHelper.update(project);
  }
}

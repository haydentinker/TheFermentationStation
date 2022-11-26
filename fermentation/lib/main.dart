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
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _queryAll();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: [
            PopupMenuButton(
              constraints: const BoxConstraints.expand(width: 600, height: 500),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
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
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _insert(controller1.text, controller2.text,
                                  controller3.text);
                              _queryAll();
                              setState(() {});
                            },
                            child: const Text('Submit'),
                          ),
                        ])))
              ],
            ),
          ],
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

  void _insert(name, start, end) async {
    // row to insert
    Project project = Project();
    project.setParams(name, start, end);
    await dbHelper.insert(project);
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(child: Text(title));
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

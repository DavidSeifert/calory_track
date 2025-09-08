import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../helpers/database_helper.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _counter = [0, 0, 0, 0];
  final Databasehelper dbHelper = Databasehelper.instance;

  void _updateCounter(int index, int update) {
    setState(() {
      _counter[index] = update;
    });
  }

  void _writetoDatabase() {
    dbHelper.addEntry(
      _counter[0] * 1000 + _counter[1] * 100 + _counter[2] * 10 + _counter[3],
    );
  }

  Future<String> _readfromDatabase() async {
    final calories = await dbHelper.getCaloriesForToday();
    //dbHelper.showValues().then((value) => print(value));
    return calories.toString();
  }

  /*
  Future<String> _showValues() async {
    final values = await dbHelper.showValues();
    dbHelper.showValues().then((value) => print(value));
    return values.toString();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: _readfromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    snapshot.data ?? 'No data',
                    style: TextStyle(
                      fontSize: 32, // bigger font size
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20), // space between total and button
            ElevatedButton(onPressed: _writetoDatabase, child: Text("Add")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (columnIndex) {
                return SizedBox(
                  width: 50,
                  height: 150,
                  child: CupertinoPicker(
                    itemExtent: 30,
                    onSelectedItemChanged: (int newitem) {
                      _updateCounter(columnIndex, newitem);
                    },
                    children: List.generate(
                      10,
                      (value) => Text(value.toString()),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/overview');
        },
        tooltip: 'Add',
        child: Icon(Icons.analytics),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calory Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _counter = [0,0,0,0];

  void _updateCounter(int index, int update) {
    setState(() {
      _counter[index] = update;
    });
    
  }
  void _writetoDatabase(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (columnIndex) {
                return SizedBox(
                  width: 50,
                  child: CupertinoPicker(
                    itemExtent: 30,
                    onSelectedItemChanged: (int newitem)
                    {
                      _updateCounter(columnIndex, newitem);
                    },
                    children: List.generate(
                      10,
                      (value) => Text(value.toString()),
                    ),
                  ),
                );
              }),
            ), ElevatedButton(onPressed: _writetoDatabase, child: Text("Add"))
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

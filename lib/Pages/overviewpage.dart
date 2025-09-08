import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calory_track/Helpers/database_helper.dart';

class OverviewPage extends StatelessWidget {
  final String title;
  final Databasehelper dbHelper = Databasehelper.instance;
  OverviewPage({super.key, required this.title});

  Future<List<int>> _readfromDatabase() async {
    final calories = await dbHelper.getCaloriesListForToday();
    return calories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(title),
      ),
      body: FutureBuilder(
        future: _readfromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            List<int> caloriesList = snapshot.data!;

            return ListView(
              padding: EdgeInsets.all(16),
              children: List.generate(
                caloriesList.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Do something when button is pressed
                      
                    },
                    child: Text('Calories Entry: ${caloriesList[index]}'),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/monthselectionpage');
        },
        tooltip: 'Add',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}

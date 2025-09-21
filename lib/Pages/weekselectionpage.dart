import 'package:flutter/material.dart';
import 'package:calory_track/Helpers/database_helper.dart';

class Weekselectionpage extends StatelessWidget {
  final String title;
  final int weekNumber;
  final Databasehelper dbHelper = Databasehelper.instance;
  Weekselectionpage({super.key, required this.title, required this.weekNumber});


  Future<List<Map<String, dynamic>>> _getEntries() async {
    final rawEntries = await dbHelper.getEntriesForWeek(weekNumber);
    final calories = <int>[];

    for (var entry in rawEntries) {
      calories.add(entry['calories'] as int);
    }

    return rawEntries;
  }
Widget _buildEntries() {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: _getEntries(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      final entries = snapshot.data ?? [];

      if (entries.isEmpty) {
        return Center(child: Text('No entries found.'));
      }

      return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final calories = entry['calories'] as int;
          final date = entry['date']; // Adjust field name if needed

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(Icons.local_fire_department, color: Colors.redAccent),
              title: Text('Calories: $calories'),
              subtitle: Text('Date: $date'),
            ),
          );
        },
      );
    },
  );
} 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(title),
      ),
      body: _buildEntries(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          null;
        },
        tooltip: 'Add',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}

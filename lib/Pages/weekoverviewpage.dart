import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:week_of_year/week_of_year.dart';

class WeekOverviewPage extends StatelessWidget {
  final String title;
  const WeekOverviewPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final int thisWeek = DateTime.now().weekOfYear;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 52,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final int weekNumber = index + 1;
            final bool isCurrentWeek = weekNumber == thisWeek;

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrentWeek ? Colors.red : null,
                foregroundColor: isCurrentWeek ? Colors.white : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                context.push('/weekselectionpage/$weekNumber');
              },
              child: Text('$weekNumber'),
            );
          },
        ),
      ),
    );
  }
}
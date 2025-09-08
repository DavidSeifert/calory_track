import 'package:flutter/material.dart';

class Monthselectionpage extends StatelessWidget {
  final String title;
  const Monthselectionpage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(title),
      ),
      body: const Center(child: Text('This is the Month Selection Page')),
    );
  }
}

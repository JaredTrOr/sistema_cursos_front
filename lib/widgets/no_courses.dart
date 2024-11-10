import 'package:flutter/material.dart';

class NoCourses extends StatelessWidget {
  final String description;
  const NoCourses({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 150),
          const Icon(Icons.sentiment_dissatisfied, size: 100,),
          const SizedBox(height: 20),
          Text(description, style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}
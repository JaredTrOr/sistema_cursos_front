import 'package:flutter/material.dart';

class NoCourses extends StatelessWidget {
  final String description;
  const NoCourses({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_dissatisfied, size: 100,),
          const SizedBox(height: 20),
          Text(description, style: const TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}
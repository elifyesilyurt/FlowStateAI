import 'package:flutter/material.dart';

void main() {
  runApp(const FlowStateAI());
}

class FlowStateAI extends StatelessWidget {
  const FlowStateAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlowStateAI'),
          backgroundColor: Colors.deepPurple, // Senin sevdiğin mor tonları
        ),
        body: const Center(
          child: Text(
            'Odaklanmaya Hazır Mısın Elif?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
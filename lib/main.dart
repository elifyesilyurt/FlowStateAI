import 'focus_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlowStateAI());
}

class FlowStateAI extends StatelessWidget {
  const FlowStateAI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Ana içeriği aşağıya taşıdık
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlowStateAI'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Odaklanmaya Hazır Mısın Elif?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FocusPage()),
                );
              },
              child: const Text('Odaklanmayı Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}
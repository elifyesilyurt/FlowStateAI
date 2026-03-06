import 'package:flutter/material.dart';

class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Odaklanma Seansı'),
        backgroundColor: Colors.deepOrange, // Odaklanma için daha canlı bir renk
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.timer, size: 100, color: Colors.deepOrange),
            const SizedBox(height: 20),
            const Text(
              'FlowStateAI Aktif',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Bilişsel yükünüz takip ediliyor...'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Geri gitmeyi sağlar
              },
              child: const Text('Seansı Bitir'),
            ),
          ],
        ),
      ),
    );
  }
}
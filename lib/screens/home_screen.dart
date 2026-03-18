import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC), // LOTR kağıt rengi
      appBar: AppBar(
        title: const Text("Yolculuk Paneli"),
        backgroundColor: Colors.brown[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hoş geldin, Elif", 
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
            ), // [cite: 151]
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Buraya tıklayınca SessionScreen'e gideceğiz
              },
              child: const Text("MACERAYA DEVAM ET"), // [cite: 152]
            ),
          ],
        ),
      ),
    );
  }
}
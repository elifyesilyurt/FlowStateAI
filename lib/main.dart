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
          backgroundColor: Colors.deepPurple,
        ),
        // ESKİ BODY YERİNE BURAYI KOMPLE YAPIŞTIR
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Odaklanmaya Hazır Mısın Elif?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20), // Yazı ile buton arası boşluk
              ElevatedButton(
                onPressed: () {
                  // Butona basınca terminalde bu yazıyı göreceksin
                  print("Odaklanma Başladı!");
                },
                child: const Text('Odaklanmayı Başlat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
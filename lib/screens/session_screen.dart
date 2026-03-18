import 'package:flutter/material.dart';
import 'dart:async'; // Zamanlayıcı (Timer) kullanmak için gerekli

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int _seconds = 1500; // 25 dakika (25 * 60) [cite: 176]
  Timer? _timer;

  // Ekran ilk açıldığında çalışır
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() { // Ekranı her saniye yenile diyoruz!
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D1B0D), // Daha koyu, odaklanma rengi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ODAKLANMA MODU", style: TextStyle(color: Colors.white70, letterSpacing: 2)),
            const SizedBox(height: 50),
            // Sayaç Yazısı [cite: 158]
            Text(
              "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // İlerleme Çubuğu [cite: 157]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: _seconds / 1500, // 1.0 tam dolu, 0.0 boş demek
                backgroundColor: Colors.white12,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context); // [cite: 159, 281]
              },
              child: const Text("YOLCULUĞU DURDUR", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Ekran kapanırken hafızayı temizle
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
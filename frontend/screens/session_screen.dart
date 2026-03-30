import 'package:flutter/material.dart';
import 'dart:async';
// 1. ADIM: Dashboard'a gitmek için import ekliyoruz
import 'dashboard_screen.dart'; 

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int _seconds = 1500; // 25 dakika
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) { // Bellek güvenliği için: Ekran hala açıksa güncelle
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _timer?.cancel();
            _finishSession(); // Süre bitince otomatik bitir
          }
        });
      }
    });
  }

  // 2. ADIM: Seansı bitirip Dashboard'a uçuran fonksiyon
  void _finishSession() {
    _timer?.cancel();
    // pushReplacement: Geri dönülemeyen bir geçiş yapar (Seans bitti!)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka planı daha epik, koyu bir kahve yaptık
      backgroundColor: const Color(0xFF1B1008), 
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [const Color(0xFF2D1B0D), Colors.black],
            center: Alignment.center,
            radius: 1.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_bottom, color: Colors.orangeAccent, size: 40),
              const SizedBox(height: 20),
              const Text(
                "ODAKLANMA MODU", 
                style: TextStyle(color: Colors.white70, letterSpacing: 4, fontWeight: FontWeight.w300)
              ),
              const SizedBox(height: 50),
              
              // Epik Sayaç Yazısı
              Text(
                "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontSize: 90, 
                  color: Colors.white, 
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Georgia'
                ),
              ),
              const SizedBox(height: 40),
              
              // İlerleme Çubuğu (Daha şık ve ince)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: _seconds / 1500,
                    backgroundColor: Colors.white10,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              
              // 3. ADIM: Buton Navigasyon Güncellemesi
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
                onPressed: _finishSession, // Basınca Dashboard'a gider
                child: const Text(
                  "YOLCULUĞU TAMAMLA", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
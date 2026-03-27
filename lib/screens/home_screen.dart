import 'package:flutter/material.dart';
import 'session_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC),
      body: Stack( // 5. Gün: Stack yapısı ile derinlik katmanı [cite: 108, 115]
        children: [
          // Arka plan dokusu için degrade [cite: 110, 117]
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFFF4E4BC), Color(0xFFDCC698)],
                radius: 1.5,
              ),
            ),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_stories, size: 70, color: Colors.brown),
                    const SizedBox(height: 20),
                    const Text(
                      "FlowState AI",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.brown, fontFamily: 'Georgia'),
                    ),
                    const Text("Hoş geldin, Elif", style: TextStyle(fontSize: 18, color: Colors.brown)), // [cite: 6]
                    const SizedBox(height: 40),

                    // 1. GÜN EKSİĞİ: Yolculuk Günlüğü Özeti [cite: 8, 9]
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // GÜNCELLEME: .withOpacity yerine .withValues kullanıldı
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(15),
                        // GÜNCELLEME: .withOpacity yerine .withValues kullanıldı
                        border: Border.all(color: Colors.brown.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem("42 Saat", "Toplam Süre"), // [cite: 8, 73]
                          _buildStatItem("12", "Günlük"), // [cite: 9]
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 50),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900],
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 8, // [cite: 106]
                      ),
                      onPressed: () {
                        Navigator.push( // [cite: 120-123, 134]
                          context,
                          MaterialPageRoute(builder: (context) => const SessionScreen()),
                        );
                      },
                      child: const Text(
                        "MACERAYA DEVAM ET", // [cite: 7]
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.brown)),
      ],
    );
  }
}
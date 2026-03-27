import 'package:flutter/material.dart';
import 'session_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC),
      body: Stack( // 5. Gün: Stack yapısı [cite: 108, 115]
        children: [
          // Arka plan dokusu için hafif bir degrade
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

                    // 1. GÜN EKSİĞİ: Yolculuk Günlüğü Özeti 
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.brown.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem("42 Saat", "Toplam Süre"), // [cite: 8]
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
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SessionScreen()),
                        );
                      },
                      child: const Text("MACERAYA DEVAM ET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // [cite: 7]
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
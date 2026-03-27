import 'package:flutter/material.dart';
// 1. ÖNEMLİ: Gideceğimiz ekranı (Sayaç Ekranı) buraya tanıtıyoruz
import 'session_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka planı LOTR parşömen rengi yaptık
      backgroundColor: const Color(0xFFF4E4BC), 
      body: Container(
        // Arka plana derinlik katmak için hafif bir degrade (gradient)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown.shade200, const Color(0xFFF4E4BC)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Epik bir ikon (Kitap veya Macera simgesi)
              const Icon(Icons.auto_stories, size: 80, color: Colors.brown),
              const SizedBox(height: 20),
              
              const Text(
                "FlowState AI", 
                style: TextStyle(
                  fontSize: 36, 
                  fontWeight: FontWeight.w900, 
                  color: Colors.brown,
                  letterSpacing: 2.0,
                  fontFamily: 'Georgia' // main.dart'ta tanımladığımız epik font
                ),
              ),
              const SizedBox(height: 10),
              
              const Text(
                "Hoş geldin, Elif", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              const SizedBox(height: 10),
              const Text(
                "Yolculuğun kaldığı yerden devam ediyor...",
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.brown, fontSize: 14),
              ),
              const SizedBox(height: 60),
              
              // ANA BUTON: Maceraya (Odaklanmaya) Başla
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[900],
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  elevation: 12,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // MÜHENDİSLİK DOKUNUŞU: Kullanıcıyı önce sayaç sayfasına gönderiyoruz
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SessionScreen()),
                  );
                },
                child: const Text(
                  "MACERAYA DEVAM ET", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

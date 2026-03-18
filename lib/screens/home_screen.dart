import 'package:flutter/material.dart';
// Önemli: Gitmek istediğimiz ekranı buraya tanıtıyoruz
import 'dashboard_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka planı LOTR parşömen rengi yaptık [cite: 101]
      backgroundColor: const Color(0xFFF4E4BC), 
      appBar: AppBar(
        title: const Text("Yolculuk Paneli", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[900],
        centerTitle: true, // Başlığı ortaya aldık, daha estetik durur
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hoş geldin metni [cite: 6]
            const Text(
              "Hoş geldin, Elif", 
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold, 
                color: Colors.brown
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Yolculuğun kaldığı yerden devam ediyor...",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.brown),
            ),
            const SizedBox(height: 50),
            
            // Ana Buton: Maceraya Devam Et [cite: 7]
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[900], // Buton rengi temaya uygun
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Köşeleri hafif yuvarlattık
                ),
              ),
              onPressed: () {
                // Mühendislik Dokunuşu: DashboardScreen'e geçiş [cite: 134-135]
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
              child: const Text(
                "MACERAYA DEVAM ET", 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
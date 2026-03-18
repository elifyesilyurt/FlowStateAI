import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC), // Parşömen rengi
      appBar: AppBar(
        title: const Text("Yolculuk Özeti"),
        backgroundColor: Colors.brown[900],
      ),
      body: SingleChildScrollView( // [1]
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Maceranın Analizi", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown)
              ),
              const SizedBox(height: 20),
              
              // Analiz Kartları (Şimdilik Sabit Veri - Yarın JSON'a Bağlayacağız)
              _buildAnalysisCard("Toplam Aktivite", "120 Olay", Icons.bolt), // [2]
              _buildAnalysisCard("Klavye Kullanımı", "80 Tuş", Icons.keyboard),
              _buildAnalysisCard("Fare Hareketleri", "40 Tık", Icons.mouse),
              _buildAnalysisCard("Odak Yoğunluğu", "0.08", Icons.psychology),
              
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("PANELİ KAPAT"),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Yardımcı Metot: Tekrar eden kartları oluşturmak için [3]
  Widget _buildAnalysisCard(String title, String value, IconData icon) {
    return Card( // [4]
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown[100],
          child: Icon(icon, color: Colors.brown[900]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.orange)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../services/json_loader.dart';
import '../models/session_summary.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<SessionSummary> _summaryFuture;

  @override
  void initState() {
    super.initState();
    _summaryFuture = _loadData();
  }

  Future<SessionSummary> _loadData() async {
    final jsonMap = await JsonLoader.loadSessionSummary();
    return SessionSummary.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC),
      appBar: AppBar(
        title: const Text("Yolculuk Özeti", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[900],
      ),
      body: Stack(
        children: [
          // Katman 1: Arka Plan
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF4E4BC),
          ),
          
          // Katman 2: Veri İçeriği
          FutureBuilder<SessionSummary>(
            future: _summaryFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.brown));
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Kadim kayıtlar okunamadı!"));
              }

              final summary = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Maceranın Analizi", 
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.brown)
                      ),
                      const SizedBox(height: 20),
                      
                      // Analiz Kartları
                      _buildAnalysisCard("Toplam Aktivite", "${summary.totalEvents} Olay", Icons.bolt),
                      _buildAnalysisCard("Klavye Kullanımı", "${summary.keyboardEvents} Tuş", Icons.keyboard),
                      _buildAnalysisCard("Fare Hareketleri", "${summary.mouseEvents} Tık", Icons.mouse),
                      _buildAnalysisCard("Odak Yoğunluğu", summary.eventDensity.toStringAsFixed(2), Icons.psychology),
                      
                      const SizedBox(height: 30),
                      
                      // Buton Tasarımı
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[900],
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("PANELİ KAPAT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Kart Oluşturma Fonksiyonu (Daha Epik Tasarım)
  Widget _buildAnalysisCard(String title, String value, IconData icon) {
    return Card(
      elevation: 10, // Gölge derinliği arttı
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), // Köşeler yuvarlandı
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: Colors.brown[100],
          child: Icon(icon, color: Colors.brown[900]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.orange)),
      ),
    );
  }
}
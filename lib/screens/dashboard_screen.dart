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
    // Veri yükleme işlemini burada başlatıyoruz
    _summaryFuture = _loadData();
  }

  Future<SessionSummary> _loadData() async {
    final jsonMap = await JsonLoader.loadSessionSummary();
    return SessionSummary.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yolculuk Özeti", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown[900],
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // 1. KATMAN: Arka Plan Dokusu
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFFF4E4BC), Colors.brown.shade200],
              ),
            ),
          ),
          
          // 2. KATMAN: Veri İçeriği
          FutureBuilder<SessionSummary>(
            future: _summaryFuture,
            builder: (context, snapshot) {
              // Yükleme Aşaması
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.brown));
              } 
              // Hata Aşaması
              else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Kadim kayıtlar okunamadı!"));
              }

              final summary = snapshot.data!;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Maceranın Analizi", 
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.brown, letterSpacing: 1.5)
                      ),
                      const SizedBox(height: 25),
                      
                      // Dinamik Verilerle Kartlar
                      _buildAnalysisCard("Toplam Aktivite", "${summary.totalEvents} Olay", Icons.bolt),
                      _buildAnalysisCard("Klavye Kullanımı", "${summary.keyboardEvents} Tuş", Icons.keyboard),
                      _buildAnalysisCard("Fare Hareketleri", "${summary.mouseEvents} Tık", Icons.mouse),
                      _buildAnalysisCard("Odak Yoğunluğu", summary.eventDensity.toStringAsFixed(2), Icons.psychology),
                      
                      const SizedBox(height: 40),
                      
                      // Akışı Kapatan Buton
                      ElevatedButton.icon(
                        icon: const Icon(Icons.close, color: Colors.white),
                        label: const Text("PANELİ KAPAT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[900],
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
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

  // Kart Oluşturma: Daha derin gölge ve epik hatlar
  Widget _buildAnalysisCard(String title, String value, IconData icon) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.brown[50],
          child: Icon(icon, color: Colors.brown[900]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.orangeAccent)),
      ),
    );
  }
}
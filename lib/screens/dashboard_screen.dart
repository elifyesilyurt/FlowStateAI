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
      appBar: AppBar(
        title: const Text("Yolculuk Özeti", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown[900],
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Arka Plan
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
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Maceranın Analizi", 
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.brown, letterSpacing: 1.5, fontFamily: 'Georgia')
                      ),
                      const SizedBox(height: 25),
                      
                      // KARTLAR: Burada veriye göre renk değişimi mantığını başlattık
                      _buildAnalysisCard("Toplam Aktivite", "${summary.totalEvents} Olay", Icons.bolt),
                      _buildAnalysisCard("Klavye Kullanımı", "${summary.keyboardEvents} Tuş", Icons.keyboard),
                      _buildAnalysisCard("Fare Hareketleri", "${summary.mouseEvents} Tık", Icons.mouse),
                      
                      // ÖZEL KART: Odak Yoğunluğu (Buna yoğunluk bilgisini gönderiyoruz)
                      _buildAnalysisCard(
                        "Odak Yoğunluğu", 
                        summary.eventDensity.toStringAsFixed(2), 
                        Icons.psychology, 
                        densityValue: summary.eventDensity
                      ),
                      
                      const SizedBox(height: 40),
                      
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

  // YENİLİK: densityValue parametresi ekledik
  Widget _buildAnalysisCard(String title, String value, IconData icon, {double? densityValue}) {
    // Mühendislik mantığı: Eğer yoğunluk 1.5'ten fazlaysa rengi Turuncu/Altın yap (Efsanevi Odak)
    bool isHighFocus = (densityValue != null && densityValue >= 1.5);
    Color themeColor = isHighFocus ? Colors.orange[800]! : Colors.brown[700]!;

    return Card(
      elevation: isHighFocus ? 12 : 8, // Yüksek odakta kart daha çok parlasın (gölgesi artsın)
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isHighFocus ? BorderSide(color: Colors.orangeAccent, width: 2) : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: themeColor.withOpacity(0.1),
          child: Icon(icon, color: themeColor),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[900])),
        subtitle: isHighFocus && title == "Odak Yoğunluğu" 
            ? const Text("Efsanevi Seviye!", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold))
            : null,
        trailing: Text(
          value, 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: themeColor)
        ),
      ),
    );
  }
}
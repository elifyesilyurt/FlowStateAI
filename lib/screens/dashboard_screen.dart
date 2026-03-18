import 'package:flutter/material.dart';
import '../services/json_loader.dart'; // [1]
import '../models/session_summary.dart'; // [2]

class DashboardScreen extends StatefulWidget { // [3]
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Gelecekte gelecek olan JSON verisini bu değişken tutacak
  late Future<SessionSummary> _summaryFuture;

  @override
  void initState() {
    super.initState();
    // Ekran ilk açıldığında JSON dosyasını okuma emrini veriyoruz
    _summaryFuture = _loadData();
  }

  // Yardımcı fonksiyon: Servisten ham veriyi alır ve modele dönüştürür
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
      // FutureBuilder: Veri yüklenirken bekler, bitince ekranı çizer
      body: FutureBuilder<SessionSummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          // Durum 1: Veri hala yükleniyorsa (Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.brown),
            );
          } 
          
          // Durum 2: Hata oluştuysa (Error)
          else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text("Kadim kayıtlar okunamadı!"),
            );
          }

          // Durum 3: Veri başarıyla geldiyse (Success)
          final summary = snapshot.data!;
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Maceranın Analizi", 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown)
                  ),
                  const SizedBox(height: 20),
                  
                  // ARTIK SABİT DEĞİL, JSON'DAN GELEN GERÇEK VERİLER
                  _buildAnalysisCard("Toplam Aktivite", "${summary.totalEvents} Olay", Icons.bolt),
                  _buildAnalysisCard("Klavye Kullanımı", "${summary.keyboardEvents} Tuş", Icons.keyboard),
                  _buildAnalysisCard("Fare Hareketleri", "${summary.mouseEvents} Tık", Icons.mouse),
                  // Ondalık sayıyı virgülden sonra 2 basamak olacak şekilde formatladık
                  _buildAnalysisCard("Odak Yoğunluğu", summary.eventDensity.toStringAsFixed(2), Icons.psychology),
                  
                  const SizedBox(height: 30),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[900]),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("PANELİ KAPAT", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Senin yazdığın o harika yardımcı metot (DRY prensibi)
  Widget _buildAnalysisCard(String title, String value, IconData icon) {
    return Card(
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
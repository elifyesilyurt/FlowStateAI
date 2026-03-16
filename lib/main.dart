import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'focus_page.dart';
import 'services/json_loader.dart';
import 'models/session_summary.dart'; // Model sınıfımızı ekledik

void main() => runApp(const FlowStateAI());

class FlowStateAI extends StatelessWidget {
  const FlowStateAI({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.brown, 
      useMaterial3: true,
      fontFamily: 'Georgia',
    ),
    home: const DashboardPage(),
  );
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _totalSeconds = 0;
  List<String> _logs = [];
  
  // JSON verisini Model tipinde tutan Future
  late Future<SessionSummary> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    // JSON yükleme işlemini bir Future olarak başlatıyoruz
    _sessionFuture = _loadSessionData();
  }

  // SharedPreferences verilerini yükle
  Future<void> _loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalSeconds = prefs.getInt('total_seconds') ?? 0;
      _logs = prefs.getStringList('focus_logs') ?? [];
    });
  }

  // JSON'dan veriyi çekip Model sınıfına dönüştüren fonksiyon
  Future<SessionSummary> _loadSessionData() async {
    final jsonMap = await JsonLoader.loadSessionSummary();
    return SessionSummary.fromJson(jsonMap); // Model sınıfını kullanıyoruz
  }

  String _getUserTitle() {
    int minutes = _totalSeconds ~/ 60;
    if (minutes < 60) return "Acemi Hobbit";
    if (minutes < 300) return "Yüzük Taşıyıcısı";
    if (minutes < 1000) return "Gondor Akıncısı";
    return "Ak Büyücü";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC),
      appBar: AppBar(
        title: const Text("Yolculuk Paneli", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[900],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown.shade200, const Color(0xFFF4E4BC)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text("Hoş geldin, Elif", style: TextStyle(fontSize: 24, color: Colors.brown[900], fontWeight: FontWeight.bold)),
            Text(_getUserTitle(), style: TextStyle(fontSize: 16, color: Colors.orange[900], fontStyle: FontStyle.italic)),
            const SizedBox(height: 15),
            
            // --- FUTUREBUILDER ALANI ---
            FutureBuilder<SessionSummary>(
              future: _sessionFuture,
              builder: (context, snapshot) {
                // DURUM 1: Veri hala yükleniyor (Loading)
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(color: Colors.brown),
                        SizedBox(height: 10),
                        Text("Veriler Yükleniyor..."), // Plandaki Loading durumu
                      ],
                    ),
                  );
                } 
                // DURUM 2: Bir hata oluştu (Error)
                else if (snapshot.hasError) {
                  return const Center(child: Text("Veri okunamadı!")); // Plandaki Error durumu
                } 
                // DURUM 3: Başarıyla yüklendi (Success)
                else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      _buildStatCard("TOPLAM YOLCULUK SÜRESİ", "${data.durationSeconds} sn", Icons.timer),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(child: _buildMiniCard("Etkinlik", "${data.totalEvents}", Icons.bolt)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildMiniCard("Yoğunluk", "${data.eventDensity}", Icons.analytics)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => const FocusPage()));
                _loadLocalData();
                setState(() { _sessionFuture = _loadSessionData(); });
              },
              icon: const Icon(Icons.map_sharp, color: Colors.white),
              label: const Text("MACERAYA DEVAM ET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text("📜 Yolculuk Günlüğü", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
            
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(15)),
                child: _logs.isEmpty 
                  ? const Center(child: Text("Henüz bir iz bırakmadın..."))
                  : ListView.builder(
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          leading: Icon(Icons.auto_stories, color: Colors.brown[400], size: 20),
                          title: Text(_logs[index], style: const TextStyle(fontSize: 14, color: Colors.black87)),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.brown),
          Text(title, style: const TextStyle(letterSpacing: 1.2, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown[900])),
        ],
      ),
    );
  }

  Widget _buildMiniCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.brown.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: Colors.brown[700]),
          Text(title, style: const TextStyle(fontSize: 10)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

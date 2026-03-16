import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'focus_page.dart';

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

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalSeconds = prefs.getInt('total_seconds') ?? 0;
      _logs = prefs.getStringList('focus_logs') ?? [];
    });
  }

  String _getUserTitle() {
    int minutes = _totalSeconds ~/ 60;
    if (minutes < 60) return "Acemi Hobbit";
    if (minutes < 300) return "Yüzük Taşıyıcısı";
    if (minutes < 1000) return "Gondor Akıncısı";
    return "Ak Büyücü";
  }

  String _formatTotalTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "$minutes dk $seconds sn";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E4BC),
      appBar: AppBar(
        title: const Text("Yolculuk Paneli", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[900],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white70),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('focus_logs');
              _loadStats();
            },
          )
        ],
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
            const SizedBox(height: 20),
            Text("Hoş geldin, Elif", style: TextStyle(fontSize: 26, color: Colors.brown[900], fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(_getUserTitle(), style: TextStyle(fontSize: 18, color: Colors.orange[900], fontStyle: FontStyle.italic)),
            const SizedBox(height: 20),
            
            // Veri Kartı - Güncel Renk Kullanımı (withValues)
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.brown.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(color: Colors.brown.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                children: [
                  Text("TOPLAM YOLCULUK SÜRESİ", style: TextStyle(letterSpacing: 1.5, color: Colors.brown[700], fontSize: 10)),
                  const SizedBox(height: 10),
                  Text(_formatTotalTime(_totalSeconds), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown[900])),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => const FocusPage()));
                _loadStats();
              },
              icon: const Icon(Icons.map_sharp, color: Colors.white),
              label: const Text("MACERAYA DEVAM ET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 30),
            const Text("📜 Yolculuk Günlüğü", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
            const SizedBox(height: 10),
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
}
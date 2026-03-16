import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  // --- Orta Dünya Renk Paleti ---
  final Color parchmentColor = const Color(0xFFF4E4BC); 
  final Color mordorFire = const Color(0xFFE65100);

  int _secondsRemaining = 1500; // 25 dakika
  int _initialSeconds = 1500;   // Seans başladığındaki saniye (Hesaplama için)
  Timer? _timer;
  bool _isTimerRunning = false;

  // --- LOGLAMA VE HASSAS VERİ KAYDI ---
  Future<void> _saveFocusTime(int secondsWorked) async {
    if (secondsWorked < 1) return; // 1 saniyeden az ise kaydetme

    final prefs = await SharedPreferences.getInstance();

    // 1. Toplam Saniyeyi Güncelle (Dakika yerine saniye tutarak hassasiyeti artırdık)
    int currentTotalSeconds = prefs.getInt('total_seconds') ?? 0;
    await prefs.setInt('total_seconds', currentTotalSeconds + secondsWorked);
    
    // 2. Yolculuk Günlüğü (Log) Oluştur
    List<String> logs = prefs.getStringList('focus_logs') ?? [];
    
    // Şu anki saat bilgisini al (Örn: 14:30)
    DateTime now = DateTime.now();
    String timestamp = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    
    // Saniyeyi dakika/saniye formatına çevir
    int mins = secondsWorked ~/ 60;
    int secs = secondsWorked % 60;
    String durationText = mins > 0 ? "$mins dk $secs sn" : "$secs sn";

    // Yeni kaydı listenin başına ekle (en son seans en üstte görünsün)
    logs.insert(0, "$timestamp - $durationText odaklanıldı.");
    
    // Listeyi kaydet
    await prefs.setStringList('focus_logs', logs);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Macerada $durationText kaydedildi!"),
          backgroundColor: mordorFire,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _startTimer() {
    // Başladığımız anki kalan süreyi referans alalım
    _initialSeconds = _secondsRemaining; 
    
    setState(() { _isTimerRunning = true; });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() { _secondsRemaining--; });
      } else {
        _timer?.cancel();
        setState(() { _isTimerRunning = false; });
        _saveFocusTime(_initialSeconds); // Seans tam biterse tüm süreyi kaydet
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    
    // HESAPLAMA: Başlangıçtaki kalan saniye - Şu anki kalan saniye = Harcanan emek
    int worked = _initialSeconds - _secondsRemaining;
    
    if (worked > 0) {
      _saveFocusTime(worked);
    }
    
    setState(() { _isTimerRunning = false; });
  }

  void _resetTimer() {
    _pauseTimer(); // Resetlemeden önce mevcut ilerlemeyi günlüğe yaz
    setState(() { 
      _secondsRemaining = 1500; 
      _initialSeconds = 1500;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: parchmentColor, 
      appBar: AppBar(
        title: const Text('Mordor Yolculuğu'),
        backgroundColor: Colors.brown[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: 1 - (_secondsRemaining / 1500),
                    backgroundColor: Colors.brown[200],
                    color: mordorFire,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  const Text("Yol Devam Ediyor...", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.brown)),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Icon(
              _isTimerRunning ? Icons.terrain : Icons.wb_sunny, 
              size: 100, 
              color: Colors.brown[700]
            ),
            const SizedBox(height: 20),
            Text(
              _formatTime(_secondsRemaining),
              style: TextStyle(
                fontSize: 70, 
                fontWeight: FontWeight.bold, 
                color: Colors.brown[900],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _isTimerRunning ? "Yüzük Taşıyıcısı Odaklanıyor..." : "Mola Ver, Dostum (Mellon)",
              style: TextStyle(color: Colors.brown[600], fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isTimerRunning ? _pauseTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerRunning ? Colors.amber[800] : Colors.green[900],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text(_isTimerRunning ? 'YOLU DURDUR' : 'YOLCULUĞA BAŞLA'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[400],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text('SHIRE\'A DÖN'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
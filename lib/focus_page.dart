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
  final Color gondorBlue = const Color(0xFF203354);
  final Color mordorFire = const Color(0xFFE65100);

  int _secondsRemaining = 1500; // Kalan süre
  int _initialSeconds = 1500;   // Seans başladığındaki toplam süre (Hesaplama için)
  Timer? _timer;
  bool _isTimerRunning = false;

  // Veriyi saniye bazlı hesaplayıp kaydeden gelişmiş fonksiyon
  Future<void> _saveFocusTime(int secondsWorked) async {
    // 10 saniyeden az çalışıldıysa kaydetme (opsiyonel limit)
    if (secondsWorked < 10) return;

    final prefs = await SharedPreferences.getInstance();
    int currentTotalMinutes = prefs.getInt('total_minutes') ?? 0;
    
    // Saniyeyi dakikaya çeviriyoruz (en az 1 dakikaya yuvarlar)
    int minutesToAdd = (secondsWorked / 60).ceil(); 
    
    await prefs.setInt('total_minutes', currentTotalMinutes + minutesToAdd);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$minutesToAdd dakika Mordor yolunda kaydedildi!"),
          backgroundColor: mordorFire,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _startTimer() {
    // Başladığımız anki süreyi hafızaya alalım (hesaplama için başlangıç noktası)
    _initialSeconds = _secondsRemaining; 
    
    setState(() { _isTimerRunning = true; });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() { _secondsRemaining--; });
      } else {
        _timer?.cancel();
        setState(() { _isTimerRunning = false; });
        // Seans tam biterse tüm süreyi kaydet
        _saveFocusTime(_initialSeconds);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    
    // ÇALIŞILAN SÜRE HESABI: Başlangıç süresinden kalan süreyi çıkar
    int worked = _initialSeconds - _secondsRemaining;
    
    if (worked > 0) {
      _saveFocusTime(worked);
    }
    
    setState(() { _isTimerRunning = false; });
  }

  void _resetTimer() {
    _pauseTimer(); // Önce çalışılan süreyi kaydeder
    setState(() { _secondsRemaining = 1500; });
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
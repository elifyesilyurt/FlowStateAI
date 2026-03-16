import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 1. Adım: Hafıza paketi eklendi

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

  int _secondsRemaining = 1500; // 25 dakika
  Timer? _timer;
  bool _isTimerRunning = false;

  // 2. Adım: Veriyi hafızaya kaydeden fonksiyon eklendi
  Future<void> _saveFocusTime(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    int currentTotal = prefs.getInt('total_minutes') ?? 0;
    await prefs.setInt('total_minutes', currentTotal + minutes);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$minutes dakika Mordor yolunda kaydedildi!"),
          backgroundColor: mordorFire,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _startTimer() {
    setState(() { _isTimerRunning = true; });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() { _secondsRemaining--; });
      } else {
        _timer?.cancel();
        setState(() { _isTimerRunning = false; });
        // 3. Adım: Süre bittiğinde otomatik kaydet!
        _saveFocusTime(25);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() { _isTimerRunning = false; });
  }

  void _resetTimer() {
    _pauseTimer();
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
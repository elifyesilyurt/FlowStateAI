import 'dart:async'; // Zamanlayıcı (Timer) için gerekli
import 'package:flutter/material.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  // --- DEĞİŞKENLERİMİZ ---
  int _secondsRemaining = 1500; // 25 dakika (25 * 60 saniye)
  Timer? _timer;
  bool _isTimerRunning = false;

  // --- SAYAÇ MANTIĞI ---
  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  // Saniyeyi Dakika:Saniye formatına çeviren yardımcı fonksiyon
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Odaklanma Seansı'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bilişsel yükü temsil eden ilerleme çubuğu (TÜBİTAK Dokunuşu)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: 1 - (_secondsRemaining / 1500),
                backgroundColor: Colors.grey[300],
                color: Colors.deepOrange,
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 50),
            const Icon(Icons.psychology, size: 80, color: Colors.deepOrange),
            const SizedBox(height: 20),
            Text(
              _formatTime(_secondsRemaining),
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isTimerRunning ? null : _startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('BAŞLAT', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Sayfa kapanınca sayacı durdur ki hafıza dolmasın
    super.dispose();
  }
}
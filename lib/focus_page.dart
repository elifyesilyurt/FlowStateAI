import 'dart:async';
import 'package:flutter/material.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int _secondsRemaining = 1500; // 25 Dakika
  Timer? _timer;
  bool _isTimerRunning = false;

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

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      _secondsRemaining = 1500;
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
      appBar: AppBar(
        title: const Text('Odaklanma Seansı'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // İlerleme Çubuğu (TÜBİTAK Proje Temeli)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isTimerRunning ? _pauseTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerRunning ? Colors.amber : Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(_isTimerRunning ? 'DURAKLAT' : 'BAŞLAT', style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('SIFIRLA', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ana Sayfaya Dön', style: TextStyle(color: Colors.grey)),
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
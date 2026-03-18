import 'package:flutter/material.dart';
// Önemli: Kendi ekranlarımızı buraya tanıtıyoruz
import 'screens/home_screen.dart';

void main() => runApp(const FlowStateAI());

class FlowStateAI extends StatelessWidget {
  const FlowStateAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowStateAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        fontFamily: 'Georgia', // Orta Dünya havası için [cite: 100-101]
      ),
      // Uygulama artık doğrudan Dashboard'a değil, 
      // Hoş geldin ekranına (HomeScreen) gidecek [cite: 5-6, 121]
      home: const HomeScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'focus_page.dart';

void main() => runApp(const FlowStateAI());

class FlowStateAI extends StatelessWidget {
  const FlowStateAI({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
    home: const DashboardPage(),
  );
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _totalMinutes = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalMinutes = prefs.getInt('total_minutes') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlowStateAI Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hoş geldin Elif!", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text("$_totalMinutes Dakika Odaklandın", 
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FocusPage())),
              child: const Text("ODAKLANMAYA BAŞLA"),
            ),
          ],
        ),
      ),
    );
  }
}
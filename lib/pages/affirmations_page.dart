import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AffirmationsPage extends StatefulWidget {
  const AffirmationsPage({super.key});
  @override
  State<AffirmationsPage> createState() => _AffirmationsPageState();
}

class _AffirmationsPageState extends State<AffirmationsPage> {
  static const _kAffirmIdx = 'affirmation_index';
  static const _kAffirmDate = 'affirmation_date';
  
  final _quotes = const [
    'I inhale calm and exhale stress.',
    'I am present. I am grounded.',
    'Every breath resets my mind.',
    'I choose peace over worry.',
    'Small steps today create big change.',
    'I treat myself with kindness.',
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadOrRotate();
  }

  Future<void> _loadOrRotate() async {
    final p = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final savedDate = p.getString(_kAffirmDate);
    int idx = p.getInt(_kAffirmIdx) ?? 0;

    // rotate once per day
    if (savedDate != today) {
      idx = (idx + 1) % _quotes.length;
      await p.setInt(_kAffirmIdx, idx);
      await p.setString(_kAffirmDate, today);
    }
    setState(() => _index = idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Affirmation')),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _quotes[_index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
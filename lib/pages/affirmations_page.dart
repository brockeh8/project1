import 'dart:math';
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
    'I am worthy of self-care.',
    'I embrace the present moment.',
    'I am in control of my thoughts.',
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

  Future<void> _shuffleNow() async {
    final p = await SharedPreferences.getInstance();
    final rng = Random(DateTime.now().microsecondsSinceEpoch);

    int next = rng.nextInt(_quotes.length);
    if (_quotes.length > 1) {
      while (next == _index) {
        next = rng.nextInt(_quotes.length);
      }
    }

    await p.setInt(_kAffirmIdx, next); // persist new pick
    setState(() => _index = next);
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _quotes[_index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _shuffleNow,
                      label: const Text('New Random Affirmation'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
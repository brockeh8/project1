import 'dart:async';
import 'package:flutter/material.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});
  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int _seconds = 60; // default 1 min
  int _left = 60;
  Timer? _timer;
  bool get _running => _timer?.isActive ?? false;

  void _start() {
    _left = _seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left <= 1) {
        t.cancel();
        setState(() => _left = 0);
      } else {
        setState(() => _left -= 1);
      }
    });
    setState(() {});
  }

  void _stop() {
    _timer?.cancel();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _fmt(int s) => '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meditation')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Set session length (minutes)'),
            Slider(
              value: (_seconds / 60).clamp(1, 30).toDouble(),
              min: 1, max: 30, divisions: 29,
              label: '${(_seconds/60).round()} min',
              onChanged: _running ? null : (v) => setState(() => _seconds = (v.round() * 60)),
            ),
            const SizedBox(height: 8),
            Text(_fmt(_running ? _left : _seconds), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(spacing: 12, children: [
              ElevatedButton.icon(onPressed: _running ? null : _start, icon: const Icon(Icons.play_circle), label: const Text('Start')),
              ElevatedButton.icon(onPressed: _running ? _stop : null, icon: const Icon(Icons.stop_circle_outlined), label: const Text('Stop')),
            ]),
            const SizedBox(height: 24),
            const Text('Tip: Sit comfortably, eyes soft. Notice your breath. If your mind wanders, gently return to the breath.'),
          ],
        ),
      ),
    );
  }
}
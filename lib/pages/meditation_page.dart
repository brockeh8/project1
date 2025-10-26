import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int _seconds = 60;
  int _left = 60;
  Timer? _timer;
  bool get _running => _timer?.isActive ?? false;
  final AudioPlayer _bgPlayer = AudioPlayer();
  double _volume = 0.6;

  @override
  void initState() {
    super.initState();
    _bgPlayer.setReleaseMode(ReleaseMode.loop); 
    _bgPlayer.setVolume(_volume);
  }

  Future<void> _start() async {
    _left = _seconds;
    _timer?.cancel();

    try {
      await _bgPlayer.stop();
      await _bgPlayer.play(AssetSource('calm.mp3'));
    } catch (_) {}

    _timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      if (_left <= 1) {
        t.cancel();
        setState(() => _left = 0);
        await _stopAudio(); //stop when timer is done
      } else {
        setState(() => _left -= 1);
      }
    });

    setState(() {});
  }

  Future<void> _stop() async {
    _timer?.cancel();
    await _stopAudio();
    setState(() {});
  }

  Future<void> _stopAudio() async {
    try { await _bgPlayer.stop(); } catch (_) {}
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bgPlayer.dispose();
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
              min: 1,
              max: 30,
              divisions: 29,
              label: '${(_seconds / 60).round()} min',
              onChanged: _running ? null : (v) => setState(() => _seconds = (v.round() * 60)),
            ),
            const SizedBox(height: 8),
            Text(_fmt(_running ? _left : _seconds),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(spacing: 12, children: [
              ElevatedButton.icon(
                  onPressed: _running ? null : _start,
                  icon: const Icon(Icons.play_circle),
                  label: const Text('Start')),
              ElevatedButton.icon(
                  onPressed: _running ? _stop : null,
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: const Text('Stop')),
            ]),
            const SizedBox(height: 24),
            const Text(
              'Tip: Sit comfortably, eyes soft. Notice your breath. If your mind wanders, gently return to the breath.',
            ),
          ],
        ),
      ),
    );
  }
}
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
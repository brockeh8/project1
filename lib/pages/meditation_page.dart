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

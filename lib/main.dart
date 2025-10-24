import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pages/breathing_page.dart';
import 'pages/meditation_page.dart';
import 'pages/mood_page.dart';
import 'pages/journal_page.dart';
import 'pages/affirmations_page.dart';

void main() => runApp(const MindfulnessApp());

class MindfulnessApp extends StatelessWidget {
const MindfulnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF6370D9); //tbd if this is for sure
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mindfulness App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        useMaterial3: true,
        fontFamily: 'Sans',
      ),
      home :const HomePage(),
      routes: {
        //routes blank till update shooting for later today
        '/': (_) => const HomePage(),
        '/breathing': (_) => const BreathingPage(),
        '/meditation': (_) => const MeditationPage(),
        '/mood': (_) => const MoodPage(),
        '/journal': (_) => const JournalPage(),
        '/affirmations': (_) => const AffirmationsPage(),
      },
    );
  }
}

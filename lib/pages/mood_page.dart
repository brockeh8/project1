import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});
  @override
  State<MoodPage> createState() => _MoodPageState();
}
// First: Implemented the state and types
class _MoodPageState extends State<MoodPage> {
  static const String moodLogsKey = 'mood_logs'; 
  final List<String> moods = ['Sad', 'Alright', 'Happy'];
  double slider = 1; 
  List<Map<String, String>> logs = [];

  @override
  void initState() {
    super.initState();
    // Next I need to load persisted logs
    _load();
  }
  //moved

  //helper

  //log -- specific date??

  //final scaffold 
}




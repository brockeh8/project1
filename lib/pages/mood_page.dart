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
        _load();
    }

    Future<void> _load() async {
        final p = await SharedPreferences.getInstance();
        final raw = p.getString(moodLogsKey);
        if (raw != null) {
            final list = (jsonDecode(raw) as List)
                .cast<Map>()
                .map((e) => e.map((k, v) => MapEntry(k.toString(), v.toString())))
                .toList();
            setState(() => logs = list);
        }
    }
    //save helper
    Future<void> _save() async {
        final p = await SharedPreferences.getInstance();
        await p.setString(moodLogsKey, jsonEncode(logs));
    }

    //log
    Future<void> _logToday() async {
        final today = DateTime.now().toIso8601String().substring(0, 10);
        final mood = moods[slider.round()];
        logs.removeWhere((e) => e['date'] == today);
        logs.insert(0, {'date': today, 'mood': mood});
        await _save();
        setState(() {});
    }
}
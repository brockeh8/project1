import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  static const _kJournal = 'journal_entries'; // JSON list of {date, text}
  final _controller = TextEditingController();
  List<Map<String, String>> _entries = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_kJournal);
    if (raw != null) {
      final list = (jsonDecode(raw) as List).cast<Map>().map((e) => e.map((k, v) => MapEntry(k.toString(), v.toString()))).toList();
      setState(() => _entries = list);
    }
  }

  Future<void> _saveAll() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kJournal, jsonEncode(_entries));
  }
  
  Future<void> _add() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _entries.insert(0, {
      'date': DateTime.now().toIso8601String().substring(0, 16).replaceFirst('T', ' '),
      'text': text,
    });
    _controller.clear();
    await _saveAll();
    setState(() {});
  }

  Future<void> _delete(int i) async {
    _entries.removeAt(i);
    await _saveAll();
    setState(() {});
  }
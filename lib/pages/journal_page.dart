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
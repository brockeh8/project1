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
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadOrRotate();
  }

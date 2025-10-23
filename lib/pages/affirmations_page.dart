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
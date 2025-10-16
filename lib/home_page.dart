import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    // new checklist keys and obj
    static const String breathingkey = 'obj_breathing_fin'
    static const String meditationkey = 'obj_meditation_fin'
    static const String journalkey = 'obj_journal_fin'

    bool _breathing = false;
    bool _meditation = false;
    bool _journal = false;

    //init
    @override initState() {
        super.initState();
        _loadObjectives();
    }

    //obj menu
    Future<void> _loadObjectives() async {
        final p = await Shared_preferences.getInstance();
        setState(() {
            _breathing = p.getBool(breathingkey) ?? false; //comp??
            _meditation = p.getBool(meditationkey) ?? false;
            _breathing = p.getBool(journalkey) ?? false;
        });
    }
    
    
    Future<void> _save(String key, bool value) async {
        final p = await Shared_preferences.getInstance();
        await p.setBool(key, value); //come back if simple bool doesnt work
    }

    Widget _leftMenu(BuildContext context) {
        Widget menuButton(String label, String route) {
            //cont with padding child buttons
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, route),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
            );
        }
    }


    //page menu 


    //card designs
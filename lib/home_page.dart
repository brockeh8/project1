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
        //card widgets
        return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 260),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            const SizedBox(height: 6),
                            menuButton('Breathing Exercises', '/breathing'),
                            menuButton('Meditation', '/meditation'),
                            menuButton('Mood Slider', '/mood'),
                            menuButton('Journal', '/journal'),
                            const SizedBox(height: 8),
                            TextButton.icon(
                                onPressed: () => Navigator.pushNamed(context, '/affirmations'),
                                icon: const Icon(Icons.sunny_snowing),
                                label: const Text('Daily Affirmations'),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
    //right list of todos
    Widget _rightObjectives() {
        return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 320),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            const Center(
                                child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text('Daily Objectives', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                                ),
                            ),
                            const Divider(),
                            CheckboxListTile(
                                value: _breathing,
                                onChanged: (v) => setState(() {
                                _breathing = v ?? false;
                                _save(breathingKey, _breathing);
                                }),
                                title: const Text('Complete Breathing Exercise'),
                                controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                                value: _meditation,
                                onChanged: (v) => setState(() {
                                _meditation = v ?? false;
                                _save(meditationKey, _meditation);
                                }),
                                title: const Text('Complete Meditation Session'),
                                controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                                value: _journal,
                                onChanged: (v) => setState(() {
                                _journal = v ?? false;
                                _save(journalKey, _journal);
                                }),
                                title: const Text('Log Daily Journal Entry'),
                                controlAffinity: ListTileControlAffinity.leading,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }   

    //page menu 


    //card designs
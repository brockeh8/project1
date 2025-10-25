import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    // new checklist keys and obj
    static const String breathingKey = 'obj_breathing_fin';
    static const String meditationKey = 'obj_meditation_fin';
    static const String journalKey = 'obj_journal_fin';

    bool _breathing = false;
    bool _meditation = false;
    bool _journal = false;

    //init
    @override 
    void initState() {
        super.initState();
        _loadObjectives();
    }

    //obj menu
    Future<void> _loadObjectives() async {
        final p = await SharedPreferences.getInstance();
        setState(() {
            _breathing = p.getBool(breathingKey) ?? false; //comp??
            _meditation = p.getBool(meditationKey) ?? false;
            _journal = p.getBool(journalKey) ?? false;
        });
    }
    
    
    Future<void> _save(String key, bool value) async {
        final p = await SharedPreferences.getInstance();
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
                            menuButton('Daily Affirmations', '/affirmations'),
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
                            //random examples tbd
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

    @override
    Widget build(BuildContext context) {
        final isWide = MediaQuery.of(context).size.width >= 900;

        return Scaffold(
            appBar: AppBar(
                title: const Text('Welcome to Mellowmind'),
                centerTitle: true,
            ),
            body: Column(
                children: [
                    // Main content area
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: isWide
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Expanded(flex: 5, child: _leftMenu(context)),
                                        const SizedBox(width: 24),
                                        Expanded(flex: 5, child: _rightObjectives()),
                                    ],
                                )
                                : ListView(
                                    children: [
                                        _leftMenu(context),
                                        const SizedBox(height: 16),
                                        _rightObjectives(),
                                    ],
                                ),
                        ),
                    ),
                    // Bottom quote bar
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                    child: Text(
                                        '"Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment." – Buddha',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}
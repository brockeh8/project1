
10/20
ChatGPT
Why is my home_page.dart not working with my keys for the objective storage?

Gave me advice on naming conventions for the keys and showed me why to use _breathing, for example, to keep private tabs, and told me to capitalize Key for consistency. 

I learned that keys are very specific to their original and keeping variables separate is a great way to manage local data (kept this consistent throughout the rest of the code) 

Updated Snippet:
Future<void> _loadObjectives() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
        _breathing = p.getBool(breathingKey) ?? false; //comp??
        _meditation = p.getBool(meditationKey) ?? false;
         _journal = p.getBool(journalKey) ?? false;
    });
}



10/23
ChatGPT
Asked: Why journal entries were not being saved locally.

It gave me advice on mainly focused on helping the app store journal entries locally, reload them when reopened, and update the UI in real time.

I learned how to use jsonEncode() to convert the list into a string for storage and jsonDecode() to restore it when the app loads.

Updated code snippet:
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



10/25
ChatGPT
Asked: How can I make my audio file stop with the built in timer?

It told me to declare the timer early and set its controls when the audio stops: when the countdown hits zero, the timer callback calls _stopAudio() making the audio and app stop simultaneously.

I learned that you can use a mini timer to constantly check if the actual countdown is done. Also, this gave me the idea to add a try and catch to make sure the timer still works even if the audio doesn't load.

_timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      if (_left <= 1) {
        t.cancel();
        setState(() => _left = 0);
        await _stopAudio(); //stop when timer is done
      } else {
        setState(() => _left -= 1);
      }
    });

    setState(() {});
}







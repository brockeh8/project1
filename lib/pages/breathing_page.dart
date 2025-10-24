import 'dart:async';
import 'package:flutter/material.dart';

class BreathingPage extends StatefulWidget {
    const BreathingPage({super.key});
    @override
    State<BreathingPage> createState() => _BreathingPageState();
}
class _BreathingPageState extends State<BreathingPage> {
    bool _running = false;
    double _size = 120;
    Timer? _timer;
    int _phase = 0; //change depending on timing

    void _start() {
        _running = true;
        _phase = 0;
        _cycle();
    }
    //super simple size switching for now may look for animations later
    void _cycle() {
        if (!_running) return;
        setState(() {
            if (_phase == 0) {      //bigger
                _size = 200;
            } 
            else if (_phase == 1) { //mid
                _size = 200;
            } 
            else {                  //smaller
                _size = 100;
            }
        });

        final durations = [const Duration(seconds: 4), const Duration(seconds: 4), const Duration(seconds: 6)];
        _timer?.cancel();
        _timer = Timer(durations[_phase], () {
            _phase = (_phase + 1) % 3;
            _cycle();
        });
    }

    void _stop() {
        setState(() => _running = false);
        _timer?.cancel();
    }

    @override
    void dispose() {
        _timer?.cancel();
        super.dispose();
    }

//breathing

//animation pro

//final widget creation + text


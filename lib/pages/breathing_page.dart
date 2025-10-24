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

    void _cycle() {
        //rest of timer
    }

    //research how to do animaiton linked to timer
    
//breathing

//animation pro

//final widget creation + text


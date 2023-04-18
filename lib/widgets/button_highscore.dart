import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighscoreButton extends StatefulWidget {
  const HighscoreButton({super.key});

  @override
  State<HighscoreButton> createState() => _HighscoreButtonState();
}

class _HighscoreButtonState extends State<HighscoreButton> {
  // initialising the highscore
  var _highscore;

  // timer to update the highscore
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _loadHighscore();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _loadHighscore();
      });
    });
  }

  // Loading the highscore on start
  Future<void> _loadHighscore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _highscore = prefs.getInt('highscore') ?? 'non-existent';
    });
  }

  // reset highscore on button press
  Future<void> _resetHighscore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('highscore', 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      key: UniqueKey(),
      heroTag: UniqueKey(),
      label: Text(
        'Highscore is $_highscore',
      ),
      backgroundColor: const Color(0xffe5e5e5),
      foregroundColor: const Color(0xff003049),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      icon: const Icon(
        Icons.arrow_upward_outlined,
        size: 24.0,
        color: Colors.blueAccent,
      ),
      onPressed: () {
        _resetHighscore();
      },
    );
  }

  // used to free the timer
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}

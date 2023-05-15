import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighscoreButton extends StatefulWidget {
  final bool canReset;

  const HighscoreButton({
    super.key,
    required this.canReset,
  });

  @override
  State<HighscoreButton> createState() => _HighscoreButtonState();
}

class _HighscoreButtonState extends State<HighscoreButton> {
  // initialising the highscore
  // ignore: prefer_typing_uninitialized_variables
  int _highscore = 0;

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
      _highscore = prefs.getInt('highscore') ?? 0;
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
        Icons.info_outlined,
        size: 24.0,
        color: Colors.blueAccent,
      ),
      onPressed: () {
        widget.canReset ? _resetHighscore() : null;
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

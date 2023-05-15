import 'dart:async';

import 'package:flutter/material.dart';

class EndGameRoute extends StatefulWidget {
  final int score;
  final int highscore;
  const EndGameRoute({
    super.key,
    required this.score,
    required this.highscore,
  });

  @override
  State<EndGameRoute> createState() => _EndGameRouteState();
}

class _EndGameRouteState extends State<EndGameRoute> {
  // after 3 seconds, it goes to the previous screen
  late Timer _timer;
  final int _countdownDuration = 1000;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: _countdownDuration), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(-5 / 10),
              begin: Alignment.topCenter,
              end: Alignment(0.8, 1),
              colors: [
                Color(0xff003049),
                Color(0xffd62828),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Congratulations on guessing',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.score.toString(),
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Logos!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'goBack',
                    label: const Text(
                      'Main menu',
                    ),
                    backgroundColor: const Color(0xffe5e5e5),
                    foregroundColor: const Color(0xff003049),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24.0,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

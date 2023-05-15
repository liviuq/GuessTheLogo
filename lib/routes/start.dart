import 'package:flutter/material.dart';

import '../widgets/button_highscore.dart';
import '../widgets/button_share.dart';
import 'about.dart';
import 'game.dart';

class StartRoute extends StatelessWidget {
  const StartRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.8, 1),
              colors: [
                Color(0xff003049),
                Color(0xffd62828),
                Color(0xfff77f00),
                Color(0xfffcbf49),
                Color(0xffeae2b7),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // adding the image and button for the app
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'newGame',
                    label: const Text(
                      'Start new game',
                    ),
                    backgroundColor: const Color(0xffe5e5e5),
                    foregroundColor: const Color(0xff003049),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      size: 24.0,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameRoute(),
                        ),
                      ),
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: HighscoreButton(
                    canReset: true,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ShareButton(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'informations',
                    label: const Text(
                      'About app',
                    ),
                    backgroundColor: const Color(0xffe5e5e5),
                    foregroundColor: const Color(0xff003049),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    icon: const Icon(
                      Icons.details_outlined,
                      size: 24.0,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutRoute(),
                        ),
                      ),
                    },
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

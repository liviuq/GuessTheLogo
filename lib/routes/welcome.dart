import 'package:flutter/material.dart';

import 'start.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // stack used to overlap the gradient with the scaffold
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
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // adding the image and button for the app
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Center(
                child: Image(
                  // placeholder for the logo of the game
                  image: AssetImage('assets/apple.png'),
                ),
              ),
              FloatingActionButton.extended(
                // hero tag required for navigation
                // between pages. Flutter gets confused as which
                // buttons to re-render
                heroTag: 'goToStartPage',
                label: const Text(
                  'Start the game!',
                ),
                backgroundColor: const Color(0xffe5e5e5),
                foregroundColor: const Color(0xff003049),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                icon: const Icon(
                  Icons.play_arrow,
                  size: 24.0,
                  color: Colors.blueAccent,
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartRoute(),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

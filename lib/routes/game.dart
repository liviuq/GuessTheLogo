import 'package:flutter/material.dart';
import '../widgets/image_with_input.dart';

class GameRoute extends StatelessWidget {
  const GameRoute({super.key, required});

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
              ],
            ),
          ),
        ),
        const Center(
          child: ImageWithInput(),
        ),
      ],
    );
  }
}

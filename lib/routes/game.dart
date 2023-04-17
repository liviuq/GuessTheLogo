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
                Color(0xfffff9ec),
                Color(0xffffdccc),
                Color(0xfffcb1a6),
                Color(0xfffb6376),
                Color(0xff5d2a42),
              ],
            ),
          ),
        ),
        Center(
          child: ImageWithInput(),
        ),
      ],
    );
  }
}
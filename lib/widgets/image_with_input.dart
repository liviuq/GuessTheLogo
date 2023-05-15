import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_logo/widgets/button_highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageWithInput extends StatefulWidget {
  const ImageWithInput({super.key});

  @override
  State<ImageWithInput> createState() => _ImageWithInputState();
}

class _ImageWithInputState extends State<ImageWithInput> {
  // for the text field to get the current input text
  TextEditingController guessController = TextEditingController();

  // list of image paths
  List<String> _images = [];

  // current image drawn on the screen
  int _currentIndex = 0;
  String _currentAnswer = '';

  // current score
  int _score = 0;
  int _highscore = 8;

  //continue untill no lives remaining
  int _livesRemaining = 3;

  @override
  void initState() {
    super.initState();
    _getAssetKeys();
  }

  Future<void> _getAssetKeys() async {
    // getting the assets folder from android
    // code snippet provided by Flutter docs
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final keys =
        manifestMap.keys.where((String key) => key.contains('.png')).toList();

    // obtaining shared preferences
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _images = keys;
      _currentAnswer = _images[0].replaceFirst('assets/', '');
      _highscore = prefs.getInt('highscore') ?? -11;
    });
  }

  // method to set the highscore
  void _setHighscore(int newHighscore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highscore', newHighscore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.8, 1),
                colors: [
                  Color(0xffffffff),
                  Color(0xff84dcc6),
                  Color(0xffa5ffd6),
                  Color(0xffffa69e),
                  Color(0xffff686b),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _images.isEmpty
                      ? const CircularProgressIndicator()
                      : Image.asset(
                          _images[_currentIndex],
                          width: 256,
                          height: 256,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.left,
                    controller: guessController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffe5e5e5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter a name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'submitGuess',
                    label: const Text(
                      'Submit your guess!',
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
                      if (guessController.text.isNotEmpty) {
                        setState(() {
                          _currentAnswer = _images[_currentIndex]
                              .replaceFirst('assets/', '')
                              .replaceFirst('.png', '');
                          _currentIndex = (_currentIndex + 1) % _images.length;
                          if (_currentAnswer == guessController.text) {
                            _score++;
                          } else {
                            _livesRemaining--;
                          }

                          if (_score > _highscore) {
                            // ignore: avoid_print
                            print('new highscore!');
                            _setHighscore(_score);
                          }

                          // ignore: avoid_print
                          print(
                              'guess = ${guessController.text}, answer = $_currentAnswer. score = $_score. lives = $_livesRemaining. highscore = $_highscore');
                          guessController.clear();
                        });
                      }

                      if (_livesRemaining == 0) {
                        if (_score > _highscore) {
                          // ignore: avoid_print
                          print('new highscore!');
                          _setHighscore(_score);
                        }
                        Navigator.pop(
                          context,
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: HighscoreButton(
                    canReset: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

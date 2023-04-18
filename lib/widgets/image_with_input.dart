import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageWithInput extends StatefulWidget {
  const ImageWithInput({super.key});

  @override
  State<ImageWithInput> createState() => _ImageWithInputState();
}

class _ImageWithInputState extends State<ImageWithInput> {
  TextEditingController guessController = TextEditingController();
  List<String> _images = [];
  int _currentIndex = 0;
  String _currentAnswer = '';
  int _score = 0;
  int _livesRemaining = 3;

  @override
  void initState() {
    super.initState();
    _getAssetKeys();
  }

  Future<void> _getAssetKeys() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final keys =
        manifestMap.keys.where((String key) => key.contains('.png')).toList();

    setState(() {
      _images = keys;
      _currentAnswer = _images[0].replaceFirst('assets/', '');
    });
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
                          print(
                              'guess = ${guessController.text}, answer = ${_currentAnswer}. score = ${_score}. lives = ${_livesRemaining}');
                          guessController.clear();
                        });
                      }

                      if (_livesRemaining == 0) {
                        Navigator.pop(
                          context,
                        );
                      }
                    },
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

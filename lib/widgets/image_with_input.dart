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
  List<String> _images = [];
  int _currentIndex = 0;
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
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % _images.length;
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

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
                Color(0xffffffff),
                Color(0xff84dcc6),
                Color(0xffa5ffd6),
                Color(0xffffa69e),
                Color(0xffff686b),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _images.isEmpty
                  ? const CircularProgressIndicator()
                  : Image.asset(_images[_currentIndex]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousImage,
                  child: Text('Previous'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _nextImage,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

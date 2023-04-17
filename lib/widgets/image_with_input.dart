import 'dart:collection';
import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';

List file = [];
void _listofFiles() async {
  var directory = (await getApplicationDocumentsDirectory()).path;
  file = Directory("/assets/logos")
      .listSync(); //use your folder name insted of resume.
  file.forEach((element) {
    print(element);
  });
}

class ImageWithInput extends StatefulWidget {
  final logos = <String, String>{};
  ImageWithInput({super.key}) {
    _listofFiles();
  }

  @override
  State<ImageWithInput> createState() => _ImageWithInputState();
}

class _ImageWithInputState extends State<ImageWithInput> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

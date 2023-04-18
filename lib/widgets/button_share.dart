import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  // function to call when button is pressed
  // Loading the highscore on start
  Future<void> shareHighscore() async {
    final prefs = await SharedPreferences.getInstance();

    int highscore = prefs.getInt('highscore') ?? -11;
    Share.share('Congratulations on guessing $highscore logos in a row!',
        subject: 'My personal highscore');
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'shareOnSocial',
      label: const Text(
        'Share your score!',
      ),
      backgroundColor: const Color(0xffe5e5e5),
      foregroundColor: const Color(0xff003049),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      icon: const Icon(
        Icons.share,
        size: 24.0,
        color: Colors.blueAccent,
      ),
      onPressed: () => shareHighscore(),
    );
  }
}

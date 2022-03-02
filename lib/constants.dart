import 'package:flutter/painting.dart';

class AudioPath {
  static const String bgm = 'GB-Action-B03-2.mp3';
  static const String panel = 'cursor.wav';
  static const String clear = 'GB-General-C06-2.mp3';
}

class ImagePath {
  static const String background = 'background.png';
  static const String panel = 'panel.png';

  static const all = [
    background,
    panel,
  ];
}

class TextConfig {
  static const textStyle = TextStyle(
    fontSize: 8.0,
    color: Color(0xFF121212),
    fontFamily: 'gamegirl',
  );
}

enum Scene { title, game }

typedef StateChangeCallback = void Function(Scene, Scene);

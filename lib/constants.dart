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
  static const textC1Style = TextStyle(
    fontSize: 8.0,
    color: Colors.c1,
    fontFamily: 'gamegirl',
  );
  static const textC3Style = TextStyle(
    fontSize: 8.0,
    color: Colors.c3,
    fontFamily: 'gamegirl',
  );
}

class Colors {
  static const Color c0 = Color(0xFFE2DFB1);
  static const Color c1 = Color(0xFFB0B87F);
  static const Color c2 = Color(0xFF73825C);
  static const Color c3 = Color(0xFF444429);
}

enum Scene { title, game }

typedef StateChangeCallback = void Function(Scene, Scene);

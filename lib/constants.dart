import 'package:flutter/painting.dart';

class AudioPath {
  static const String bgm = 'GB-Action-B03-2.mp3';
  static const String panel = 'cursor.wav';
  static const String clear = 'GB-General-C06-2.mp3';
}

class ImagePath {
  static const String back = 'back.png';
  static const String background = 'background.png';
  static const String bird = 'bird.png';
  static const String panel = 'panel2.png';

  static const all = [
    back,
    background,
    bird,
    panel,
  ];
}

class FontPath {
  static const String kongText = 'kongText';
}

class TextConfig {
  static const textC1Style = TextStyle(
    fontSize: 8.0,
    color: GameColors.c1,
    fontFamily: FontPath.kongText,
  );
  static const textC3Style = TextStyle(
    fontSize: 8.0,
    color: GameColors.c3,
    fontFamily: FontPath.kongText,
  );
}

class GameColors {
  static const Color c0 = Color(0xFFE2DFB1);
  static const Color c1 = Color(0xFFB0B87F);
  static const Color c2 = Color(0xFF73825C);
  static const Color c3 = Color(0xFF444429);
}

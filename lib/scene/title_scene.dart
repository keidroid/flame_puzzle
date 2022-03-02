import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

import '../constants.dart';

class TitleScene extends Component {
  StateChangeCallback changeSceneCallback;

  late TextComponent titleTextComponent;

  TitleScene(this.changeSceneCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    final rectangle = RectangleComponent(
      size: Vector2(160, 144),
      paint: Paint()
        ..color = const Color(0xFF445566)
        ..style = PaintingStyle.fill,
    );
    add(rectangle);

    add(TextComponent(
        text: "Flutter\nSlide Puzzle\nChallenge",
        textRenderer: TextPaint(
            style: const TextStyle(
          fontSize: 24.0,
          color: Color(0xFF121212),
          fontFamily: 'PressStart2P',
        )))
      ..anchor = Anchor.center
      ..position = Vector2(60, 60));

    add(TextComponent(
        text: "PROGRAM BY KEIDROID",
        textRenderer: TextPaint(style: TextConfig.textStyle))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 136));
    add(TextComponent(
        text: "SOUND BY OTOLOGIC",
        textRenderer: TextPaint(style: TextConfig.textStyle))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 144));
  }
}

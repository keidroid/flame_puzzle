import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../constants.dart';

class TitleScene extends Component {
  StateChangeCallback changeSceneCallback;

  late TextComponent titleTextComponent;

  TitleScene(this.changeSceneCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(RectangleComponent(
      size: Vector2(160, 144),
      paint: Paint()
        ..color = Colors.c0
        ..style = PaintingStyle.fill,
    ));

    add(RectangleComponent(
      size: Vector2(160, 10),
      paint: Paint()
        ..color = Colors.c3
        ..style = PaintingStyle.fill,
    ));

    add(TextComponent(
        text: "#FlutterPuzzleHack",
        textRenderer: TextPaint(style: TextConfig.textC1Style))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 10));

    add(TextComponent(
        text: "Flutter\nSlide Puzzle",
        textRenderer: TextPaint(
            style: const TextStyle(
          fontSize: 24.0,
          color: Colors.c3,
          fontFamily: 'PressStart2P',
        )))
      ..anchor = Anchor.center
      ..position = Vector2(60, 40));

    addShadowText("PROGRAM BY KEIDROID", Vector2(80, 136));
    addShadowText("SOUND BY OTOLOGIC", Vector2(80, 144));
  }

  void addShadowText(String text, Vector2 position) {
    add(TextComponent(
        text: text, textRenderer: TextPaint(style: TextConfig.textC1Style))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(position.x, position.y + 1));
    add(TextComponent(
        text: text, textRenderer: TextPaint(style: TextConfig.textC3Style))
      ..anchor = Anchor.bottomCenter
      ..position = position);
  }
}

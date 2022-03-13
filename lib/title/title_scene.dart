import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../constants.dart';
import '../game_scene.dart';

class TitleScene extends GameScene {
  TitleScene(bool isSound, StateChangeCallback stateChangeCallback)
      : super(isSound, stateChangeCallback);

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
        text: "Slide Puzzle",
        textRenderer: TextPaint(
            style: const TextStyle(
          fontSize: 24.0,
          color: Colors.c3,
          fontFamily: 'PressStart2P',
        )))
      ..anchor = Anchor.center
      ..position = Vector2(68, 40));

    addShadowText("TAP/PRESS ENTER", Vector2(80, 88));

    addShadowText("SOUND <OFF>", Vector2(80, 112));

    addShadowText("PROGRAM BY KEIDROID", Vector2(80, 136));
    addShadowText("SOUND BY OTOLOGIC", Vector2(80, 144));

    SpriteComponent bird =
        SpriteComponent(sprite: await Sprite.load(ImagePath.bird));
    bird.position = Vector2(124, 24);

    add(bird);
  }

  @override
  void onKeyEvent(GameKeyEvent gameKeyEvent) {
    super.onKeyEvent(gameKeyEvent);

    switch (gameKeyEvent) {
      case GameKeyEvent.up:
      case GameKeyEvent.down:
        // nothing to do
        break;
      case GameKeyEvent.left:
      case GameKeyEvent.right:
        isSound = !isSound;
        break;
      case GameKeyEvent.enter:
        stateChangeCallback(this, isSound);
        break;
    }
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

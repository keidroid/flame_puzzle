import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../bird.dart';
import '../constants.dart';
import '../game_scene.dart';
import 'title_text_button.dart';

class TitleScene extends GameScene {
  final Random _random;
  late TitleTextButton _soundButton;

  TitleScene(
      this._random, bool isSound, StateChangeCallback stateChangeCallback)
      : super(isSound, stateChangeCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(RectangleComponent(
      size: Vector2(160, 144),
      paint: Paint()
        ..color = GameColors.c0
        ..style = PaintingStyle.fill,
    ));

    add(RectangleComponent(
      size: Vector2(160, 10),
      paint: Paint()
        ..color = GameColors.c3
        ..style = PaintingStyle.fill,
    ));

    add(TextComponent(
        text: "#FLUTTERPUZZLEHACK",
        textRenderer: TextPaint(style: TextConfig.textC1Style))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 10));

    add(Bird(_random)
      ..position = Vector2(68, 12)
      ..birdState = BirdState.stay);

    add(TitleTextButton("GAME START", startPuzzle)
      ..position = Vector2(80, 60)
      ..anchor = Anchor.center);

    _addSoundButton(isSound);

    add(TextComponent(
        text: "PROGRAM BY KEIDROID",
        textRenderer: TextPaint(style: TextConfig.textC3Style))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 136));
    add(TextComponent(
        text: "SOUND BY OTOLOGIC",
        textRenderer: TextPaint(style: TextConfig.textC3Style))
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(80, 144));
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
        toggleSound();
        break;
      case GameKeyEvent.enter:
        startPuzzle();
        break;
    }
  }

  void startPuzzle() {
    stateChangeCallback(this, isSound);
  }

  void toggleSound() {
    isSound = !isSound;
    remove(_soundButton);
    _addSoundButton(isSound);
  }

  void _addSoundButton(bool isSound) {
    _soundButton =
        TitleTextButton(isSound ? "SOUND <ON>" : "SOUND <OFF>", toggleSound)
          ..position = Vector2(80, 104)
          ..anchor = Anchor.center;
    add(_soundButton);
  }
}

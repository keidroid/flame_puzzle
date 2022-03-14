import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TitleTextButton extends PositionComponent with Tappable {
  final String _buttonText;
  final Function() _onTapCallback;

  TitleTextButton(this._buttonText, this._onTapCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    size = Vector2(136, 40);

    add(RectangleComponent(
      size: Vector2(136, 40),
      paint: Paint()
        ..color = GameColors.c1
        ..style = PaintingStyle.fill,
    ));
    add(RectangleComponent(
      size: Vector2(132, 36),
      paint: Paint()
        ..color = GameColors.c0
        ..style = PaintingStyle.fill,
    )..position = Vector2(2, 2));

    add(TextComponent(
        text: _buttonText,
        textRenderer: TextPaint(style: TextConfig.textC1Style))
      ..anchor = Anchor.center
      ..position = Vector2(size.x * 0.5, size.y * 0.5 + 1));
    add(TextComponent(
        text: _buttonText,
        textRenderer: TextPaint(style: TextConfig.textC3Style))
      ..anchor = Anchor.center
      ..position = Vector2(size.x * 0.5, size.y * 0.5));
  }

  @override
  bool onTapUp(TapUpInfo info) {
    _onTapCallback();
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    return true;
  }

  @override
  bool onTapCancel() {
    return true;
  }
}

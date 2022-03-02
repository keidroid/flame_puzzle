import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class GameClear extends PositionComponent {
  late Sprite sprite;

  GameClear() {
    sprite = Sprite(Flame.images.fromCache('present.png'));
  }

  @override
  void render(Canvas c) {
    sprite.render(c);
  }
}

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent {
  late Sprite sprite;

  Background() {
    sprite = Sprite(Flame.images.fromCache('background.png'));
  }

  @override
  void render(Canvas c) {
    sprite.render(c);
  }
}

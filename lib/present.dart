import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'my_game.dart';

class Present {
  static const speed = 40.0;

  final Vector2 size = Vector2(10, 8);
  final MyGame game;
  final int index;

  late Rect rect;
  late SpriteSheet sprites;
  bool shouldRemove = false;

  Present(this.game, this.index, Vector2 position) {
    sprites = SpriteSheet.fromColumnsAndRows(
        image: Flame.images.fromCache('present.png'), columns: 2, rows: 1);
    rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  void render(Canvas canvas) {
    var sprite = sprites.getSprite(0, index);
    sprite.render(
      canvas,
      position: Vector2(rect.left.roundToDouble(), rect.top.roundToDouble()),
      size: null,
    );
  }

  void update(double t) {
    rect = rect.translate(0, speed * t);
    if (rect.top > game.size.y) {
      shouldRemove = true;
    }
  }
}

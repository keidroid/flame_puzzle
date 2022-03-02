//import 'package:flame/extensions/vector2.dart';
//import 'package:flame/flame.dart';
//import 'package:flame/spritesheet.dart';
//import 'package:flame_puzzle/my_game.dart';

/* unused
class Explosion {
  static const SPRITE_SHEET_COLUMN = 4;
  static const SPRITE_SHEET_ROW = 4;

  final Vector2 size = Vector2.all(32);
  final MyGame game;

  SpriteSheet sprites;
  int animationIndex;
  double time;

  Explosion(this.game) {
    sprites = SpriteSheet.fromColumnsAndRows(
      image: Flame.images.fromCache('explosion.png'),
      columns: SPRITE_SHEET_COLUMN,
      rows: SPRITE_SHEET_ROW,
    );
  }

  void update(double t) {
    time += t;
    if (time > 1 / 20) {
      animationIndex++;
      if (animationIndex >= SPRITE_SHEET_COLUMN * SPRITE_SHEET_ROW) {
        animationIndex = 0;
      }
      time = 0.0;
    }
  }

  void render(Canvas canvas, double x, double y) {
    var sprite = sprites.getSprite(animationIndex ~/ SPRITE_SHEET_COLUMN,
        animationIndex % SPRITE_SHEET_COLUMN);
    sprite.renderPosition(canvas, Vector2(x - size.x * 0.5, y - size.y * 0.5));
  }
}
*/

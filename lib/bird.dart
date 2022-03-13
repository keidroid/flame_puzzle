import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import 'constants.dart';

class Bird extends SpriteComponent {
  Bird() {
    sprite = Sprite(Flame.images.fromCache(ImagePath.bird));
  }
}

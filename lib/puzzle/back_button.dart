import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';

import '../constants.dart';

class BackButton extends SpriteComponent with Tappable {
  final Function() _onTapCallback;

  BackButton(this._onTapCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = Sprite(Flame.images.fromCache(ImagePath.back));
    size = Vector2.all(24);
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

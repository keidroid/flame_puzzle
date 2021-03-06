import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import 'constants.dart';

enum BirdState { stay, random, good }

class Bird extends SpriteComponent {
  static const double defaultSize = 24;

  final Random _random;
  int _state = 0;
  int _stateChangeCount = 0;
  int _count = 0;

  BirdState birdState = BirdState.random;

  double _deltaTime = 0;

  Bird(this._random) {
    sprite = Sprite(Flame.images.fromCache(ImagePath.bird),
        srcPosition: Vector2(_count * defaultSize, _state * defaultSize),
        srcSize: Vector2.all(defaultSize));
    size = Vector2.all(defaultSize);
  }

  @override
  void update(double dt) {
    if (birdState == BirdState.stay) return;
    _deltaTime += dt;

    // moderately random
    if (_deltaTime > 0.5) {
      _deltaTime -= 0.5;

      if (birdState == BirdState.good) {
        _state = 3;
      } else {
        _stateChangeCount++;
        if (_stateChangeCount > 9) {
          _stateChangeCount = 0;
          _state = (_state + 1 + _random.nextInt(2)) % 3;
        }
      }
      _count = (_count + 1) % 2;
      sprite = Sprite(Flame.images.fromCache(ImagePath.bird),
          srcPosition: Vector2(_count * defaultSize, _state * defaultSize),
          srcSize: Vector2.all(defaultSize));
    }
  }
}

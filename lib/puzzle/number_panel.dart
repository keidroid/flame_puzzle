import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'direction.dart';
import 'panel_position.dart';

class NumberPanel extends PositionComponent with Tappable, Hoverable {
  static const int lastIndex = 15;
  static const int panelWidth = 4;
  static const double defaultSize = 28;
  static const double moveEffectDuration = 0.08;
  static const double tapEffectDuration = 0.08;
  static const double tappedScale = 0.95;
  static const double idleScale = 1.0;

  final int index;
  final Function(int) _onTapCallback;

  bool _isFixed = false;

  late Sprite sprite;

  MoveEffect? _moveEffect;
  ScaleEffect? _tapEffect;

  PanelPosition panelPosition = PanelPosition();

  Vector2 get targetPosition => Vector2(size.x * 0.5 + panelPosition.x * size.x,
      size.y * 0.5 + panelPosition.y * size.y);

  bool get isCorrect =>
      (panelPosition.x == index % panelWidth) &&
      (panelPosition.y == index ~/ panelWidth);

  NumberPanel(this.index, this._onTapCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = Sprite(Flame.images.fromCache(ImagePath.panel),
        srcPosition: Vector2(index % panelWidth * defaultSize,
            index ~/ panelWidth * defaultSize),
        srcSize: Vector2.all(defaultSize));
    size = Vector2.all(defaultSize);
    anchor = Anchor.center;

    panelPosition.x = index % panelWidth;
    panelPosition.y = index ~/ panelWidth;
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    if (index == lastIndex) {
      return;
    }
    sprite.render(canvas, size: size);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    _playTapEffect(false);

    if (_isFixed) return true;
    _onTapCallback(index);
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (_isFixed) return true;
    _playTapEffect(true);
    return true;
  }

  @override
  bool onTapCancel() {
    _playTapEffect(false);

    if (_isFixed) return true;
    _onTapCallback(index);
    return true;
  }

  @override
  bool onHoverEnter(PointerHoverInfo info) {
    if (_isFixed) return true;
    _playTapEffect(true);
    return true;
  }

  @override
  bool onHoverLeave(PointerHoverInfo info) {
    _playTapEffect(false);
    return true;
  }

  void updatePosition() {
    position = targetPosition;
  }

  void move(Direction direction) {
    switch (direction) {
      case Direction.up:
        panelPosition.y--;
        break;
      case Direction.down:
        panelPosition.y++;
        break;
      case Direction.left:
        panelPosition.x--;
        break;
      case Direction.right:
        panelPosition.x++;
    }
    _playMoveEffect();
  }

  void fix() {
    _isFixed = true;
  }

  void _playMoveEffect() {
    // set to end current animation
    if (_moveEffect != null) {
      _moveEffect?.controller.setToEnd();
      remove(_moveEffect!);
    }

    _moveEffect = MoveEffect.to(targetPosition,
        EffectController(duration: moveEffectDuration, curve: Curves.easeOut));
    add(_moveEffect!);
    _playTapEffect(false);
  }

  void _playTapEffect(bool tapped) {
    // set to end current animation
    if (_tapEffect != null) {
      _tapEffect?.controller.setToEnd();
      remove(_tapEffect!);
    }

    Vector2 targetScale = Vector2.all(tapped ? tappedScale : idleScale);
    _tapEffect = ScaleEffect.to(targetScale,
        EffectController(duration: tapEffectDuration, curve: Curves.easeOut));
    add(_tapEffect!);
  }
}

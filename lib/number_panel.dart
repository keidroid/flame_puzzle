import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class NumberPanel extends PositionComponent with Tappable, Hoverable {
  static const int lastIndex = 15;
  static const int panelWidth = 4;

  static const double defaultSize = 28;

  final int label;
  final Function(int) onTapCallback;

  bool isMovable = false;

  late Sprite sprite;

  MoveEffect? _moveEffect;
  ScaleEffect? _tapEffect;

  PanelPosition panelPosition = PanelPosition();

  NumberPanel(this.label, this.onTapCallback) {
    sprite = Sprite(Flame.images.fromCache('panel.png'));
    size = Vector2.all(defaultSize);

    panelPosition.x = label % panelWidth;
    panelPosition.y = label ~/ panelWidth;

    anchor = Anchor.center;
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    if (label == lastIndex) {
      return;
    }

    sprite.render(canvas, size: size);

    TextPaint textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 8.0,
        fontFamily: 'PressStart2P',
      ),
    );
    textPaint.render(canvas, "${label + 1}", Vector2(10, 10));
  }

  @override
  bool onTapUp(TapUpInfo info) {
    tapEffect(false);
    onTapCallback(label);
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    tapEffect(true);
    return true;
  }

  @override
  bool onTapCancel() {
    tapEffect(false);
    onTapCallback(label);
    return true;
  }

  void updatePosition() {
    position = Vector2(size.x * 0.5 + panelPosition.x * size.x,
        size.y * 0.5 + panelPosition.y * size.y);
  }

  void moveUp() {
    panelPosition.y--;
    moveAnimation();
  }

  void moveDown() {
    panelPosition.y++;
    moveAnimation();
  }

  void moveLeft() {
    panelPosition.x--;
    moveAnimation();
  }

  void moveRight() {
    panelPosition.x++;
    moveAnimation();
  }

  void moveAnimation() {
    // set to end current animation
    if (_moveEffect != null) {
      _moveEffect?.controller.setToEnd();
      remove(_moveEffect!);
    }

    Vector2 targetPosition = Vector2(size.x * 0.5 + panelPosition.x * size.x,
        size.y * 0.5 + panelPosition.y * size.y);
    _moveEffect = MoveEffect.to(targetPosition,
        EffectController(duration: 0.08, curve: Curves.easeOut));
    add(_moveEffect!);
  }

  void tapEffect(bool tapped) {
    // set to end current animation
    if (_tapEffect != null) {
      _tapEffect?.controller.setToEnd();
      remove(_tapEffect!);
    }

    Vector2 targetScale = tapped ? Vector2(0.95, 0.95) : Vector2(1.0, 1.0);
    _tapEffect = ScaleEffect.to(
        targetScale, EffectController(duration: 0.08, curve: Curves.easeOut));
    add(_tapEffect!);
  }

  bool isSamePosition(NumberPanel panel) {
    return panelPosition == panel.panelPosition;
  }

  bool checkCorrectPosition() {
    return (panelPosition.x == label % panelWidth) &&
        (panelPosition.y == label ~/ panelWidth);
  }

  @override
  bool onHoverEnter(PointerHoverInfo info) {
    tapEffect(true);
    return true;
  }

  @override
  bool onHoverLeave(PointerHoverInfo info) {
    tapEffect(false);
    return true;
  }
}

class PanelPosition {
  int x = 0;
  int y = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is PanelPosition) {
      return x == other.x && y == other.y;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}

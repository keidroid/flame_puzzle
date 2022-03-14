import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum GameKeyEvent {
  up,
  down,
  left,
  right,
  enter,
}

typedef StateChangeCallback = void Function(GameScene, bool);

class GameScene extends Component {
  bool isSound;
  StateChangeCallback stateChangeCallback;

  GameScene(this.isSound, this.stateChangeCallback);

  @mustCallSuper
  void onKeyEvent(GameKeyEvent gameKeyEvent) {}
}

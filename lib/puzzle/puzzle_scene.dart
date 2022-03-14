import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants.dart';
import '../game_scene.dart';
import 'direction.dart';
import 'number_panels.dart';
import 'timer_text.dart';

enum PuzzleSceneState { start, playing, clear }

class PuzzleScene extends GameScene {
  final Random _random;
  final int _shuffleCount;

  PuzzleSceneState _state = PuzzleSceneState.start;

  late NumberPanels _numberPanels;
  late TimerText _timerText;

  PuzzleScene(this._random, this._shuffleCount, bool isSound,
      StateChangeCallback stateChangeCallback)
      : super(isSound, stateChangeCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(SpriteComponent(sprite: await Sprite.load(ImagePath.background)));

    SpriteComponent bird =
        SpriteComponent(sprite: await Sprite.load(ImagePath.bird))
          ..position = Vector2(132, 96);
    add(bird);

    _numberPanels = NumberPanels(_random, _shuffleCount, movePanels)
      ..position = Vector2(8, 8);
    add(_numberPanels);

    _timerText = TimerText()..position = Vector2(12, 132);
    add(_timerText);

    if (isSound) {
      FlameAudio.bgm.play(AudioPath.bgm);
    }
  }

  @override
  void onKeyEvent(GameKeyEvent gameKeyEvent) {
    super.onKeyEvent(gameKeyEvent);

    switch (gameKeyEvent) {
      case GameKeyEvent.up:
        movePanel(Direction.up);
        break;
      case GameKeyEvent.down:
        movePanel(Direction.down);
        break;
      case GameKeyEvent.left:
        movePanel(Direction.left);
        break;
      case GameKeyEvent.right:
        movePanel(Direction.right);
        break;
      case GameKeyEvent.enter:
        finishPuzzle();
        break;
    }
  }

  void movePanel(Direction direction) {
    movePanels(direction, 1);
  }

  void movePanels(Direction direction, int count) {
    if (_state == PuzzleSceneState.start) {
      _timerText.start();
      _state = PuzzleSceneState.playing;
    }
    if (_state == PuzzleSceneState.playing) {
      _numberPanels.movePanels(direction, count);
      if (isSound) {
        FlameAudio.audioCache.play(AudioPath.panel);
      }
      checkGameClear();
    }
  }

  void checkGameClear() {
    if (_numberPanels.isAllCorrects) {
      if (isSound) {
        FlameAudio.bgm.stop();
        FlameAudio.play(AudioPath.clear);
      }
      _timerText.stop();
      _numberPanels.fixPanels();
      _state = PuzzleSceneState.clear;
    }
  }

  void finishPuzzle() {
    if (isSound) {
      FlameAudio.bgm.stop();
    }
    stateChangeCallback(this, isSound);
  }
}

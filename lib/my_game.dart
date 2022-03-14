import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'game_scene.dart';
import 'puzzle/puzzle_scene.dart';
import 'title/title_scene.dart';

class MyGame extends FlameGame
    with KeyboardEvents, HasTappables, HasHoverables {
  static const shuffleCount = 10;

  final Random _random = Random();

  late GameScene _currentScene;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await Flame.images.loadAll(ImagePath.all);

    FlameAudio.bgm.initialize();

    // do not create a player instance for each sound effect
    FlameAudio.audioCache = AudioCache(
        prefix: 'assets/audio/',
        fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
    await FlameAudio.audioCache.load(AudioPath.panel);

    _currentScene = TitleScene(true, stateChangeCallback);
    add(_currentScene);
  }

  void stateChangeCallback(GameScene current, bool isSound) {
    remove(current);

    if (current is TitleScene) {
      _currentScene =
          PuzzleScene(_random, shuffleCount, isSound, stateChangeCallback);
      add(_currentScene);
    } else if (current is PuzzleScene) {
      _currentScene = TitleScene(isSound, stateChangeCallback);
      add(_currentScene);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        _currentScene.onKeyEvent(GameKeyEvent.up);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        _currentScene.onKeyEvent(GameKeyEvent.down);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _currentScene.onKeyEvent(GameKeyEvent.left);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _currentScene.onKeyEvent(GameKeyEvent.right);
      } else if (keysPressed.contains(LogicalKeyboardKey.enter) ||
          keysPressed.contains(LogicalKeyboardKey.space)) {
        _currentScene.onKeyEvent(GameKeyEvent.enter);
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

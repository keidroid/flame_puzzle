import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_puzzle/constants.dart';
import 'package:flame_puzzle/scene/title_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'scene/puzzle_scene.dart';

@mustCallSuper
class MyGame extends FlameGame
    with KeyboardEvents, HasTappables, HasHoverables {
  late TitleScene _titleScene;
  late PuzzleScene _puzzleScene;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await Flame.images.loadAll(ImagePath.all);

    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load(AudioPath.panel);

    _titleScene = TitleScene(changeStateCallback);
    _puzzleScene = PuzzleScene(changeStateCallback);

    add(_titleScene);
  }

  void changeStateCallback(Scene current, Scene next) {
    if (current == Scene.title) {
      remove(_titleScene);
      add(_puzzleScene);
    } else if (current == Scene.game) {
      remove(_puzzleScene);
      add(_titleScene);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        _puzzleScene.panelUp();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        _puzzleScene.panelDown();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _puzzleScene.panelLeft();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _puzzleScene.panelRight();
      } else if (keysPressed.contains(LogicalKeyboardKey.enter) ||
          keysPressed.contains(LogicalKeyboardKey.space)) {}
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

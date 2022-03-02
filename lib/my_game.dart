import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_puzzle/number_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'background.dart';

@mustCallSuper
class MyGame extends FlameGame
    with KeyboardEvents, HasTappables, HasHoverables {
  static const int shuffleCount = 10;

  Random random = Random();

  double deltaTime = 0;

  late Background background;
  late List<NumberPanel> numberPanels = <NumberPanel>[];

  static const String music = 'GB-Action-B03-2.mp3';
  static const String soundCursor = 'cursor.wav';
  static const String soundClear = 'GB-General-C06-2.mp3';

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll(<String>[
      'background.png',
      'panel.png',
    ]);

    background = Background();
    add(background);

    for (var i = 0; i < 16; i++) {
      numberPanels.add(NumberPanel(i, onTapPanel));
      add(numberPanels[i]);
    }

    shufflePanels();

    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load(soundCursor);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    return super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    return super.render(canvas);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        panelUp();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        panelDown();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        panelLeft();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        panelRight();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void panelUp({int diff = 1}) {
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveDown();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveUp();
    }
    FlameAudio.play(soundCursor);
    checkGameClear();
  }

  void panelDown({int diff = 1}) {
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveUp();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveDown();
    }
    FlameAudio.play(soundCursor);
    checkGameClear();
  }

  void panelLeft({int diff = 1}) {
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveRight();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveLeft();
    }
    FlameAudio.play(soundCursor);
    checkGameClear();
  }

  void panelRight({int diff = 1}) {
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveLeft();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveRight();
    }
    FlameAudio.play(soundCursor);
    checkGameClear();
  }

  void checkGameClear() {
    if (numberPanels.every((element) => element.checkCorrectPosition())) {
      FlameAudio.bgm.stop();
      FlameAudio.play(soundClear);
    }
  }

  // Tap

  var start = false;

  void onTapPanel(int label) {
    if (!start) {
      FlameAudio.bgm.play(music);
      start = true;
    }
    PanelPosition space = numberPanels.last.panelPosition;
    PanelPosition tapped = numberPanels
        .firstWhere((element) => element.label == label)
        .panelPosition;

    if (space.x == tapped.x) {
      if (space.y < tapped.y) {
        panelUp(diff: tapped.y - space.y);
      } else if (space.y > tapped.y) {
        panelDown(diff: space.y - tapped.y);
      }
    } else if (space.y == tapped.y) {
      if (space.x < tapped.x) {
        panelLeft(diff: tapped.x - space.x);
      } else if (space.x > tapped.x) {
        panelRight(diff: space.x - tapped.x);
      }
    }
  }

  void shufflePanels() {
    // shuffle count must be even
    for (int i = 0; i < shuffleCount; i++) {
      int target1 = random.nextInt(NumberPanel.lastIndex);
      int target2 =
          (target1 + (1 + random.nextInt(NumberPanel.lastIndex - 1))) %
              NumberPanel.lastIndex;

      // shuffle should not be done on the same panel
      assert(target1 != target2);

      PanelPosition tmp = numberPanels[target1].panelPosition;
      numberPanels[target1].panelPosition = numberPanels[target2].panelPosition;
      numberPanels[target2].panelPosition = tmp;
    }
    for (var element in numberPanels) {
      element.updatePosition();
    }
  }
}

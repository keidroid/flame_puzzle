import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants.dart';
import '../game_scene.dart';
import 'direction.dart';
import 'number_panel.dart';
import 'panel_position.dart';
import 'timer_text.dart';

class PuzzleScene extends GameScene {
  static const int shuffleCount = 10;

  Random random = Random();

  late List<NumberPanel> numberPanels = <NumberPanel>[];
  late TimerText _timerText;

  PuzzleScene(bool isSound, StateChangeCallback stateChangeCallback)
      : super(isSound, stateChangeCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(SpriteComponent(sprite: await Sprite.load(ImagePath.background)));

    SpriteComponent bird =
        SpriteComponent(sprite: await Sprite.load(ImagePath.bird));
    bird.position = Vector2(132, 96);

    add(bird);

    for (var i = 0; i < 16; i++) {
      numberPanels.add(NumberPanel(i, onTapPanel));
      add(numberPanels[i]);
    }

    _timerText = TimerText()..position = Vector2(12, 132);

    add(_timerText);

    shufflePanels();

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
        if (isSound) {
          FlameAudio.bgm.stop();
        }
        stateChangeCallback(this, isSound);
        break;
    }
  }

  void movePanel(Direction direction, {int diff = 1}) {
    _timerText.start();
    for (int i = 0; i < diff; i++) {
      numberPanels.last.move(direction.reverse);
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .move(direction);
    }
    if (isSound) {
      FlameAudio.audioCache.play(AudioPath.panel);
    }
    checkGameClear();
  }

  void checkGameClear() {
    if (numberPanels.every((element) => element.checkCorrectPosition())) {
      if (isSound) {
        FlameAudio.bgm.stop();
        FlameAudio.play(AudioPath.clear);
      }
      _timerText.stop();
    }
  }

  void onTapPanel(int label) {
    PanelPosition space = numberPanels.last.panelPosition;
    PanelPosition tapped = numberPanels
        .firstWhere((element) => element.label == label)
        .panelPosition;

    if (space.x == tapped.x) {
      if (space.y < tapped.y) {
        movePanel(Direction.up, diff: tapped.y - space.y);
      } else if (space.y > tapped.y) {
        movePanel(Direction.down, diff: space.y - tapped.y);
      }
    } else if (space.y == tapped.y) {
      if (space.x < tapped.x) {
        movePanel(Direction.left, diff: tapped.x - space.x);
      } else if (space.x > tapped.x) {
        movePanel(Direction.right, diff: space.x - tapped.x);
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

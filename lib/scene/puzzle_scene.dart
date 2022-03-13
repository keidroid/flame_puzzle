import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants.dart';
import '../number_panel.dart';
import '../timer_text.dart';

class PuzzleScene extends Component {
  static const int shuffleCount = 0;

  StateChangeCallback changeSceneCallback;

  Random random = Random();

  late List<NumberPanel> numberPanels = <NumberPanel>[];
  late TimerText _timerText;

  PuzzleScene(this.changeSceneCallback);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(SpriteComponent(sprite: await Sprite.load(ImagePath.background)));

    SpriteComponent bird =
        SpriteComponent(sprite: await Sprite.load(ImagePath.bird));
    bird.position = Vector2(128, 108);

    add(bird);

    for (var i = 0; i < 16; i++) {
      numberPanels.add(NumberPanel(i, onTapPanel));
      add(numberPanels[i]);
    }

    _timerText = TimerText()..position = Vector2(12, 128);

    add(_timerText);

    shufflePanels();

    FlameAudio.bgm.play(AudioPath.bgm);
  }

  void panelUp({int diff = 1}) {
    _timerText.start();
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveDown();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveUp();
    }
    FlameAudio.audioCache.play(AudioPath.panel);
    checkGameClear();
  }

  void panelDown({int diff = 1}) {
    _timerText.start();
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveUp();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveDown();
    }
    FlameAudio.audioCache.play(AudioPath.panel);
    checkGameClear();
  }

  void panelLeft({int diff = 1}) {
    _timerText.start();
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveRight();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveLeft();
    }
    FlameAudio.audioCache.play(AudioPath.panel);
    checkGameClear();
  }

  void panelRight({int diff = 1}) {
    _timerText.start();
    for (int i = 0; i < diff; i++) {
      numberPanels.last.moveLeft();
      numberPanels
          .firstWhere((element) => element.isSamePosition(numberPanels.last))
          .moveRight();
    }
    FlameAudio.audioCache.play(AudioPath.panel);
    checkGameClear();
  }

  void checkGameClear() {
    if (numberPanels.every((element) => element.checkCorrectPosition())) {
      FlameAudio.bgm.stop();
      FlameAudio.play(AudioPath.clear);
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

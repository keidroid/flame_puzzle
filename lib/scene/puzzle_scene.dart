import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants.dart';
import '../direction.dart';
import '../number_panel.dart';
import '../timer_text.dart';

class PuzzleScene extends Component {
  static const int shuffleCount = 10;

  StateChangeCallback changeSceneCallback;

  Random random = Random();

  late List<NumberPanel> numberPanels = <NumberPanel>[];
  late TimerText _timerText;

  bool isMute = false;

  PuzzleScene(this.changeSceneCallback);

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

    if (!isMute) {
      FlameAudio.bgm.play(AudioPath.bgm);
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
    if (!isMute) {
      FlameAudio.audioCache.play(AudioPath.panel);
    }
    checkGameClear();
  }

  void checkGameClear() {
    if (numberPanels.every((element) => element.checkCorrectPosition())) {
      if (!isMute) {
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

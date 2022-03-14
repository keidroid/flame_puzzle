import 'dart:math';

import 'package:flame/components.dart';

import 'direction.dart';
import 'number_panel.dart';
import 'panel_position.dart';

class NumberPanels extends PositionComponent {
  final Random _random;
  final int _shuffleCount;
  final Function(Direction, int) _onMovePanels;

  final List<NumberPanel> _panels = <NumberPanel>[];

  bool get isAllCorrects => _panels.every((element) => element.isCorrect);

  NumberPanels(this._random, this._shuffleCount, this._onMovePanels);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    for (var i = 0; i < NumberPanel.lastIndex + 1; i++) {
      _panels.add(NumberPanel(i, onTapPanel));
      add(_panels[i]);
    }
    shufflePanels(_shuffleCount);
  }

  void onTapPanel(int index) {
    PanelPosition space = _panels.last.panelPosition;
    PanelPosition tapped =
        _panels.firstWhere((element) => element.index == index).panelPosition;

    if (space.x == tapped.x) {
      if (space.y < tapped.y) {
        _onMovePanels(Direction.up, tapped.y - space.y);
      } else if (space.y > tapped.y) {
        _onMovePanels(Direction.down, space.y - tapped.y);
      }
    } else if (space.y == tapped.y) {
      if (space.x < tapped.x) {
        _onMovePanels(Direction.left, tapped.x - space.x);
      } else if (space.x > tapped.x) {
        _onMovePanels(Direction.right, space.x - tapped.x);
      }
    }
  }

  void shufflePanels(int shuffleCount) {
    // shuffle count must be even
    for (int i = 0; i < shuffleCount; i++) {
      int target1 = _random.nextInt(NumberPanel.lastIndex);
      int target2 =
          (target1 + (1 + _random.nextInt(NumberPanel.lastIndex - 1))) %
              NumberPanel.lastIndex;

      // shuffle should not be done on the same panel
      assert(target1 != target2);

      PanelPosition tmp = _panels[target1].panelPosition;
      _panels[target1].panelPosition = _panels[target2].panelPosition;
      _panels[target2].panelPosition = tmp;
    }
    for (var element in _panels) {
      element.updatePosition();
    }
  }

  void movePanels(Direction direction, int count) {
    for (int i = 0; i < count; i++) {
      _panels.last.move(direction.reverse);
      _panels
          .firstWhere(
              (element) => element.panelPosition == _panels.last.panelPosition)
          .move(direction);
    }
  }

  void fixPanels() {
    for (var element in _panels) {
      element.fix();
    }
  }
}

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class TimerText extends PositionComponent {
  static const double maxSeconds = 3599.99;

  bool isPLaying = false;

  late TextPaint _textPaint;
  late TextPaint _textPaint2;

  double _totalSeconds = 0;

  TimerText() {
    _textPaint = TextPaint(style: TextConfig.textC3Style);
    _textPaint2 = TextPaint(style: TextConfig.textC1Style);
  }

  @override
  void update(double dt) {
    if (!isPLaying) {
      return;
    }
    _totalSeconds += dt;
    if (_totalSeconds > maxSeconds) {
      _totalSeconds = maxSeconds;
    }
  }

  @override
  void render(Canvas canvas) {
    // mm
    String minuteStr = (_totalSeconds ~/ 60).toString().padLeft(2, '0');
    // ss.xx
    String secondStr = (_totalSeconds % 60).toStringAsFixed(2).padLeft(5, '0');
    _textPaint2.render(canvas, "TIME $minuteStr:$secondStr", Vector2(0, 1));
    _textPaint.render(canvas, "TIME $minuteStr:$secondStr", Vector2(0, 0));
  }

  void stop() {
    isPLaying = false;
  }

  void start() {
    isPLaying = true;
  }
}

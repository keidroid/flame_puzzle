import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class TimerText extends PositionComponent {
  static const double maxSeconds = 3599.99;

  late TextPaint _textPaint;
  late TextPaint _textPaint2;

  bool _isPlaying = false;
  double _totalSeconds = 0;

  TimerText() {
    _textPaint = TextPaint(style: TextConfig.textC3Style);
    _textPaint2 = TextPaint(style: TextConfig.textC1Style);
  }

  @override
  void update(double dt) {
    if (!_isPlaying) {
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

    String text = "TIME $minuteStr:$secondStr";
    _textPaint2.render(canvas, text, Vector2(0, 1));
    _textPaint.render(canvas, text, Vector2(0, 0));
  }

  void start() {
    _isPlaying = true;
  }

  void stop() {
    _isPlaying = false;
  }
}

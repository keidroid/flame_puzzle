import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MaterialApp(
    home: Container(
      color: Colors.black,
      child: Expanded(
          child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              child: ClipRect(
                  child: SizedBox(
                      width: 160,
                      height: 144,
                      child: GameWidget(game: MyGame()))))),
    ),
  ));
}

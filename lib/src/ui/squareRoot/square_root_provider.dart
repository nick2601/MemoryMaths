import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  int? level;

  SquareRootProvider({
    required TickerProvider vsync,
    required int level,
    required BuildContext context,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.SQUARE_ROOT,
          context: context,
        ) {
    this.level = level;

    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    final audioPlayer = AudioPlayer(context);

    if (timerStatus != TimerStatus.pause) {
      if (int.parse(answer) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer(); // Uses standardized method from base class

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        notifyListeners();
      } else {
        audioPlayer.playWrongSound();
        wrongAnswer(); // Uses standardized method from base class
      }
    }
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class GuessSignProvider extends GameProvider<Sign> {
  int? level;

  GuessSignProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.GUESS_SIGN,
            context: context) {
    this.level = level;
    startGame(level: this.level == null ? null : level);
  }

  void checkResult(
    String answer,
  ) async {
    final audioPlayer = AudioPlayer(context);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if (result == currentState.sign) {
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
  }
}

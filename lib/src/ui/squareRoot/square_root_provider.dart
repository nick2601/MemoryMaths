import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  int? level;
  BuildContext? context;

  SquareRootProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.SQUARE_ROOT,
            c: context) {
    this.level = level;
    this.context = context;

    startGame(level: this.level == null ? null : level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      rightAnswer();
      audioPlayer.playRightSound();
      rightCount = rightCount + 1;
      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level == null ? null : level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }

      notifyListeners();
    } else {
      wrongCount = wrongCount + 1;
      audioPlayer.playWrongSound();
      wrongAnswer();
    }
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/find_missing_model.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class FindMissingProvider extends GameProvider<FindMissingQuizModel> {
  int? level;
  BuildContext? context;

  FindMissingProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.FIND_MISSING,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  void checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);
    //
    // if (timerStatus != TimerStatus.pause) {
    //   result = answer;
    //   notifyListeners();
    //   if (result == currentState.answer) {
    //     audioPlayer.playRightSound();
    //     await Future.delayed(Duration(milliseconds: 300));
    //     loadNewDataIfRequired(level: level==null?null:level);
    //     if (timerStatus != TimerStatus.pause) {
    //       restartTimer();
    //     }
    //     notifyListeners();
    //   } else {
    //     audioPlayer.playWrongSound();
    //     wrongAnswer();
    //   }
    // }

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if ((result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
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
    }
  }
}

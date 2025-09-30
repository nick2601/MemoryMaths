import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import '../../data/models/complex_model.dart';

import '../soundPlayer/audio_file.dart';

class ComplexCalculationProvider extends GameProvider<ComplexModel> {
  int? level;
  BuildContext? context;

  ComplexCalculationProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  void checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();

      if ((result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();

        rightCount = rightCount + 1;
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }

      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level == null ? null : level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }

      notifyListeners();

      // if (result == currentState.finalAnswer) {
      //   audioPlayer.playRightSound();
      //   await Future.delayed(Duration(milliseconds: 300));
      //   loadNewDataIfRequired(level: level==null?null:level);
      //   if (timerStatus != TimerStatus.pause) {
      //     restartTimer();
      //   }
      //   notifyListeners();
      // } else {
      //   audioPlayer.playWrongSound();
      //   wrongAnswer();
      // }
    }
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../../data/models/quiz_model.dart';
import '../soundPlayer/audio_file.dart';

class DualGameProvider extends GameProvider<QuizModel> {
  int? level;
  BuildContext? context;

  DualGameProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.DUAL_GAME,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  void checkResult2(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isSecondClick) {
        isSecondClick = true;
      }
      result = answer;
      notifyListeners();
      print(
          "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      if (result == currentState.answer) {
        score2++;
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playWrongSound();
        wrongDualAnswer(false);
      }
    }
  }

  void checkResult1(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isFirstClick) {
        isFirstClick = true;
      }
      result = answer;
      notifyListeners();

      print(
          "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      if (result == currentState.answer) {
        score1++;
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playWrongSound();
        wrongDualAnswer(true);
      }
    }
  }
}

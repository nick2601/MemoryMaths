import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MentalArithmeticProvider extends GameProvider<MentalArithmetic> {
  late String result;
  BuildContext? context;

  int? level;
  MentalArithmeticProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);
    if (timerStatus != TimerStatus.pause &&
        result.length < currentState.answer.toString().length &&
        ((result.length == 0 && answer == "-") || (answer != "-"))) {
      result = result + answer;
      notifyListeners();
      if (result != "-" && int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();

        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        if (currentScore > 0) {
          wrongAnswer();
        }
      }
    }
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}

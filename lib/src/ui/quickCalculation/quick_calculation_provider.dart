import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/quick_calculation.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import '../soundPlayer/audio_file.dart';

class QuickCalculationProvider extends GameProvider<QuickCalculation> {
  late QuickCalculation nextCurrentState;
  QuickCalculation? previousCurrentState;
  int? level;
  BuildContext? context;

  QuickCalculationProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.QUICK_CALCULATION,
            c: context) {
    this.level = level;
    this.context = context;

    startGame(level: this.level == null ? null : level);
    nextCurrentState = list[index + 1];
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);
    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        previousCurrentState = list[index - 1];
        nextCurrentState = list[index + 1];
        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
        addCoin();
        // if (/*time >= 0.0125*/ timerStatus != TimerStatus.pause) increase();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        if (currentScore > 0) {
          wrongAnswer();
        }

        minusCoin();
      }
    }
  }

  clearResult() {
    result = "";
    notifyListeners();
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class ConcentrationProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  bool isTimer = true;
  Function? nextQuiz;

  ConcentrationProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context,
      required Function nextQuiz,
      bool? isTimer})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.CONCENTRATION,
            isTimer: isTimer,
            c: context) {
    this.level = level;
    this.isTimer = (isTimer == null) ? true : isTimer;
    this.context = context;
    this.nextQuiz = nextQuiz;

    print("start===true");

    startGame(level: this.level == null ? null : level, isTimer: isTimer);
  }

  Future<void> checkResult(Pair mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    // if (timerStatus != TimerStatus.pause) {
    if (!currentState.list[index].isActive) {
      currentState.list[index].isActive = true;
      notifyListeners();
      if (first != -1) {
        if (currentState.list[first].uid == currentState.list[index].uid) {
          audioPlayer.playRightSound();

          currentState.list[first].isVisible = false;
          currentState.list[index].isVisible = false;
          currentState.availableItem = currentState.availableItem - 2;
          first = -1;

          notifyListeners();
          if (currentState.availableItem == 0) {
            print("oldScore===$oldScore====$currentScore");

            print("oldScore===$oldScore====$currentScore");

            await Future.delayed(Duration(milliseconds: 300));
            loadNewDataIfRequired(level: level == null ? 1 : level);
            currentScore =
                currentScore + KeyUtil.getScoreUtil(gameCategoryType);

            addCoin();
            if (nextQuiz != null) {
              nextQuiz!();
            }
            notifyListeners();
          }
        } else {
          audioPlayer.playWrongSound();
          currentState.list[first].isActive = false;
          currentState.list[index].isActive = false;
          first = -1;
          notifyListeners();
        }
      } else {
        first = index;
      }
    } else {
      first = -1;
      currentState.list[index].isActive = false;
      notifyListeners();
    }
  }
}

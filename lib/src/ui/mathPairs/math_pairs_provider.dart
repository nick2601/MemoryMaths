import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MathPairsProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;

  MathPairsProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MATH_PAIRS,
            context: context) {
    this.level = level;

    startGame(level: this.level == null ? null : level);
  }

  Future<void> checkResult(Pair mathPair, int index) async {
    final audioPlayer = AudioPlayer(context);

    if (timerStatus != TimerStatus.pause) {
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
            oldScore = currentScore;
            currentScore = currentScore + KeyUtil.mathematicalPairsScore;
            notifyListeners();
            if (currentState.availableItem == 0) {
              await Future.delayed(Duration(milliseconds: 300));
              loadNewDataIfRequired(level: level == null ? 1 : level);
              rightAnswer(); // Use standardized method from base class

              if (timerStatus != TimerStatus.pause) {
                restartTimer();
              }
              notifyListeners();
            }
          } else {
            audioPlayer.playWrongSound();
            minusCoin();
            wrongAnswer();
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
}

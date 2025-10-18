import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MagicTriangleProvider extends GameProvider<MagicTriangle> {
  int selectedTriangleIndex = 0;
  int? level;

  MagicTriangleProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
            context: context) {
    this.level = level;

    startGame(level: level);
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    if (timerStatus != TimerStatus.pause) {
      if (input.value.isEmpty) {
        for (int i = 0; i < currentState.listTriangle.length; i++) {
          currentState.listTriangle[i].isActive = false;
        }
        selectedTriangleIndex = index;
        currentState.listTriangle[index].isActive = true;
        notifyListeners();
      } else {
        int listGridIndex = currentState.listGrid.indexWhere(
            (val) => val.value == input.value && val.isVisible == false);
        currentState.listTriangle[index].isActive = false;
        currentState.listTriangle[index].value = "";
        currentState.availableDigit = currentState.availableDigit + 1;
        currentState.listGrid[listGridIndex].isVisible = true;
        notifyListeners();
      }
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    final audioPlayer = AudioPlayer(context);

    if (timerStatus != TimerStatus.pause) {
      int activeTriangleIndex =
          currentState.listTriangle.indexWhere((val) => val.isActive == true);
      if (currentState.listTriangle[activeTriangleIndex].value.isNotEmpty) {
        return;
      }
      currentState.listTriangle[selectedTriangleIndex].value = digit.value;
      currentState.listGrid[index].isVisible = false;
      currentState.availableDigit = currentState.availableDigit - 1;

      if (currentState.availableDigit == 0) {
        if (currentState.checkTotal()) {
          audioPlayer.playRightSound();
          await Future.delayed(Duration(milliseconds: 300));
          loadNewDataIfRequired(level: level == null ? null : level);
          selectedTriangleIndex = 0;
          currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

          addCoin();

          // Add level progression every 5 correct answers
          int newLevel = (rightCount ~/ 5) + (level ?? 1);
          if (newLevel != levelNo) {
            levelNo = newLevel;
            print("Magic Triangle Level progression! New level: $levelNo");
          }

          if (timerStatus != TimerStatus.pause) {
            restartTimer();
          }
          notifyListeners();
        } else {
          audioPlayer.playWrongSound();
        }
      }
      notifyListeners();
    }
  }
}

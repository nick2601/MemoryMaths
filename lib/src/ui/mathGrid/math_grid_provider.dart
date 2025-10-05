import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/math_grid.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

/// Provider for managing the state and logic of the Math Grid game.
/// Handles cell selection, answer checking, score updates, and game progression.
class MathGridProvider extends GameProvider<MathGrid> {
  int answerIndex = 0;
  int? level;

  /// Creates a MathGridProvider for the specified level and context.
  MathGridProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MATH_GRID,
            context: context) {
    this.level = level;
    startGame(level: this.level == null ? 1 : level);
  }

  /// Checks the result when a grid cell is tapped.
  /// Toggles the cell's active state and checks for correct answer.
  void checkResult(int index, MathGridCellModel gridModel) {
    if (timerStatus != TimerStatus.pause) {
      if (gridModel.isActive) {
        gridModel.isActive = false;
        notifyListeners();
      } else {
        gridModel.isActive = true;
        notifyListeners();
      }
      checkForCorrectAnswer();
    }
  }

  /// Checks if the selected cells match the current answer.
  /// Updates cell states, score, and loads new data if required.
  Future<void> checkForCorrectAnswer() async {
    AudioPlayer audioPlayer = new AudioPlayer(context);
    int total = 0;
    var listOfIndex = currentState.listForSquare
        .where((result) => result.isActive == true)
        .toList();

    for (int i = 0; i < listOfIndex.length; i++) {
      total = total + listOfIndex[i].value;
    }

    if (currentState.currentAnswer == total) {
      for (int i = 0; i < listOfIndex.length; i++) {
        listOfIndex[i].isActive = false;
        listOfIndex[i].isRemoved = true;
      }
      answerIndex = answerIndex + 1;
      if (currentState.listForSquare
          .where((element) => !element.isRemoved)
          .isEmpty) {
        audioPlayer.playRightSound();
        rightAnswer(); // Use standardized method from base class

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? 1 : level);
        answerIndex = 0;
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playRightSound();
        currentState.currentAnswer = currentState.getNewAnswer();
      }
    }
  }

  /// Clears the provider state and notifies listeners.
  clear() {
    notifyListeners();
  }
}

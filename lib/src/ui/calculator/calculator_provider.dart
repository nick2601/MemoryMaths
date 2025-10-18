import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/soundPlayer/audio_file.dart';

/// Provider for managing the state and logic of the Calculator game.
/// Handles user input, answer checking, score updates, and game progression.
class CalculatorProvider extends GameProvider<Calculator> {
  /// The current game level.
  int? level;

  /// Creates a CalculatorProvider for the specified level and context.
  CalculatorProvider({
    required TickerProvider vsync,
    required int level,
    required BuildContext context,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.CALCULATOR,
          context: context,
        ) {
    this.level = level;
    result = ""; // initialize user input buffer
    startGame(level: this.level ?? level);
  }

  /// Indicates if a button is currently being clicked.
  bool isClick = false;

  /// Checks the result when a number button is pressed.
  /// Updates the result, checks for correct answer, and handles scoring.
  void checkResult(String answer) async {
    final audioPlayer = AudioPlayer(context);

    if (dialogType == DialogType.over) return; // game finished
    if (timerStatus == TimerStatus.pause) return; // paused

    final target = currentState.answer.toString();
    if (result.length >= target.length) return; // ignore extra input

    result += answer;
    notifyListeners();

    if (result == target) {
      audioPlayer.playRightSound();
      rightAnswer(); // Uses standardized method from base class

      isClick = false;
      await Future.delayed(const Duration(milliseconds: 250));
      loadNewDataIfRequired(level: level);
      if (dialogType != DialogType.over && isTimer) {
        restartTimer();
      }
      result = ""; // reset for next question
      notifyListeners();
    } else if (result.length == target.length) {
      // full length but incorrect
      audioPlayer.playWrongSound();
      wrongAnswer(); // Uses standardized method from base class
      result = ""; // clear for new attempt / next question depending on rules
      notifyListeners();
    }
  }

  /// Handles backspace action to remove the last character from the result.
  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  /// Clears the current result input.
  void clearResult() {
    result = "";
    notifyListeners();
  }
}

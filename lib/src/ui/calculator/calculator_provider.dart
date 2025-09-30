import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/soundPlayer/audio_file.dart';

/// Provider for managing the state and logic of the Calculator game.
/// Handles user input, answer checking, score updates, and game progression.
class CalculatorProvider extends GameProvider<Calculator> {
  /// Stores the current user input as a string.
  late String result;

  /// The current build context.
  BuildContext? context;
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
          c: context,
        ) {
    this.level = level;
    this.context = context;
    startGame(level: this.level ?? level);
  }

  /// Indicates if a button is currently being clicked.
  bool isClick = false;

  /// Checks the result when a number button is pressed.
  /// Updates the result, checks for correct answer, and handles scoring.
  void checkResult(String answer) async {
    final audioPlayer = AudioPlayer(context!);

    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result += answer;
      notifyListeners();

      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        isClick = false;

        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        currentScore += KeyUtil.getScoreUtil(gameCategoryType);
        addCoin();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        minusCoin();
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
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

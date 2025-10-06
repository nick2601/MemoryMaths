import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MentalArithmeticProvider extends GameProvider<MentalArithmetic> {
  late String result;
  int? level;

  /// Check if animations should start (not during info dialog or hint dialog)
  bool get shouldStartAnimation =>
      dialogType != DialogType.info && dialogType != DialogType.hint;

  /// Indicates if the question animation is complete
  bool isAnimationCompleted = false;

  /// Public getter to access current game state
  MentalArithmetic get getCurrentState => currentState;

  /// Called by the view when the question animation finishes
  void onAnimationCompleted() {
    isAnimationCompleted = true;
    notifyListeners();
  }

  MentalArithmeticProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
            context: context) {
    this.level = level;
    result = ""; // Initialize result properly
    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    // If timer is paused (after viewing hint), resume it when user starts inputting answer
    if (timerStatus == TimerStatus.pause && dialogType == DialogType.non) {
      resumeTimer();
    }

    if (timerStatus != TimerStatus.pause &&
        result.length < currentState.answer.toString().length &&
        ((result.length == 0 && answer == "-") || (answer != "-"))) {
      result = result + answer;
      notifyListeners();
      if (result != "-" && int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer(); // Use standardized method from base class

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        wrongAnswer(); // Use standardized method from base class
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

  @override
  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    isAnimationCompleted = false; // Reset animation state for new question
    super.loadNewDataIfRequired(level: level, isScoreAdd: isScoreAdd);
  }

  /// Override showHintDialog to pause the timer when hint is opened
  @override
  void showHintDialog() {
    pauseTimer(); // Pause the timer when hint dialog opens
    dialogType = DialogType.hint;
    notifyListeners();
  }
}

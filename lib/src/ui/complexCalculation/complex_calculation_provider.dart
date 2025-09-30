import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import '../../data/models/complex_model.dart';
import '../soundPlayer/audio_file.dart';

/// Provider for managing the state and logic of the Complex Calculation game.
/// Handles answer checking, score updates, and game progression.
class ComplexCalculationProvider extends GameProvider<ComplexModel> {
  /// The current game level.
  int? level;
  /// The current build context.
  BuildContext? context;

  /// Creates a ComplexCalculationProvider for the specified level and context.
  ComplexCalculationProvider({
    required TickerProvider vsync,
    required int level,
    required BuildContext context,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
          c: context,
        ) {
    this.level = level;
    this.context = context;
    startGame(level: this.level ?? level);
  }

  /// Checks the result when an option is selected.
  /// Plays sound, updates score, and loads new data.
  void checkResult(String answer) async {
    final audioPlayer = AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();

      if (result == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount += 1;
      } else {
        wrongCount += 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }

      await Future.delayed(const Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      notifyListeners();
    }
  }
}

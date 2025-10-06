import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import '../soundPlayer/audio_file.dart';

/// Provider for managing the state and logic of the Concentration (Memory Pairs) game.
/// Handles card selection, pair matching, score updates, and game progression.
class ConcentrationProvider extends GameProvider<MathPairs> {
  /// Index of the first selected card (-1 if none selected).
  int first = -1;
  /// Index of the second selected card (-1 if none selected).
  int second = -1;
  /// The current game level.
  int? level;
  /// Whether the game uses a timer.
  bool isTimer = true;
  /// Callback function to execute when moving to next quiz.
  Function? nextQuiz;

  /// Gets the current list of math pairs for the view
  List<Pair> get mathPairsList => currentState.list;

  /// Creates a ConcentrationProvider for the specified level and context.
  ConcentrationProvider({
    required TickerProvider vsync,
    required int level,
    required BuildContext context,
    required Function nextQuiz,
    bool? isTimer,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.CONCENTRATION,
          context: context,
          isTimer: isTimer ?? false,
        ) {
    this.level = level;
    this.isTimer = isTimer ?? false;
    this.nextQuiz = nextQuiz;
    startGame(level: level, isTimer: this.isTimer);
  }

  /// Checks the result when a card is tapped.
  /// Handles pair matching logic, plays sounds, and updates game state.
  Future<void> checkResult(Pair mathPair, int index) async {
    final audioPlayer = AudioPlayer(context);

    if (!currentState.list[index].isActive) {
      _selectCard(index);

      if (first != -1 && first != index) {
        await _checkPairMatch(index, audioPlayer);
      } else if (first == -1) {
        first = index;
      }
    } else {
      _deselectCard(index);
    }
  }

  /// Selects a card and updates the UI.
  void _selectCard(int index) {
    currentState.list[index].isActive = true;
    notifyListeners();
  }

  /// Deselects a card and resets first selection.
  void _deselectCard(int index) {
    first = -1;
    currentState.list[index].isActive = false;
    notifyListeners();
  }

  /// Checks if two selected cards match and handles the result.
  Future<void> _checkPairMatch(int secondIndex, AudioPlayer audioPlayer) async {
    if (currentState.list[first].uid == currentState.list[secondIndex].uid) {
      await _handleCorrectMatch(secondIndex, audioPlayer);
    } else {
      _handleIncorrectMatch(secondIndex, audioPlayer);
    }
  }

  /// Handles a correct pair match.
  Future<void> _handleCorrectMatch(int secondIndex, AudioPlayer audioPlayer) async {
    audioPlayer.playRightSound();

    currentState.list[first].isVisible = false;
    currentState.list[secondIndex].isVisible = false;
    currentState.availableItem -= 2;
    first = -1;

    notifyListeners();

    if (currentState.availableItem == 0) {
      await _handleLevelComplete();
    }
  }

  /// Handles an incorrect pair match.
  void _handleIncorrectMatch(int secondIndex, AudioPlayer audioPlayer) {
    audioPlayer.playWrongSound();
    currentState.list[first].isActive = false;
    currentState.list[secondIndex].isActive = false;
    first = -1;
    notifyListeners();
  }

  /// Handles level completion and progression.
  Future<void> _handleLevelComplete() async {
    // Add score for completing the level (matching old code behavior)
    rightAnswer();

    await Future.delayed(const Duration(milliseconds: 300));

    // Load new data for next level
    loadNewDataIfRequired(level: level ?? 1);

    // Reset continue state through callback
    if (nextQuiz != null) {
      nextQuiz!();
    }

    notifyListeners();
  }
}

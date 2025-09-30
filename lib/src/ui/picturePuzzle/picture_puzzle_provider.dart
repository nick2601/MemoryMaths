import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// StateNotifier for Picture Puzzle that extends GameNotifier
class PicturePuzzleNotifier extends GameNotifier<PicturePuzzle> {
  final int level;
  String result = "";

  PicturePuzzleNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.PICTURE_PUZZLE, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Handle answer checking
  Future<void> checkGameResult(String answer) async {
    final timeState = ref.read(timeProvider(60));

    if (result.length < state.currentState!.answer.toString().length &&
        timeState.timerStatus != TimerStatus.pause) {
      final newResult = result + answer;
      result = newResult;

      // Update state with new result
      state = state.copyWith(result: newResult);

      if (int.parse(newResult) == state.currentState!.answer) {
        // Correct answer
        await Future.delayed(const Duration(milliseconds: 300));

        // Load new puzzle from repository
        final newPuzzleList = PicturePuzzleRepository.getPicturePuzzleDataList(level);
        if (newPuzzleList.isNotEmpty) {
          final newPuzzle = newPuzzleList.first;

          state = state.copyWith(
            currentState: newPuzzle,
            currentScore: state.currentScore + KeyUtil.getScoreUtil(GameCategoryType.PICTURE_PUZZLE),
          );

          result = "";

          // Use parent class methods for score and coins
          rightAnswer();

          // Restart timer
          ref.read(timeProvider(60).notifier).restartTimer();
        }
      } else if (newResult.length == state.currentState!.answer.toString().length) {
        // Wrong answer
        wrongAnswer();
        result = "";
      }
    }
  }

  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      state = state.copyWith(result: result);
    }
  }

  void clearResult() {
    result = "";
    state = state.copyWith(result: result);
  }
}

/// Provider family with just level parameter
final picturePuzzleProvider = StateNotifierProvider.family<
    PicturePuzzleNotifier, GameState<PicturePuzzle>, int>(
  (ref, level) => PicturePuzzleNotifier(level: level, ref: ref),
);
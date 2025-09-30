import 'dart:async';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/data/repository/numeric_memory_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// Notifier for Numeric Memory game
class NumericMemoryNotifier extends GameNotifier<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  final int level;
  final VoidCallback? nextQuiz;

  NumericMemoryNotifier({
    required this.level,
    required Ref ref,
    this.nextQuiz,
  }) : super(GameCategoryType.NUMERIC_MEMORY, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Check if the tapped answer is correct
  Future<void> checkResult(String mathPair, int index) async {
    if (state.currentState == null) return;

    if (mathPair == state.currentState!.answer) {
      // Correct answer - use parent class methods
      rightAnswer();
      first = -1;
    } else {
      // Wrong answer - use parent class methods
      wrongAnswer();
      first = -1;
    }

    // Short pause before next round
    await Future.delayed(const Duration(seconds: 1));
    _loadNewData();

    // Notify next quiz callback (optional)
    nextQuiz?.call();
  }

  /// Load new numeric memory data
  void _loadNewData() {
    final newDataList = NumericMemoryRepository.getNumericMemoryDataList(level);
    if (newDataList.isNotEmpty) {
      state = state.copyWith(
        list: newDataList,
        currentState: newDataList.first,
        index: 0,
      );

      // Restart timer
      ref.read(timeProvider(60).notifier).restartTimer();
    }
  }
}

/// Provider with level-based state
final numericMemoryProvider = StateNotifierProvider.family<
    NumericMemoryNotifier,
    GameState<NumericMemoryPair>,
    int>((ref, level) {
  return NumericMemoryNotifier(level: level, ref: ref);
});
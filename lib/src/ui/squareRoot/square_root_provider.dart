import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/data/repository/square_root_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// StateNotifier for Square Root game
class SquareRootNotifier extends GameNotifier<SquareRoot> {
  final int level;

  SquareRootNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.SQUARE_ROOT, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Check if the entered answer is correct
  Future<void> checkResult(String answer) async {
    final timeState = ref.read(timeProvider(60));

    if (timeState.timerStatus == TimerStatus.pause) return;

    if (int.tryParse(answer) == state.currentState!.answer) {
      // Correct answer - use parent class methods
      rightAnswer();

      await Future.delayed(const Duration(milliseconds: 300));
      _loadNewData();

      if (timeState.timerStatus != TimerStatus.pause) {
        ref.read(timeProvider(60).notifier).restartTimer();
      }
    } else {
      // Wrong answer - use parent class methods
      wrongAnswer();
    }
  }

  /// Load new square root data
  void _loadNewData() {
    final newDataList = SquareRootRepository.getSquareDataList(level);
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

/// Riverpod provider for Square Root
final squareRootProvider = StateNotifierProvider.family<
    SquareRootNotifier, GameState<SquareRoot>, int>(
  (ref, level) => SquareRootNotifier(level: level, ref: ref),
);
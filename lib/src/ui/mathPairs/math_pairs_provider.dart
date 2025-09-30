import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/data/repository/math_pairs_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// Riverpod Notifier for Math Pairs game
class MathPairsNotifier extends GameNotifier<MathPairs> {
  final int level;
  int first = -1;

  MathPairsNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.MATH_PAIRS, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Handle card tap & matching logic
  Future<void> checkResult(int index) async {
    final mathPairs = state.currentState;
    if (mathPairs == null) return;

    final timeState = ref.read(timeProvider(60));
    if (timeState.timerStatus == TimerStatus.pause) return;

    final currentList = [...mathPairs.list]; // copy of Pair list
    final tapped = currentList[index];

    if (!tapped.isActive && tapped.isVisible) {
      // flip card
      currentList[index] = tapped.copyWith(isActive: true);

      state = state.copyWith(
        currentState: mathPairs.copyWith(list: currentList),
      );

      if (first != -1) {
        if (currentList[first].uid == tapped.uid) {
          // ✅ Match found
          currentList[first] =
              currentList[first].copyWith(isVisible: false, isActive: false);
          currentList[index] =
              currentList[index].copyWith(isVisible: false, isActive: false);

          state = state.copyWith(
            currentState: mathPairs.copyWith(list: currentList),
          );

          // Use parent class methods for scoring and coins
          rightAnswer();
          first = -1;

          if (currentList.every((p) => !p.isVisible)) {
            // All pairs matched → Load new round
            await Future.delayed(const Duration(milliseconds: 300));
            _loadNewRound();
          }
        } else {
          // ❌ Not a match
          await Future.delayed(const Duration(milliseconds: 800));
          currentList[first] = currentList[first].copyWith(isActive: false);
          currentList[index] = currentList[index].copyWith(isActive: false);

          state = state.copyWith(
            currentState: mathPairs.copyWith(list: currentList),
          );

          // Use parent class methods for penalties
          wrongAnswer();
          first = -1;
        }
      } else {
        first = index;
      }
    } else {
      // tapped same card again → deactivate
      currentList[index] = tapped.copyWith(isActive: false);
      state = state.copyWith(
        currentState: mathPairs.copyWith(list: currentList),
      );
      first = -1;
    }
  }

  void _loadNewRound() {
    // Generate new pairs from repository
    final newMathPairsList = MathPairsRepository.getMathPairsDataList(level);
    if (newMathPairsList.isNotEmpty) {
      state = state.copyWith(
        list: newMathPairsList,
        currentState: newMathPairsList.first,
        index: 0,
      );
      first = -1;

      // Restart timer
      ref.read(timeProvider(60).notifier).restartTimer();
    }
  }
}

/// Riverpod provider
final mathPairsProvider = StateNotifierProvider.family<
    MathPairsNotifier, GameState<MathPairs>, int>(
  (ref, level) => MathPairsNotifier(level: level, ref: ref),
);
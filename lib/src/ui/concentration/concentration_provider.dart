import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

/// Notifier to manage the Concentration (memory pair matching) game
class ConcentrationNotifier extends StateNotifier<GameState<MathPairs>> {
  final int level;
  final bool isTimer;
  final void Function()? nextQuiz;

  int first = -1;

  ConcentrationNotifier({
    required this.level,
    this.isTimer = true,
    this.nextQuiz,
  }) : super(const GameState<MathPairs>()) {
    startGame(level: level, isTimer: isTimer);
  }

  /// Starts or restarts the game
  void startGame({required int level, bool isTimer = true}) {
    final list = _getList(level);
    state = state.copyWith(
      list: list,
      index: 0,
      currentScore: 0,
      rightCount: 0,
      wrongCount: 0,
      currentState: list.isNotEmpty ? list.first : null,
      dialogType: DialogType.non,
      isTimerRunning: isTimer,
    );
  }

  /// Generates a list of MathPairs based on the level
  List<MathPairs> _getList(int level) {
    // For now, generate dummy pairs
    final pairs = List.generate(
      level,
          (i) => Pair(uid: i, text: 'Pair $i'),
    );

    return [MathPairs(list: pairs)];
  }

  /// Handles matching logic when user taps a card
  Future<void> checkResult(int index) async {
    final current = state.currentState;
    if (current == null) return;

    final updatedPairs = [...current.list];

    if (!updatedPairs[index].isActive) {
      updatedPairs[index] =
          updatedPairs[index].copyWith(isActive: true); // flip card
      state = state.copyWith(currentState: current.copyWith(list: updatedPairs));

      if (first != -1) {
        if (updatedPairs[first].uid == updatedPairs[index].uid) {
          // ✅ match
          updatedPairs[first] =
              updatedPairs[first].copyWith(isVisible: false, isActive: false);
          updatedPairs[index] =
              updatedPairs[index].copyWith(isVisible: false, isActive: false);

          state = state.copyWith(
            currentState: current.copyWith(list: updatedPairs),
            currentScore: state.currentScore +
                KeyUtil.getScoreUtil(GameCategoryType.CONCENTRATION),
          );

          first = -1;

          if (updatedPairs.every((p) => !p.isVisible)) {
            // 🎉 All pairs matched
            await Future.delayed(const Duration(milliseconds: 300));
            startGame(level: level, isTimer: isTimer);
            addCoin();
            nextQuiz?.call();
          }
        } else {
          // ❌ not a match
          await Future.delayed(const Duration(milliseconds: 400));
          updatedPairs[first] =
              updatedPairs[first].copyWith(isActive: false);
          updatedPairs[index] =
              updatedPairs[index].copyWith(isActive: false);

          state = state.copyWith(
            currentState: current.copyWith(list: updatedPairs),
          );
          first = -1;
        }
      } else {
        first = index;
      }
    } else {
      // card already active → flip back
      updatedPairs[index] =
          updatedPairs[index].copyWith(isActive: false);
      state = state.copyWith(currentState: current.copyWith(list: updatedPairs));
      first = -1;
    }
  }

  /// Adds coins to the player's score
  void addCoin() {
    state = state.copyWith(
      currentScore: state.currentScore +
          KeyUtil.getScoreUtil(GameCategoryType.CONCENTRATION) * 5,
    );
  }
}

/// Riverpod provider for Concentration game
final concentrationProvider = StateNotifierProvider.family<
    ConcentrationNotifier,
    GameState<MathPairs>,
    int>(
      (ref, level) => ConcentrationNotifier(level: level),
);
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/find_missing_model.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';

import '../../data/repository/find_missing_repository.dart';

/// ✅ Riverpod Notifier for Find Missing Game
class FindMissingNotifier extends StateNotifier<GameState<FindMissingQuizModel>> {
  final int level;
  final Ref ref;

  FindMissingNotifier({required this.level, required this.ref})
      : super(const GameState<FindMissingQuizModel>()) {
    startGame(level: level);
  }

  /// Start or restart the game
  void startGame({required int level}) {
    final list = _generateQuestions(level);

    state = state.copyWith(
      list: list,
      index: 0,
      currentState: list.isNotEmpty ? list.first : null,
      currentScore: 0,
      rightCount: 0,
      wrongCount: 0,
      dialogType: DialogType.non,
      isTimerRunning: true,
    );
  }

  List<FindMissingQuizModel> _generateQuestions(int level) {
    // Pull the real data from repository instead of dummy data
    return FindMissingRepository.getFindMissingDataList(level);
  }

  /// Handle answer check
  Future<void> checkResult(String answer) async {
    final current = state.currentState;
    if (current == null || !state.isTimerRunning) return;


    if (answer == current.answer) {
      // ✅ Correct
      state = state.copyWith(
        currentScore: state.currentScore +
            KeyUtil.getScoreUtil(GameCategoryType.FIND_MISSING),
        rightCount: state.rightCount + 1,
      );
      addCoin(1);

      await Future.delayed(const Duration(milliseconds: 300));
      nextQuestion();
    } else {
      // ❌ Wrong
      state = state.copyWith(wrongCount: state.wrongCount + 1);
      wrongAnswer();
      minusCoin(1);
    }
  }

  /// Move to next question
  void nextQuestion() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
      );
    } else {
      startGame(level: level); // Restart after finishing
    }
  }

  /// ✅ Coin logic
  void addCoin(int value) {
    ref.read(dashboardProvider.notifier).addCoins(value);
  }

  void minusCoin(int value) {
    ref.read(dashboardProvider.notifier).spendCoins(value);
  }

  void wrongAnswer() {
    final minusScore =
    KeyUtil.getScoreMinusUtil(GameCategoryType.FIND_MISSING);
    final newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);
    state = state.copyWith(currentScore: newScore.toDouble());
  }
}

/// ✅ Riverpod provider
final findMissingProvider = StateNotifierProvider.family<
    FindMissingNotifier, GameState<FindMissingQuizModel>, int>(
      (ref, level) => FindMissingNotifier(level: level, ref: ref),
);
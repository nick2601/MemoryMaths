import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../../data/repository/correct_answer_repository.dart';
import '../dashboard/dashboard_provider.dart';

/// Notifier for Correct Answer game
class CorrectAnswerNotifier extends StateNotifier<GameState<CorrectAnswer>> {
  final Ref ref;
  final int level;

  CorrectAnswerNotifier({
    required this.ref,
    required this.level,
  }) : super(const GameState<CorrectAnswer>()) {
    startGame(level: level);
  }

  /// Start / restart game
  void startGame({required int level}) {
    // Load initial questions from repository
    final newList =
    CorrectAnswerRepository.getCorrectAnswerDataList(level); // ✅ repo call

    state = state.copyWith(
      list: newList,
      index: 0,
      currentState: newList.isNotEmpty ? newList.first : null,
      currentScore: 0,
      rightCount: 0,
      wrongCount: 0,
      dialogType: DialogType.non,
    );
  }

  /// User selected an answer
  Future<void> checkResult(String answer) async {
    final current = state.currentState;
    if (current == null) return;

    final isCorrect = int.tryParse(answer) == current.answer;

    if (isCorrect) {
      // ✅ Correct answer
      _handleRightAnswer();
    } else {
      // ❌ Wrong answer
      _handleWrongAnswer();
    }
  }

  /// Handle right answer flow
  Future<void> _handleRightAnswer() async {
    // Update score
    final newScore =
        state.currentScore + KeyUtil.getScoreUtil(GameCategoryType.CORRECT_ANSWER);

    state = state.copyWith(
      currentScore: newScore,
      rightCount: state.rightCount + 1,
    );

    // Add coins
    ref.read(dashboardProvider.notifier).addCoins(1);

    // Delay before next question
    await Future.delayed(const Duration(milliseconds: 300));
    _loadNext();
  }

  /// Handle wrong answer flow
  void _handleWrongAnswer() {
    // Deduct score
    final minusScore =
    KeyUtil.getScoreMinusUtil(GameCategoryType.CORRECT_ANSWER).abs();
    final newScore = (state.currentScore - minusScore).clamp(0, double.infinity);

    state = state.copyWith(
      currentScore: newScore.toDouble(),
      wrongCount: state.wrongCount + 1,
    );

    // Deduct coins
    ref.read(dashboardProvider.notifier).spendCoins(1);
  }

  /// Load next question or end game
  void _loadNext() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
      );
    } else {
      state = state.copyWith(dialogType: DialogType.over);
    }
  }
}

/// Riverpod provider
final correctAnswerProvider = StateNotifierProvider.family<
    CorrectAnswerNotifier, GameState<CorrectAnswer>, int>(
      (ref, level) => CorrectAnswerNotifier(ref: ref, level: level),
);
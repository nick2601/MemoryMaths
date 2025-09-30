import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/cube_root.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';

/// ✅ CubeRootNotifier: Riverpod version with coin integration
class CubeRootNotifier extends StateNotifier<GameState<CubeRoot>> {
  final int level;
  final Ref ref; // ✅ Access to other providers (like dashboard)

  CubeRootNotifier({required this.level, required this.ref})
      : super(const GameState<CubeRoot>()) {
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

  /// Dummy generator for cube root questions (replace with repo later)
  List<CubeRoot> _generateQuestions(int level) {
    return List.generate(level, (i) {
      final answer = i + 2;
      final question = (answer * answer * answer).toString(); // cube
      return CubeRoot(
        question: question,
        answer: answer,
        firstAns: (answer + 1).toString(),
        secondAns: (answer - 1).toString(),
        thirdAns: (answer + 2).toString(),
        fourthAns: answer.toString(),
      );
    });
  }

  /// Handle user answer
  Future<void> checkResult(String answer) async {
    final current = state.currentState;
    if (current == null || !state.isTimerRunning) return;

    final isCorrect = int.tryParse(answer) == current.answer;

    if (isCorrect) {
      // ✅ Correct Answer
      state = state.copyWith(
        currentScore: state.currentScore +
            KeyUtil.getScoreUtil(GameCategoryType.CUBE_ROOT),
        rightCount: state.rightCount + 1,
      );

      addCoin(1); // 🎉 Reward coin

      await Future.delayed(const Duration(milliseconds: 300));
      nextQuestion();
    } else {
      // ❌ Wrong Answer
      state = state.copyWith(wrongCount: state.wrongCount + 1);
      wrongAnswer();
      minusCoin(1); // 💀 Deduct coin
    }
  }

  /// Move to the next question
  void nextQuestion() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
      );
    } else {
      // End of round → restart
      startGame(level: level);
    }
  }

  /// ✅ Coin logic integrated with DashboardProvider
  void addCoin(int value) {
    ref.read(dashboardProvider.notifier).addCoins(value);
  }

  void minusCoin(int value) {
    ref.read(dashboardProvider.notifier).spendCoins(value);
  }

  void wrongAnswer() {
    final minusScore = KeyUtil.getScoreMinusUtil(GameCategoryType.CUBE_ROOT);
    final newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);
    state = state.copyWith(
      currentScore: newScore.toDouble(),
    );
  }
}

/// ✅ Riverpod provider with coin logic wired in
final cubeRootProvider = StateNotifierProvider.family<
    CubeRootNotifier, GameState<CubeRoot>, int>(
      (ref, level) => CubeRootNotifier(level: level, ref: ref),
);
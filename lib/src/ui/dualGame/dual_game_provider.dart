import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/quiz_model.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';

import '../../data/repository/dual_repository.dart';

/// ✅ DualGameNotifier: handles 2-player quiz logic
class DualGameNotifier extends StateNotifier<GameState<QuizModel>> {
  final int level;
  final Ref ref;

  int score1 = 0;
  int score2 = 0;
  bool isFirstClick = false;
  bool isSecondClick = false;
  String result = "";

  DualGameNotifier({required this.level, required this.ref})
      : super(const GameState<QuizModel>()) {
    startGame(level: level);
  }

  /// Start game with fresh quiz questions
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

    score1 = 0;
    score2 = 0;
    isFirstClick = false;
    isSecondClick = false;
  }

  /// Dummy quiz generator (replace with repo later)
  List<QuizModel> _generateQuestions(int level) {
    return DualRepository.getDualData(level);
  }

  /// ✅ Player 1 check result
  Future<void> checkResult1(String answer) async {
    if (!state.isTimerRunning || state.currentState == null) return;

    if (!isFirstClick) isFirstClick = true;
    result = answer;

    if (answer == state.currentState!.answer) {
      score1++;
      _onRightAnswer();
    } else {
      _onWrongAnswer(isPlayer1: true);
    }
  }

  /// ✅ Player 2 check result
  Future<void> checkResult2(String answer) async {
    if (!state.isTimerRunning || state.currentState == null) return;

    if (!isSecondClick) isSecondClick = true;
    result = answer;

    if (answer == state.currentState!.answer) {
      score2++;
      _onRightAnswer();
    } else {
      _onWrongAnswer(isPlayer1: false);
    }
  }

  /// Handle correct answers
  Future<void> _onRightAnswer() async {
    state = state.copyWith(
      currentScore:
      state.currentScore + KeyUtil.getScoreUtil(GameCategoryType.DUAL_GAME),
      rightCount: state.rightCount + 1,
    );

    addCoin(1); // 🎉 reward coin

    await Future.delayed(const Duration(milliseconds: 300));
    nextQuestion();
  }

  /// Handle wrong answers
  void _onWrongAnswer({required bool isPlayer1}) {
    state = state.copyWith(wrongCount: state.wrongCount + 1);
    wrongAnswer();
    minusCoin(1); // 💀 deduct coin
  }

  /// Next question
  void nextQuestion() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
      );
    } else {
      startGame(level: level); // restart round
    }
  }

  /// ✅ Coin logic via DashboardProvider
  void addCoin(int value) {
    ref.read(dashboardProvider.notifier).addCoins(value);
  }

  void minusCoin(int value) {
    ref.read(dashboardProvider.notifier).spendCoins(value);
  }

  void wrongAnswer() {
    final minusScore = KeyUtil.getScoreMinusUtil(GameCategoryType.DUAL_GAME);
    final newScore = (state.currentScore - minusScore).clamp(0, double.infinity);

    state = state.copyWith(currentScore: newScore.toDouble());
  }
}

/// ✅ Riverpod provider
final dualGameProvider = StateNotifierProvider.family<
    DualGameNotifier, GameState<QuizModel>, int>(
      (ref, level) => DualGameNotifier(level: level, ref: ref),
);
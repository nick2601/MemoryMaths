import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import '../../data/repository/sign_repository.dart';

class GuessSignNotifier extends StateNotifier<GameState<Sign>> {
  final int level;
  final Ref ref;

  GuessSignNotifier({
    required this.level,
    required this.ref,
  }) : super(const GameState<Sign>()) {
    startGame(level: level);
  }

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
      result: "",
    );
  }

  List<Sign> _generateQuestions(int level) {
    return SignRepository.getSignDataList(level);
  }

  Future<void> checkResult(String answer) async {
    final current = state.currentState;
    if (current == null || !state.isTimerRunning) return;

    final isCorrect = answer == current.sign;

    if (isCorrect) {
      state = state.copyWith(
        result: answer,
        currentScore: state.currentScore +
            KeyUtil.getScoreUtil(GameCategoryType.GUESS_SIGN),
        rightCount: state.rightCount + 1,
      );
      addCoin(1);
      await Future.delayed(const Duration(milliseconds: 300));
      nextQuestion();
    } else {
      state = state.copyWith(
        result: answer,
        wrongCount: state.wrongCount + 1,
      );
      wrongAnswer();
      minusCoin(1);
    }
  }

  void nextQuestion() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
        result: "",
      );
    } else {
      startGame(level: level);
    }
  }

  void addCoin(int value) {
    ref.read(dashboardProvider.notifier).addCoins(value);
  }

  void minusCoin(int value) {
    ref.read(dashboardProvider.notifier).spendCoins(value);
  }

  void wrongAnswer() {
    final minusScore = KeyUtil.getScoreMinusUtil(GameCategoryType.GUESS_SIGN);
    final newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);
    state = state.copyWith(currentScore: newScore.toDouble());
  }
}

final guessSignProvider = StateNotifierProvider.family<
    GuessSignNotifier, GameState<Sign>, int>(
      (ref, level) => GuessSignNotifier(level: level, ref: ref),
);

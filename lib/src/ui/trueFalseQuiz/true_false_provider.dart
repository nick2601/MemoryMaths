import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/true_false_model.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';

import '../../data/repository/true_false_repository.dart'; // 👈 import your coinProvider

/// Notifier for True/False game
class TrueFalseNotifier extends StateNotifier<GameState<TrueFalseModel>> {
  final int level;
  final Ref ref; // 👈 need ref to call other providers

  TrueFalseNotifier({required this.level, required this.ref})
      : super(const GameState<TrueFalseModel>()) {
    startGame(level: level);
  }

  /// Start or restart the game
  void startGame({required int level}) {
    final newList = _getList(level);

    state = state.copyWith(
      list: newList,
      index: 0,
      currentScore: 0,
      rightCount: 0,
      wrongCount: 0,
      dialogType: DialogType.non,
      currentState: newList.isNotEmpty ? newList.first : null,
      isTimerRunning: true,
    );
  }

  /// Get data (replace with repo call if needed)
  List<TrueFalseModel> _getList(int level) {
    return TrueFalseRepository.getTrueFalseDataList(level);
  }

  /// Handle user answer
  Future<void> checkResult(String answer) async {
    final current = state.currentState;
    if (current == null) return;

    if (answer == current.answer) {
      rightAnswer();
      addCoin(5); // reward (tweak the value as needed)

      await Future.delayed(const Duration(milliseconds: 300));
      _nextQuestion();
    } else {
      // ❌ Wrong
      wrongAnswer();
      minusCoin(2); // penalty (tweak the value as needed)
    }
  }

  /// Go to next question or end game
  void _nextQuestion() {
    if (state.index + 1 < state.list.length) {
      final nextIndex = state.index + 1;
      state = state.copyWith(
        index: nextIndex,
        currentState: state.list[nextIndex],
      );
    } else {
      state = state.copyWith(dialogType: DialogType.over);
    }
  }

  /// Correct answer handling
  void rightAnswer() {
    final newScore =
        state.currentScore + KeyUtil.getScoreUtil(GameCategoryType.TRUE_FALSE);

    state = state.copyWith(
      currentScore: newScore,
      rightCount: state.rightCount + 1,
    );
  }

  /// Wrong answer handling
  void wrongAnswer() {
    final minusScore =
    KeyUtil.getScoreMinusUtil(GameCategoryType.TRUE_FALSE).abs();

    final newScore = (state.currentScore - minusScore).clamp(0.0, double.infinity);

    state = state.copyWith(
      currentScore: newScore,
      wrongCount: state.wrongCount + 1,
    );
  }

  /// Add coins → update Hive via coinProvider
  void addCoin(int value) {
    ref.read(coinProvider.notifier).addCoins(value);
  }

  /// Deduct coins → update Hive via coinProvider
  void minusCoin(int value) {
    ref.read(coinProvider.notifier).minusCoins(value);
  }
}

/// Provider
final trueFalseProvider = StateNotifierProvider.family<
    TrueFalseNotifier, GameState<TrueFalseModel>, int>(
      (ref, level) => TrueFalseNotifier(level: level, ref: ref),
);
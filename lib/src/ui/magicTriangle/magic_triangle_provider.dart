import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import '../../data/repository/magic_triangle_repository.dart';

class MagicTriangleNotifier extends StateNotifier<GameState<MagicTriangle>> {
  final int level;
  final Ref ref;

  int selectedTriangleIndex = 0;

  MagicTriangleNotifier({
    required this.level,
    required this.ref,
  }) : super(const GameState<MagicTriangle>()) {
    startGame(level: level);
  }

  void startGame({required int level}) {
    final list = MagicTriangleRepository().getQuestions(level);

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

  /// User selects or deselects a triangle cell
  void inputTriangleSelection(int index, MagicTriangleInput input) {
    final current = state.currentState;
    if (current == null || !state.isTimerRunning) return;

    if (input.value == null || input.value!.toString().isEmpty) {
      // Activate the clicked triangle
      for (final t in current.listTriangle) {
        t.isActive = false;
      }
      selectedTriangleIndex = index;
      current.listTriangle[index].isActive = true;
    } else {
      // Remove value from triangle and put it back into grid
      final listGridIndex = current.listGrid.indexWhere(
            (val) => val.value == input.value && !val.isVisible,
      );
      current.listTriangle[index].isActive = false;
      current.listTriangle[index].value = null;
      if (current.availableDigit != null) {
        current.availableDigit = current.availableDigit! + 1;
      }
      if (listGridIndex != -1) {
        current.listGrid[listGridIndex].isVisible = true;
      }
    }

    state = state.copyWith(currentState: current);
  }

  /// User picks a number from grid
  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    final current = state.currentState;
    if (current == null || !state.isTimerRunning) return;

    final activeTriangleIndex =
    current.listTriangle.indexWhere((t) => t.isActive);

    if (activeTriangleIndex == -1 ||
        (current.listTriangle[activeTriangleIndex].value != null &&
            current.listTriangle[activeTriangleIndex].value!.toString().isNotEmpty)) {
      return;
    }

    // Place digit in triangle
    current.listTriangle[selectedTriangleIndex].value = digit.value;
    current.listGrid[index].isVisible = false;
    if (current.availableDigit != null) {
      current.availableDigit = current.availableDigit! - 1;
    }

    if (current.availableDigit == 0) {
      if (current.checkTotal()) {
        // ✅ Correct solution
        state = state.copyWith(
          currentScore: state.currentScore +
              KeyUtil.getScoreUtil(GameCategoryType.MAGIC_TRIANGLE),
          rightCount: state.rightCount + 1,
        );
        addCoin(1);

        await Future.delayed(const Duration(milliseconds: 300));
        nextQuestion();
      } else {
        wrongAnswer();
        minusCoin(1);
      }
    }

    state = state.copyWith(currentState: current);
  }

  /// Move to next question or restart
  void nextQuestion() {
    if (state.index + 1 < (state.list?.length ?? 0)) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
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
    final minusScore =
    KeyUtil.getScoreMinusUtil(GameCategoryType.MAGIC_TRIANGLE);
    final newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);
    state = state.copyWith(currentScore: newScore.toDouble());
  }
}

/// Riverpod provider
final magicTriangleProvider = StateNotifierProvider.family<
    MagicTriangleNotifier, GameState<MagicTriangle>, int>(
      (ref, level) => MagicTriangleNotifier(level: level, ref: ref),
);

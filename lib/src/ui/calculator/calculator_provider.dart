import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/calculator.dart';

import '../app/game_provider.dart';

class CalculatorNotifier extends GameNotifier<Calculator> {
  final int level;

  String result = "";
  bool isClick = false;

  CalculatorNotifier({
    required this.level,
    required Ref ref,
  }) : super(GameCategoryType.CALCULATOR, ref) {
    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    if (!state.isTimerRunning || state.currentState == null) return;

    if (result.length < state.currentState!.answer.toString().length) {
      result += answer;
      state = state.copyWith();
    }

    if (int.tryParse(result) == state.currentState!.answer) {
      isClick = false;
      await Future.delayed(const Duration(milliseconds: 300));
      next();
      rightAnswer();
      clearResult();
      return;
    }

    if (result.length == state.currentState!.answer.toString().length) {
      wrongAnswer();
      clearResult();
    }
  }

  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      state = state.copyWith();
    }
  }

  void clearResult() {
    result = "";
    state = state.copyWith();
  }
}

final calculatorProvider = StateNotifierProvider.family<
    CalculatorNotifier, GameState<Calculator>, int>(
      (ref, level) {
    return CalculatorNotifier(
      level: level,
      ref: ref,
    );
  },
);

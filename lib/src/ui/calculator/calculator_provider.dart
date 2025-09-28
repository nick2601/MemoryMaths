import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:tuple/tuple.dart';

import '../app/game_provider.dart'; // <- your generic GameNotifier/GameState

/// --- CALCULATOR NOTIFIER --- ///
class CalculatorNotifier extends GameNotifier<Calculator> {
  final BuildContext context;
  final int level;

  String result = "";
  bool isClick = false;

  CalculatorNotifier({
    required this.context,
    required this.level,
  }) : super(GameCategoryType.CALCULATOR) {
    startGame(level: level);
  }

  /// Handles digit/answer input
  Future<void> checkResult(String answer) async {
    if (!state.isTimerRunning || state.currentState == null) return;


    // Append digit
    if (result.length < state.currentState!.answer.toString().length) {
      result += answer;
      state = state.copyWith(); // trigger UI update
    }

    // ✅ Correct answer
    if (int.tryParse(result) == state.currentState!.answer) {
      isClick = false;

      await Future.delayed(const Duration(milliseconds: 300));
      next(); // go to next question

      rightAnswer(); // adds score
      clearResult();
      return;
    }

    if (result.length == state.currentState!.answer.toString().length) {
      wrongAnswer(); // penalty
      clearResult();
    }
  }

  /// Remove last digit
  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      state = state.copyWith(); // notify UI
    }
  }

  /// Clears current input
  void clearResult() {
    result = "";
    state = state.copyWith(); // notify UI
  }
}

/// --- PROVIDER --- ///
final calculatorProvider = StateNotifierProvider.family<
    CalculatorNotifier, GameState<Calculator>, Tuple2<BuildContext, int>>(
      (ref, params) {
    return CalculatorNotifier(
      context: params.item1,
      level: params.item2,
    );
  },
);
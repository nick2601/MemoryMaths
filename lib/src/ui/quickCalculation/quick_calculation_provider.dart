import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/quick_calculation.dart';
import 'package:mathsgames/src/data/repository/quick_calculation_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// StateNotifier for Quick Calculation
class QuickCalculationNotifier extends GameNotifier<QuickCalculation> {
  final int level;
  QuickCalculation? previousCurrentState;
  QuickCalculation? nextCurrentState;
  String result = "";

  QuickCalculationNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.QUICK_CALCULATION, ref) {
    startGame(level: level);
    _setNextState();
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Check the result entered by the player
  Future<void> checkResult(String answer) async {
    final timeState = ref.read(timeProvider(60));

    // Guard conditions
    if (timeState.timerStatus == TimerStatus.pause ||
        result.length >= state.currentState!.answer.toString().length) {
      return;
    }

    // Append digit and update state
    result += answer;
    state = state.copyWith(result: result);

    // ✅ Correct answer
    if (int.tryParse(result) == state.currentState!.answer) {
      await Future.delayed(const Duration(milliseconds: 300));

      _loadNewData();
      _setPreviousState();
      _setNextState();

      // Use parent class methods for scoring and coins
      rightAnswer();
      result = "";
      state = state.copyWith(result: result);
    }
    // ❌ Wrong answer when input length matches
    else if (result.length == state.currentState!.answer.toString().length) {
      // Use parent class method for wrong answer penalty
      wrongAnswer();
      result = "";
      state = state.copyWith(result: result);
    }
  }

  /// Reset result input
  void clearResult() {
    result = "";
    state = state.copyWith(result: result);
  }

  /// Remove last entered digit
  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      state = state.copyWith(result: result);
    }
  }

  /// Load new quick calculation data
  void _loadNewData() {
    final newDataList = QuickCalculationRepository.getQuickCalculationDataList(level, 5);
    if (newDataList.isNotEmpty) {
      state = state.copyWith(
        list: newDataList,
        currentState: newDataList.first,
        index: 0,
      );

      // Restart timer
      ref.read(timeProvider(60).notifier).restartTimer();
    }
  }

  /// Update previous state safely
  void _setPreviousState() {
    if (state.index > 0) {
      previousCurrentState = state.list[state.index - 1];
    } else {
      previousCurrentState = null;
    }
  }

  /// Update next state safely
  void _setNextState() {
    if (state.index + 1 < state.list.length) {
      nextCurrentState = state.list[state.index + 1];
    } else {
      nextCurrentState = null;
    }
  }
}

/// Riverpod provider for Quick Calculation
final quickCalculationProvider = StateNotifierProvider.family<
    QuickCalculationNotifier, GameState<QuickCalculation>, int>(
  (ref, level) => QuickCalculationNotifier(level: level, ref: ref),
);

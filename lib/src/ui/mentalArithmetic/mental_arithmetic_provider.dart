import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// StateNotifier for Mental Arithmetic
class MentalArithmeticNotifier extends GameNotifier<MentalArithmetic> {
  String result = "";
  final int level;

  MentalArithmeticNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.MENTAL_ARITHMETIC, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Called when user taps a digit or `-`
  Future<void> checkResult(String answer) async {
    final timeState = ref.read(timeProvider(60));

    if (timeState.timerStatus != TimerStatus.pause &&
        result.length < state.currentState!.answer.toString().length &&
        ((result.isEmpty && answer == "-") || (answer != "-"))) {
      result = result + answer;
      state = state.copyWith(result: result);

      // ✅ Correct answer
      if (result != "-" && int.tryParse(result) == state.currentState!.answer) {
        await Future.delayed(const Duration(milliseconds: 300));

        // Load new data
        _loadNewData();

        // Use parent class methods for scoring and coins
        rightAnswer();

        // Restart timer if not paused
        if (timeState.timerStatus != TimerStatus.pause) {
          ref.read(timeProvider(60).notifier).restartTimer();
        }

        result = "";
        state = state.copyWith(result: result);
      }
      // ❌ Wrong answer (length reached but value doesn't match)
      else if (result.length == state.currentState!.answer.toString().length) {
        // Use parent class method for wrong answer penalty
        wrongAnswer();
        result = "";
        state = state.copyWith(result: result);
      }
    }
  }

  /// Remove last digit
  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      state = state.copyWith(result: result);
    }
  }

  /// Clear current input
  void clearResult() {
    result = "";
    state = state.copyWith(result: result);
  }

  /// Load new mental arithmetic data
  void _loadNewData() {
    final newDataList = MentalArithmeticRepository.getMentalArithmeticDataList(level);
    if (newDataList.isNotEmpty) {
      state = state.copyWith(
        list: newDataList,
        currentState: newDataList.first,
        index: 0,
      );
    }
  }
}

/// Riverpod provider for Mental Arithmetic
final mentalArithmeticProvider = StateNotifierProvider.family<
    MentalArithmeticNotifier, GameState<MentalArithmetic>, int>(
  (ref, level) => MentalArithmeticNotifier(level: level, ref: ref),
);
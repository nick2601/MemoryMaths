import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/repository/number_pyramid_repository.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';

/// Number Pyramid Notifier (Riverpod)
class NumberPyramidNotifier extends GameNotifier<NumberPyramid> {
  final int level;

  NumberPyramidNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.NUMBER_PYRAMID, ref) {
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  /// Select a pyramid box cell
  void pyramidBoxSelection(NumPyramidCellModel model) {
    if (model.isHint || state.currentState == null) return; // can't edit hint cell

    final currentState = state.currentState!;

    // Unselect previously active cell
    final prevIndex = currentState.list.indexWhere((cell) => cell.isActive == true);
    final updatedList = [...currentState.list];

    if (prevIndex != -1) {
      updatedList[prevIndex] = updatedList[prevIndex].copyWith(isActive: false);
    }

    // Select new cell
    updatedList[model.id - 1] = updatedList[model.id - 1].copyWith(isActive: true);

    final newCurrentState = currentState.copyWith(list: updatedList);
    state = state.copyWith(currentState: newCurrentState);
  }

  /// Handle input into active cell
  void pyramidBoxInputValue(String value) {
    if (state.currentState == null) return;

    final currentState = state.currentState!;
    final currentIndex = currentState.list.indexWhere((cell) => cell.isActive == true);
    if (currentIndex == -1) return;

    final updatedList = [...currentState.list];

    if (value == "Back") {
      updatedList[currentIndex] = updatedList[currentIndex].copyWith(text: "");
      final newCurrentState = currentState.copyWith(list: updatedList);
      state = state.copyWith(currentState: newCurrentState);
      return;
    }

    if (value == "Done") {
      final filledCells = currentState.list.where((cell) => cell.text.isNotEmpty);
      if (filledCells.length == currentState.remainingCell) {
        checkCorrectValues();
      }
      return;
    }

    // Add digits
    final currentValue = currentState.list[currentIndex].text;
    if (currentValue.isNotEmpty && currentValue.length >= 3) return; // max 3 digits

    updatedList[currentIndex] = updatedList[currentIndex].copyWith(text: currentValue + value);
    final newCurrentState = currentState.copyWith(list: updatedList);
    state = state.copyWith(currentState: newCurrentState);
  }

  /// Check correctness of filled pyramid values
  Future<void> checkCorrectValues() async {
    if (state.currentState == null) return;

    final currentState = state.currentState!;
    final updatedList = [...currentState.list];

    for (int i = 0; i < updatedList.length; i++) {
      final cell = updatedList[i];
      if (!cell.isHint) {
        bool isCorrect = false;
        if (cell.text.isNotEmpty && int.tryParse(cell.text) == cell.numberOnCell) {
          isCorrect = true;
        }
        updatedList[i] = cell.copyWith(isCorrect: isCorrect, isDone: true);
      }
    }

    final correctCells = updatedList.where((cell) => cell.isCorrect == true).length;

    if (correctCells == currentState.remainingCell) {
      await Future.delayed(const Duration(milliseconds: 300));

      // Load next puzzle
      _loadNewData();

      // Use parent class methods for scoring and coins
      rightAnswer();

      // Restart timer if not paused
      final timeState = ref.read(timeProvider(60));
      if (timeState.timerStatus != TimerStatus.pause) {
        ref.read(timeProvider(60).notifier).restartTimer();
      }
    } else {
      // Use parent class method for wrong answer penalty
      wrongAnswer();
    }

    final newCurrentState = currentState.copyWith(list: updatedList);
    state = state.copyWith(currentState: newCurrentState);
  }

  /// Load new number pyramid data
  void _loadNewData() {
    final newDataList = NumberPyramidRepository.getPyramidDataList(level);
    if (newDataList.isNotEmpty) {
      state = state.copyWith(
        list: newDataList,
        currentState: newDataList.first,
        index: 0,
      );
    }
  }
}

/// Riverpod provider for Number Pyramid
final numberPyramidProvider = StateNotifierProvider.family<
    NumberPyramidNotifier, GameState<NumberPyramid>, int>(
  (ref, level) => NumberPyramidNotifier(level: level, ref: ref),
);
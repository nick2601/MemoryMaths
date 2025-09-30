import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/math_grid.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/data/repository/math_grid_repository.dart';
import '../app/time_provider.dart';

/// StateNotifier for Math Grid
class MathGridNotifier extends GameNotifier<MathGrid> {
  final int level;
  int answerIndex = 0;

  MathGridNotifier({required this.level, required Ref ref})
      : super(GameCategoryType.MATH_GRID, ref) {
    // Start game logic
    startGame(level: level);
    // Start timer
    ref.read(timeProvider(60).notifier).startTimer();
  }

  void checkResult(int index, MathGridCellModel gridModel) {
    final timeState = ref.read(timeProvider(60));

    if (timeState.timerStatus != TimerStatus.pause) {
      final updatedGridModel = gridModel.copyWith(isActive: !gridModel.isActive);
      final updatedList = List<MathGridCellModel>.from(state.currentState!.listForSquare);
      updatedList[index] = updatedGridModel;

      // Create new MathGrid instance
      final newMathGrid = MathGrid(
        listForSquare: updatedList,
        currentAnswer: state.currentState!.currentAnswer,
      );

      state = state.copyWith(currentState: newMathGrid);
      checkForCorrectAnswer();
    }
  }

  Future<void> checkForCorrectAnswer() async {
    if (state.currentState == null) return;

    int total = state.currentState!.listForSquare
        .where((cell) => cell.isActive)
        .fold(0, (sum, cell) => sum + cell.value);

    if (state.currentState!.currentAnswer == total) {
      final updatedCells = state.currentState!.listForSquare.map((cell) {
        if (cell.isActive) {
          return cell.copyWith(isActive: false, isRemoved: true);
        }
        return cell;
      }).toList();

      answerIndex++;

      if (updatedCells.every((cell) => cell.isRemoved)) {
        await Future.delayed(const Duration(milliseconds: 300));

        // Load new grid data
        _loadNewData();
        answerIndex = 0;

        // Update score
        rightAnswer(); // This calls the parent method which handles coins and score

        // Restart timer
        ref.read(timeProvider(60).notifier).restartTimer();
      } else {
        // Generate new answer with remaining cells
        final newMathGrid = MathGrid(listForSquare: updatedCells);
        state = state.copyWith(currentState: newMathGrid);
      }
    }
  }

  void _loadNewData() {
    final newMathGridList = MathGridRepository.getMathGridData(level);
    if (newMathGridList.isNotEmpty) {
      state = state.copyWith(
        list: newMathGridList,
        currentState: newMathGridList.first,
        index: 0,
      );
    }
  }

  void clear() {
    if (state.currentState != null) {
      final clearedCells = state.currentState!.listForSquare.map((cell) {
        return cell.copyWith(isActive: false);
      }).toList();

      final newMathGrid = MathGrid(
        listForSquare: clearedCells,
        currentAnswer: state.currentState!.currentAnswer,
      );

      state = state.copyWith(currentState: newMathGrid);
    }
  }
}

/// Riverpod provider for MathGrid
final mathGridProvider = StateNotifierProvider.family<
    MathGridNotifier, GameState<MathGrid>, int>(
  (ref, level) => MathGridNotifier(level: level, ref: ref),
);
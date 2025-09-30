import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/repository/calculator_repository.dart';
import 'package:mathsgames/src/data/repository/complex_calcualtion_repository.dart';
import 'package:mathsgames/src/data/repository/correct_answer_repository.dart';
import 'package:mathsgames/src/data/repository/cube_root_repository.dart';
import 'package:mathsgames/src/data/repository/dual_repository.dart';
import 'package:mathsgames/src/data/repository/find_missing_repository.dart';
import 'package:mathsgames/src/data/repository/magic_triangle_repository.dart';
import 'package:mathsgames/src/data/repository/math_grid_repository.dart';
import 'package:mathsgames/src/data/repository/math_pairs_repository.dart';
import 'package:mathsgames/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/data/repository/number_pyramid_repository.dart';
import 'package:mathsgames/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathsgames/src/data/repository/quick_calculation_repository.dart';
import 'package:mathsgames/src/data/repository/sign_repository.dart';
import 'package:mathsgames/src/data/repository/square_root_repository.dart';
import 'package:mathsgames/src/data/repository/true_false_repository.dart';

import '../../data/repository/numeric_memory_repository.dart';
import 'coin_provider.dart'; // ✅ import your coinProvider

/// Game state that works for all types

// dart
class GameState<T> {
  final List<T> list;
  final int index;
  final T? currentState;
  final double currentScore;
  final int rightCount;
  final int wrongCount;
  final DialogType dialogType;
  final bool isTimerRunning;
  final String result; // <-- Add this line

  const GameState({
    this.list = const [],
    this.index = 0,
    this.currentState,
    this.currentScore = 0,
    this.rightCount = 0,
    this.wrongCount = 0,
    this.dialogType = DialogType.non,
    this.isTimerRunning = false,
    this.result = "", // <-- Add this line
  });

  GameState<T> copyWith({
    List<T>? list,
    int? index,
    T? currentState,
    double? currentScore,
    int? rightCount,
    int? wrongCount,
    DialogType? dialogType,
    bool? isTimerRunning,
    String? result, // <-- Add this line
  }) {
    return GameState<T>(
      list: list ?? this.list,
      index: index ?? this.index,
      currentState: currentState ?? this.currentState,
      currentScore: currentScore ?? this.currentScore,
      rightCount: rightCount ?? this.rightCount,
      wrongCount: wrongCount ?? this.wrongCount,
      dialogType: dialogType ?? this.dialogType,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      result: result ?? this.result, // <-- Add this line
    );
  }
}

class GameNotifier<T> extends StateNotifier<GameState<T>> {
  final GameCategoryType type;
  final Ref ref;

  GameNotifier(this.type, this.ref) : super(GameState<T>());

  void startGame({int level = 1}) {
    final newList = _getList(level);
    state = state.copyWith(
      list: newList,
      index: 0,
      currentScore: 0,
      rightCount: 0,
      wrongCount: 0,
      currentState: newList.isNotEmpty ? newList.first : null,
      dialogType: DialogType.non,
      isTimerRunning: true,
    );
  }

  void rightAnswer() {
    final newScore = state.currentScore + KeyUtil.getScoreUtil(type);

    ref.read(coinProvider.notifier).addCoins(1);

    state = state.copyWith(
      currentScore: newScore.toDouble(),
      rightCount: state.rightCount + 1,
    );
  }

  void wrongAnswer() {
    final minusScore = KeyUtil.getScoreMinusUtil(type).abs();
    final newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);

    ref.read(coinProvider.notifier).minusCoins(1);

    state = state.copyWith(
      currentScore: newScore.toDouble(),
      wrongCount: state.wrongCount + 1,
    );
  }

  /// Direct coin helpers (optional for games to call directly)
  void addCoin() {
    ref.read(coinProvider.notifier).addCoins(1);
  }

  void minusCoin() {
    ref.read(coinProvider.notifier).minusCoins(1);
  }

  void next() {
    if (state.index + 1 < state.list.length) {
      state = state.copyWith(
        index: state.index + 1,
        currentState: state.list[state.index + 1],
        dialogType: DialogType.non,
      );
    } else {
      state = state.copyWith(dialogType: DialogType.over);
    }
  }

  void pause() {
    state = state.copyWith(
      dialogType: DialogType.pause,
      isTimerRunning: false,
    );
  }

  void resume() {
    state = state.copyWith(
      dialogType: DialogType.non,
      isTimerRunning: true,
    );
  }

  void exit() {
    state = state.copyWith(
      dialogType: DialogType.exit,
      isTimerRunning: false,
    );
  }

  void updateScore() {
    print("Score updated: ${state.currentScore}");
  }

  void resetGameCounters() {
    state = state.copyWith(
      rightCount: 0,
      wrongCount: 0,
      currentScore: 0,
      index: 0,
    );
  }

  void pauseResumeGame() {
    if (state.isTimerRunning) {
      pause();
    } else {
      resume();
    }
  }

  void gotItFromInfoDialog(int level) {
    startGame(level: level);
  }

  void showInfoDialog() {
    state = state.copyWith(dialogType: DialogType.info);
  }

  List<T> _getList(int level) {
    switch (type) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level) as List<T>;
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(level) as List<T>;
      case GameCategoryType.FIND_MISSING:
        return FindMissingRepository.getFindMissingDataList(level) as List<T>;
      case GameCategoryType.TRUE_FALSE:
        return TrueFalseRepository.getTrueFalseDataList(level) as List<T>;
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level) as List<T>;
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level) as List<T>;
      case GameCategoryType.CONCENTRATION:
        return MathPairsRepository.getMathPairsDataList(level) as List<T>;
      case GameCategoryType.NUMERIC_MEMORY:
        return NumericMemoryRepository.getNumericMemoryDataList(level)
        as List<T>;
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level)
        as List<T>;
      case GameCategoryType.MAGIC_TRIANGLE:
        return (level > 15)
            ? MagicTriangleRepository.getNextLevelTriangleDataProviderList()
        as List<T>
            : MagicTriangleRepository.getTriangleDataProviderList() as List<T>;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level)
        as List<T>;
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(
            level, 5) as List<T>;
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level) as List<T>;
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level)
        as List<T>;
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level) as List<T>;
      case GameCategoryType.DUAL_GAME:
        return DualRepository.getDualData(level) as List<T>;
      case GameCategoryType.COMPLEX_CALCULATION:
        return ComplexCalculationRepository.getComplexData(level) as List<T>;
      case GameCategoryType.CUBE_ROOT:
        return CubeRootRepository.getCubeDataList(level) as List<T>;
    }
  }
}

/// ✅ updated provider — pass `ref` into GameNotifier
final gameProvider = StateNotifierProvider.family<
    GameNotifier<dynamic>,
    GameState<dynamic>,
    GameCategoryType>(
      (ref, type) => GameNotifier(type, ref),
);
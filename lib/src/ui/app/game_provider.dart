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

class GameState<T> {
  final List<T> list;
  final int index;
  final double currentScore;
  final int rightCount;
  final int wrongCount;
  final DialogType dialogType;
  final bool isTimerRunning;
  final T? currentState;

  const GameState({
    this.list = const [],
    this.index = 0,
    this.currentScore = 0,
    this.rightCount = 0,
    this.wrongCount = 0,
    this.dialogType = DialogType.non,
    this.isTimerRunning = false,
    this.currentState,
  });

  GameState<T> copyWith({
    List<T>? list,
    int? index,
    double? currentScore,
    int? rightCount,
    int? wrongCount,
    DialogType? dialogType,
    bool? isTimerRunning,
    T? currentState,
  }) {
    return GameState<T>(
      list: list ?? this.list,
      index: index ?? this.index,
      currentScore: currentScore ?? this.currentScore,
      rightCount: rightCount ?? this.rightCount,
      wrongCount: wrongCount ?? this.wrongCount,
      dialogType: dialogType ?? this.dialogType,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      currentState: currentState ?? this.currentState,
    );
  }
}

class GameNotifier<T> extends StateNotifier<GameState<T>> {
  final GameCategoryType type;

  GameNotifier(this.type) : super(GameState<T>());

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
  void showInfoDialog() {
    // Implement the logic for showing the info dialog
    print("Info dialog shown");
  }
  void rightAnswer() {
    final newScore = state.currentScore + KeyUtil.getScoreUtil(type);
    state = state.copyWith(
      currentScore: newScore,
      rightCount: state.rightCount + 1,
    );
  }

  void wrongAnswer() {
    double minusScore = KeyUtil.getScoreMinusUtil(type).abs();
    double newScore =
    (state.currentScore - minusScore).clamp(0, double.infinity);
    state = state.copyWith(
      currentScore: newScore,
      wrongCount: state.wrongCount + 1,
    );
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
    // Save to local storage, database, or just log
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
    // Typically, resume game from tutorial/info state
    startGame(level: level);
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
        return NumericMemoryRepository.getNumericMemoryDataList(level) as List<T>;
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level) as List<T>;
      case GameCategoryType.MAGIC_TRIANGLE:
        return (level > 15)
            ? MagicTriangleRepository.getNextLevelTriangleDataProviderList()
        as List<T>
            : MagicTriangleRepository.getTriangleDataProviderList() as List<T>;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level)
        as List<T>;
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5)
        as List<T>;
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level) as List<T>;
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level) as List<T>;
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

final gameProvider = StateNotifierProvider.family<
    GameNotifier<dynamic>,
    GameState<dynamic>,
    GameCategoryType>(
      (ref, type) => GameNotifier(type),
);

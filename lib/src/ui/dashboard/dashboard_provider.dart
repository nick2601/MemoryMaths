import 'dart:convert';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/data/models/score_board.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/game_category.dart';
import '../../utility/global_constants.dart';

class DashboardProvider extends CoinProvider {
  int _overallScore = 0;
  // int _coin = 0;
  late List<GameCategory> _list;
  final SharedPreferences preferences;

  int get overallScore => _overallScore;
  // int get coin => _coin;

  List<GameCategory> get list => _list;

  DashboardProvider({required this.preferences}) : super(preferences: preferences) {
    _overallScore = getOverallScore();
    getCoin();
  }

  List<GameCategory> getGameByPuzzleType(PuzzleType puzzleType) {
    _list = <GameCategory>[];

    switch (puzzleType) {
      case PuzzleType.MATH_PUZZLE:
        list.add(GameCategory(
          1,
          "Calculate For Me",
          keyCalculator,
          GameCategoryType.CALCULATOR,
          KeyUtil.calculator,
          getScoreboard(keyCalculator),
          AppAssets.icCalculator,
        ));
        list.add(GameCategory(
            2,
            "Guess the Sign?",
            keySign,
            GameCategoryType.GUESS_SIGN,
            KeyUtil.guessSign,
            getScoreboard(keySign),
            AppAssets.icGuessTheSign));
        list.add(GameCategory(
          3,
          "Identify Right Nos",
          keyCorrectAnswer,
          GameCategoryType.CORRECT_ANSWER,
          KeyUtil.correctAnswer,
          getScoreboard(keyCorrectAnswer),
          AppAssets.icCorrectAnswer,
        ));
        list.add(GameCategory(
          4,
          "Quick Calculation",
          keyQuickCalculation,
          GameCategoryType.QUICK_CALCULATION,
          KeyUtil.quickCalculation,
          getScoreboard(keyQuickCalculation),
          AppAssets.icQuickCalculation,
        ));
        list.add(GameCategory(
          5,
          "Find Missing ",
          keyFindMissingCalculation,
          GameCategoryType.FIND_MISSING,
          KeyUtil.findMissing,
          getScoreboard(keyFindMissingCalculation),
          AppAssets.icFindMissing,
        ));

        list.add(GameCategory(
          6,
          "True or False",
          keyTrueFalseCalculation,
          GameCategoryType.TRUE_FALSE,
          KeyUtil.trueFalse,
          getScoreboard(keyTrueFalseCalculation),
          AppAssets.icTrueFalse,
        ));

        list.add(GameCategory(
          7,
          "Complex Work",
          keyComplexGame,
          GameCategoryType.COMPLEX_CALCULATION,
          KeyUtil.complexCalculation,
          getScoreboard(keyComplexGame),
          AppAssets.icComplexCalculation,
        ));

        list.add(GameCategory(
          8,
          "2 Player Mode",
          keyDualGame,
          GameCategoryType.DUAL_GAME,
          KeyUtil.dualGame,
          getScoreboard(keyDualGame),
          AppAssets.icDualGame,
        ));
        break;
      case PuzzleType.MEMORY_PUZZLE:
        list.add(GameCategory(
          9,
          "Mental arithmetic",
          keyMentalArithmetic,
          GameCategoryType.MENTAL_ARITHMETIC,
          KeyUtil.mentalArithmetic,
          getScoreboard(keyMentalArithmetic),
          AppAssets.icMentalArithmetic,
        ));

        list.add(GameCategory(
          10,
          "Square root",
          keySquareRoot,
          GameCategoryType.SQUARE_ROOT,
          KeyUtil.squareRoot,
          getScoreboard(keySquareRoot),
          AppAssets.icSquareRoot,
        ));
        list.add(GameCategory(
          11,
          "Math Grid",
          keyMathMachine,
          GameCategoryType.MATH_GRID,
          KeyUtil.mathGrid,
          getScoreboard(keyMathMachine),
          AppAssets.icMathGrid,
        ));
        list.add(GameCategory(
          12,
          "Mathematical pairs",
          keyMathPairs,
          GameCategoryType.MATH_PAIRS,
          KeyUtil.mathPairs,
          getScoreboard(keyMathPairs),
          AppAssets.icMathematicalPairs,
        ));

        list.add(GameCategory(
          13,
          "Cube Root",
          keyCubeRoot,
          GameCategoryType.CUBE_ROOT,
          KeyUtil.cubeRoot,
          getScoreboard(keyCubeRoot),
          AppAssets.icCubeRoot,
        ));

        list.add(GameCategory(
          14,
          "Concentration",
          keyConcentration,
          GameCategoryType.CONCENTRATION,
          KeyUtil.concentration,
          getScoreboard(keyConcentration),
          AppAssets.icConcentration,
        ));
        break;
      case PuzzleType.BRAIN_PUZZLE:
        list.add(GameCategory(
          15,
          "Magic triangle",
          keyMagicTriangle,
          GameCategoryType.MAGIC_TRIANGLE,
          KeyUtil.magicTriangle,
          getScoreboard(keyMagicTriangle),
          AppAssets.icMagicTriangle,
        ));
        list.add(GameCategory(
          16,
          "Picture Puzzle",
          keyPicturePuzzle,
          GameCategoryType.PICTURE_PUZZLE,
          KeyUtil.picturePuzzle,
          getScoreboard(keyPicturePuzzle),
          AppAssets.icPicturePuzzle,
        ));
        list.add(GameCategory(
          17,
          "Number Pyramid",
          keyNumberPyramid,
          GameCategoryType.NUMBER_PYRAMID,
          KeyUtil.numberPyramid,
          getScoreboard(keyNumberPyramid),
          AppAssets.icNumberPyramid,
        ));

        list.add(GameCategory(
          18,
          "Numeric Memory",
          keyNumericMemory,
          GameCategoryType.NUMERIC_MEMORY,
          KeyUtil.numericMemory,
          getScoreboard(keyNumericMemory),
          AppAssets.icNumericMemory,
        ));
        break;
    }

    // switch (puzzleType) {
    //   case PuzzleType.MATH_PUZZLE:
    //     list.add(GameCategory(
    //       1,
    //       "Calculator",
    //       keyCalculator,
    //       GameCategoryType.CALCULATOR,
    //       KeyUtil.calculator,
    //       getScoreboard(keyCalculator),
    //       AppAssets.icCalculator,
    //     ));
    //     list.add(GameCategory(
    //         2,
    //         "Guess the sign?",
    //         keySign,
    //         GameCategoryType.GUESS_SIGN,
    //         KeyUtil.guessSign,
    //         getScoreboard(keySign),
    //         AppAssets.icGuessTheSign));
    //     list.add(GameCategory(
    //       5,
    //       "Correct answer",
    //       keyCorrectAnswer,
    //       GameCategoryType.CORRECT_ANSWER,
    //       KeyUtil.correctAnswer,
    //       getScoreboard(keyCorrectAnswer),
    //       AppAssets.icCorrectAnswer,
    //     ));
    //     list.add(GameCategory(
    //       8,
    //       "Quick calculation",
    //       keyQuickCalculation,
    //       GameCategoryType.QUICK_CALCULATION,
    //       KeyUtil.quickCalculation,
    //       getScoreboard(keyQuickCalculation),
    //       AppAssets.icQuickCalculation,
    //     ));
    //     break;
    //   case PuzzleType.MEMORY_PUZZLE:
    //     list.add(GameCategory(
    //       7,
    //       "Mental arithmetic",
    //       keyMentalArithmetic,
    //       GameCategoryType.MENTAL_ARITHMETIC,
    //       KeyUtil.mentalArithmetic,
    //       getScoreboard(keyMentalArithmetic),
    //       AppAssets.icMentalArithmetic,
    //     ));
    //     list.add(GameCategory(
    //       3,
    //       "Square root",
    //       keySquareRoot,
    //       GameCategoryType.SQUARE_ROOT,
    //       KeyUtil.squareRoot,
    //       getScoreboard(keySquareRoot),
    //       AppAssets.icSquareRoot,
    //     ));
    //     list.add(GameCategory(
    //       9,
    //       "Math Grid",
    //       keyMathMachine,
    //       GameCategoryType.MATH_GRID,
    //       KeyUtil.mathGrid,
    //       getScoreboard(keyMathMachine),
    //       AppAssets.icMathGrid,
    //     ));
    //     list.add(GameCategory(
    //       4,
    //       "Mathematical pairs",
    //       keyMathPairs,
    //       GameCategoryType.MATH_PAIRS,
    //       KeyUtil.mathPairs,
    //       getScoreboard(keyMathPairs),
    //       AppAssets.icMathematicalPairs,
    //     ));
    //     break;
    //   case PuzzleType.BRAIN_PUZZLE:
    //     list.add(GameCategory(
    //       6,
    //       "Magic triangle",
    //       keyMagicTriangle,
    //       GameCategoryType.MAGIC_TRIANGLE,
    //       KeyUtil.magicTriangle,
    //       getScoreboard(keyMagicTriangle),
    //       AppAssets.icMagicTriangle,
    //     ));
    //     list.add(GameCategory(
    //       10,
    //       "Picture Puzzle",
    //       keyPicturePuzzle,
    //       GameCategoryType.PICTURE_PUZZLE,
    //       KeyUtil.picturePuzzle,
    //       getScoreboard(keyPicturePuzzle),
    //       AppAssets.icPicturePuzzle,
    //     ));
    //     list.add(GameCategory(
    //       11,
    //       "Number Pyramid",
    //       keyNumberPyramid,
    //       GameCategoryType.NUMBER_PYRAMID,
    //       KeyUtil.numberPyramid,
    //       getScoreboard(keyNumberPyramid),
    //       AppAssets.icNumberPyramid,
    //     ));
    //     break;
    // }
    return _list;
  }

  ScoreBoard getScoreboard(String gameCategoryType) {
    return ScoreBoard.fromJson(
        json.decode(preferences.getString(gameCategoryType) ?? "{}"));
  }

  void setScoreboard(String gameCategoryType, ScoreBoard scoreboard) {
    preferences.setString(gameCategoryType, json.encode(scoreboard.toJson()));
  }

  void updateScoreboard(GameCategoryType gameCategoryType, double newScore) {
    list.forEach((gameCategory) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        if (gameCategory.scoreboard.highestScore < newScore.toInt()) {
          setOverallScore(
              gameCategory.scoreboard.highestScore, newScore.toInt());
          gameCategory.scoreboard.highestScore = newScore.toInt();
        }
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    });
    notifyListeners();
  }

  int getOverallCoin() {
    return preferences.getInt(CoinProvider(preferences: preferences).keyCoin) ?? 0;
  }

  int getOverallScore() {
    return preferences.getInt("overall_score") ?? 0;
  }

  void setOverallScore(int highestScore, int newScore) {
    _overallScore = getOverallScore() - highestScore + newScore;
    preferences.setInt("overall_score", _overallScore);
  }

  bool isFirstTime(GameCategoryType gameCategoryType) {
    return list
        .where((GameCategory gameCategory) =>
            gameCategory.gameCategoryType == gameCategoryType)
        .first
        .scoreboard
        .firstTime;
  }

  void setFirstTime(GameCategoryType gameCategoryType) {
    list.forEach((gameCategory) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        gameCategory.scoreboard.firstTime = false;
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    });
  }

  /// Resets all scores and progress data for the current user
  Future<void> resetAllScoreData() async {
    final allKeys = preferences.getKeys();

    // Find all score-related keys
    final scoreKeys = allKeys.where((key) =>
      key == 'overall_score' ||  // Overall score
      key == keyCalculator ||
      key == keySign ||
      key == keyCorrectAnswer ||
      key == keyQuickCalculation ||
      key == keyFindMissingCalculation ||
      key == keyTrueFalseCalculation ||
      key == keyDualGame ||
      key == keyComplexGame ||
      key == keyMentalArithmetic ||
      key == keySquareRoot ||
      key == keyMathMachine ||
      key == keyMathPairs ||
      key == keyCubeRoot ||
      key == keyConcentration ||
      key == keyMagicTriangle ||
      key == keyPicturePuzzle ||
      key == keyNumberPyramid ||
      key == keyNumericMemory ||
      key.startsWith('score_') ||  // Any other score keys
      key.startsWith('scoreboard_') ||  // Any scoreboard keys
      key.contains('_score') ||  // Any keys containing '_score'
      key.contains('Score')  // Any keys containing 'Score'
    ).toList();

    print("Found ${scoreKeys.length} score-related keys to delete:");
    for (final key in scoreKeys) {
      print("Deleting score key: $key");
      await preferences.remove(key);
    }

    // Reset overall score to 0
    _overallScore = 0;
    await preferences.setInt("overall_score", 0);

    // Force refresh of game list to show reset scores
    _refreshGameList();

    notifyListeners();
    print("All score data cleared. Overall score: $_overallScore");
  }

  /// Helper method to refresh the game list after reset
  void _refreshGameList() {
    // Force regeneration of game categories with fresh scoreboards
    for (PuzzleType puzzleType in PuzzleType.values) {
      getGameByPuzzleType(puzzleType);
    }
  }

  /// Resets scores for a specific game category
  Future<void> resetGameScore(String gameKey) async {
    await preferences.remove(gameKey);
    print("Reset score for game: $gameKey");

    // Recalculate overall score
    _recalculateOverallScore();
    notifyListeners();
  }

  /// Recalculates the overall score from all individual game scores
  void _recalculateOverallScore() {
    int totalScore = 0;

    // Sum up all high scores from individual games
    final gameKeys = [
      keyCalculator, keySign, keyCorrectAnswer, keyQuickCalculation,
      keyFindMissingCalculation, keyTrueFalseCalculation, keyDualGame,
      keyComplexGame, keyMentalArithmetic, keySquareRoot, keyMathMachine,
      keyMathPairs, keyCubeRoot, keyConcentration, keyMagicTriangle,
      keyPicturePuzzle, keyNumberPyramid, keyNumericMemory
    ];

    for (String key in gameKeys) {
      ScoreBoard scoreboard = getScoreboard(key);
      totalScore += scoreboard.highestScore;
    }

    _overallScore = totalScore;
    preferences.setInt("overall_score", _overallScore);
  }
}

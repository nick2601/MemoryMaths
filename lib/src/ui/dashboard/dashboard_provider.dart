import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/score_board.dart';
import 'package:mathsgames/src/data/models/game_category.dart';
import 'package:mathsgames/src/utility/Constants.dart';

/// Dashboard State
class DashboardState {
  final int overallScore;
  final int coins;
  final List<GameCategory> categories;

  const DashboardState({
    this.overallScore = 0,
    this.coins = 0,
    this.categories = const [],
  });

  DashboardState copyWith({
    int? overallScore,
    int? coins,
    List<GameCategory>? categories,
  }) {
    return DashboardState(
      overallScore: overallScore ?? this.overallScore,
      coins: coins ?? this.coins,
      categories: categories ?? this.categories,
    );
  }
}

/// Dashboard Notifier
class DashboardNotifier extends StateNotifier<DashboardState> {
  final Box box;

  DashboardNotifier(this.box) : super(const DashboardState()) {
    _init();
    _loadAllCategories(); // ✅ preload once
  }

  void _init() {
    final score = box.get("overall_score", defaultValue: 0) as int;
    final coins = box.get("coins", defaultValue: 0) as int;
    state = state.copyWith(overallScore: score, coins: coins);
  }

  /// ===========================
  /// 🚀 Load All Categories
  /// ===========================
  void _loadAllCategories() {
    final allCategories = <GameCategory>[
      // MATH PUZZLES
      GameCategory(
        id: 1,
        name: "Calculate For Me",
        key: keyCalculator,
        gameCategoryType: GameCategoryType.CALCULATOR,
        routePath: KeyUtil.calculator,
        scoreboard: getScoreboard(keyCalculator),
        icon: AppAssets.icCalculator,
        puzzleType: PuzzleType.MATH_PUZZLE,
      ),
      GameCategory(
        id: 6,
        name: "True or False",
        key: keyTrueFalseCalculation,
        gameCategoryType: GameCategoryType.TRUE_FALSE,
        routePath: KeyUtil.trueFalse,
        scoreboard: getScoreboard(keyTrueFalseCalculation),
        icon: AppAssets.icTrueFalse,
        puzzleType: PuzzleType.MATH_PUZZLE,
      ),

      // MEMORY PUZZLES
      GameCategory(
        id: 12,
        name: "Mathematical Pairs",
        key: keyMathPairs,
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        routePath: KeyUtil.mathPairs,
        scoreboard: getScoreboard(keyMathPairs),
        icon: AppAssets.icMathematicalPairs,
        puzzleType: PuzzleType.MEMORY_PUZZLE,
      ),
      GameCategory(
        id: 14,
        name: "Concentration",
        key: keyConcentration,
        gameCategoryType: GameCategoryType.CONCENTRATION,
        routePath: KeyUtil.concentration,
        scoreboard: getScoreboard(keyConcentration),
        icon: AppAssets.icConcentration,
        puzzleType: PuzzleType.MEMORY_PUZZLE,
      ),

      // BRAIN PUZZLES
      GameCategory(
        id: 15,
        name: "Magic Triangle",
        key: keyMagicTriangle,
        gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        routePath: KeyUtil.magicTriangle,
        scoreboard: getScoreboard(keyMagicTriangle),
        icon: AppAssets.icMagicTriangle,
        puzzleType: PuzzleType.BRAIN_PUZZLE,
      ),
      GameCategory(
        id: 16,
        name: "Picture Puzzle",
        key: keyPicturePuzzle,
        gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
        routePath: KeyUtil.picturePuzzle,
        scoreboard: getScoreboard(keyPicturePuzzle),
        icon: AppAssets.icPicturePuzzle,
        puzzleType: PuzzleType.BRAIN_PUZZLE,
      ),
    ];

    state = state.copyWith(categories: allCategories);
  }

  /// ===========================
  /// 🚀 Coins Management
  /// ===========================
  void addCoins(int value) {
    final newCoins = state.coins + value;
    box.put("coins", newCoins);
    state = state.copyWith(coins: newCoins);
  }

  void spendCoins(int value) {
    if (state.coins >= value) {
      final newCoins = state.coins - value;
      box.put("coins", newCoins);
      state = state.copyWith(coins: newCoins);
    }
  }

  /// ===========================
  /// 🚀 Scoreboard Management
  /// ===========================
  List<GameCategory> getGameByPuzzleType(PuzzleType puzzleType) {
    // ✅ Pure filter — no state mutation here
    return state.categories
        .where((c) => c.puzzleType == puzzleType)
        .toList();
  }

  ScoreBoard getScoreboard(String key) {
    final jsonStr = box.get(key, defaultValue: "{}") as String;
    return ScoreBoard.fromJson(json.decode(jsonStr));
  }

  void setScoreboard(String key, ScoreBoard scoreboard) {
    box.put(key, json.encode(scoreboard.toJson()));
  }

  void updateScoreboard(GameCategoryType type, double newScore) {
    final updated = state.categories.map((gameCategory) {
      if (gameCategory.gameCategoryType == type) {
        if (gameCategory.scoreboard.highestScore < newScore.toInt()) {
          _setOverallScore(
            gameCategory.scoreboard.highestScore,
            newScore.toInt(),
          );
          final updatedScoreboard = gameCategory.scoreboard.copyWith(
            highestScore: newScore.toInt(),
          );
          setScoreboard(gameCategory.key, updatedScoreboard);
          return gameCategory.copyWith(scoreboard: updatedScoreboard);
        }
      }
      return gameCategory;
    }).toList();

    state = state.copyWith(categories: updated);
  }

  /// ===========================
  /// 🚀 Overall Score
  /// ===========================
  void _setOverallScore(int oldScore, int newScore) {
    final updatedScore = state.overallScore - oldScore + newScore;
    box.put("overall_score", updatedScore);
    state = state.copyWith(overallScore: updatedScore);
  }

  /// ===========================
  /// 🚀 First-Time Flag
  /// ===========================
  bool isFirstTime(GameCategoryType type) {
    return state.categories
        .firstWhere((c) => c.gameCategoryType == type)
        .scoreboard
        .firstTime;
  }

  void setFirstTime(GameCategoryType type) {
    final updated = state.categories.map((gameCategory) {
      if (gameCategory.gameCategoryType == type) {
        final updatedScoreboard =
        gameCategory.scoreboard.copyWith(firstTime: false);
        setScoreboard(gameCategory.key, updatedScoreboard);
        return gameCategory.copyWith(scoreboard: updatedScoreboard);
      }
      return gameCategory;
    }).toList();

    state = state.copyWith(categories: updated);
  }

  /// ===========================
  /// 🚀 Settings Placeholder
  /// ===========================
  void openSettings() {
    // For now: Add analytics/logging later if needed
  }
}

/// Provider for Dashboard
final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final box = Hive.box("dashboard"); // single Hive box
  return DashboardNotifier(box);
});
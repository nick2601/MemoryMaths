/// Base domain entity for all game types
/// This represents common properties across all math games
/// Clean Architecture: Domain Layer - Entities
abstract class GameEntity {
  final int level;
  final int difficulty;

  GameEntity({
    required this.level,
    required this.difficulty,
  });
}

/// Entity for game score and progress
class GameScoreEntity {
  final int rightCount;
  final int wrongCount;
  final double currentScore;
  final int level;

  GameScoreEntity({
    required this.rightCount,
    required this.wrongCount,
    required this.currentScore,
    required this.level,
  });

  @override
  String toString() {
    return 'GameScoreEntity{rightCount: $rightCount, wrongCount: $wrongCount, score: $currentScore, level: $level}';
  }
}

/// Entity for game configuration
class GameConfigEntity {
  final bool isSoundEnabled;
  final bool isVibrationEnabled;
  final bool isDarkMode;
  final int timeLimit;

  GameConfigEntity({
    required this.isSoundEnabled,
    required this.isVibrationEnabled,
    required this.isDarkMode,
    required this.timeLimit,
  });
}

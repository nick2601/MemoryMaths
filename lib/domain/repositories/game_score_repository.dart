import 'package:mathsgames/domain/entities/game_entity.dart';

/// Repository interface for game score and progress
/// Clean Architecture: Domain Layer - Repository contracts
abstract class GameScoreRepository {
  /// Saves game score
  Future<void> saveScore(GameScoreEntity score);

  /// Gets game score for a specific level
  Future<GameScoreEntity?> getScore(int level);

  /// Gets high score
  Future<double> getHighScore();

  /// Gets total coins/points
  Future<int> getTotalCoins();

  /// Updates total coins/points
  Future<void> updateCoins(int coins);

  /// Clears all scores
  Future<void> clearAllScores();
}

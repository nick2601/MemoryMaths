import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/repositories/game_score_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository implementation for game score
/// Clean Architecture: Data Layer - Repository Implementations
/// This bridges to existing SharedPreferences usage
class GameScoreRepositoryImpl implements GameScoreRepository {
  final SharedPreferences sharedPreferences;

  GameScoreRepositoryImpl({required this.sharedPreferences});

  @override
  Future<void> saveScore(GameScoreEntity score) async {
    final key = 'score_level_${score.level}';
    await sharedPreferences.setDouble(key, score.currentScore);
    await sharedPreferences.setInt('${key}_right', score.rightCount);
    await sharedPreferences.setInt('${key}_wrong', score.wrongCount);
  }

  @override
  Future<GameScoreEntity?> getScore(int level) async {
    final key = 'score_level_$level';
    final score = sharedPreferences.getDouble(key);
    if (score == null) return null;

    final rightCount = sharedPreferences.getInt('${key}_right') ?? 0;
    final wrongCount = sharedPreferences.getInt('${key}_wrong') ?? 0;

    return GameScoreEntity(
      rightCount: rightCount,
      wrongCount: wrongCount,
      currentScore: score,
      level: level,
    );
  }

  @override
  Future<double> getHighScore() async {
    return sharedPreferences.getDouble('high_score') ?? 0.0;
  }

  @override
  Future<int> getTotalCoins() async {
    return sharedPreferences.getInt('total_coins') ?? 0;
  }

  @override
  Future<void> updateCoins(int coins) async {
    await sharedPreferences.setInt('total_coins', coins);
  }

  @override
  Future<void> clearAllScores() async {
    final keys = sharedPreferences.getKeys();
    for (final key in keys) {
      if (key.startsWith('score_level_') || key == 'high_score' || key == 'total_coins') {
        await sharedPreferences.remove(key);
      }
    }
  }
}

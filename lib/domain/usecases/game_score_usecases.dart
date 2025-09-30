import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/repositories/game_score_repository.dart';

/// Use case for saving game score
/// Clean Architecture: Domain Layer - Use Cases
class SaveGameScoreUseCase {
  final GameScoreRepository repository;

  SaveGameScoreUseCase(this.repository);

  Future<void> execute(GameScoreEntity score) async {
    if (score.level < 1) {
      throw ArgumentError('Level must be greater than 0');
    }
    await repository.saveScore(score);
  }
}

/// Use case for getting game score
class GetGameScoreUseCase {
  final GameScoreRepository repository;

  GetGameScoreUseCase(this.repository);

  Future<GameScoreEntity?> execute(int level) async {
    if (level < 1) {
      throw ArgumentError('Level must be greater than 0');
    }
    return await repository.getScore(level);
  }
}

/// Use case for getting high score
class GetHighScoreUseCase {
  final GameScoreRepository repository;

  GetHighScoreUseCase(this.repository);

  Future<double> execute() async {
    return await repository.getHighScore();
  }
}

/// Use case for managing coins
class ManageCoinsUseCase {
  final GameScoreRepository repository;

  ManageCoinsUseCase(this.repository);

  Future<int> getTotalCoins() async {
    return await repository.getTotalCoins();
  }

  Future<void> addCoins(int amount) async {
    if (amount < 0) {
      throw ArgumentError('Amount must be non-negative');
    }
    final currentCoins = await repository.getTotalCoins();
    await repository.updateCoins(currentCoins + amount);
  }

  Future<void> deductCoins(int amount) async {
    if (amount < 0) {
      throw ArgumentError('Amount must be non-negative');
    }
    final currentCoins = await repository.getTotalCoins();
    if (currentCoins < amount) {
      throw Exception('Insufficient coins');
    }
    await repository.updateCoins(currentCoins - amount);
  }
}

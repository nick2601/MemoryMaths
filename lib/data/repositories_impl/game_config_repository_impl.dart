import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/repositories/game_config_repository.dart';
import 'package:mathsgames/data/datasources/game_config_datasource.dart';

/// Repository implementation for game configuration
/// Clean Architecture: Data Layer - Repository Implementations
class GameConfigRepositoryImpl implements GameConfigRepository {
  final GameConfigDataSource dataSource;

  GameConfigRepositoryImpl({required this.dataSource});

  @override
  Future<GameConfigEntity> getGameConfig() async {
    final isSoundEnabled = await dataSource.getSoundEnabled();
    final isVibrationEnabled = await dataSource.getVibrationEnabled();
    final isDarkMode = await dataSource.getDarkModeEnabled();
    final timeLimit = await dataSource.getTimeLimit();

    return GameConfigEntity(
      isSoundEnabled: isSoundEnabled,
      isVibrationEnabled: isVibrationEnabled,
      isDarkMode: isDarkMode,
      timeLimit: timeLimit,
    );
  }

  @override
  Future<void> updateGameConfig(GameConfigEntity config) async {
    await dataSource.setSoundEnabled(config.isSoundEnabled);
    await dataSource.setVibrationEnabled(config.isVibrationEnabled);
    await dataSource.setDarkModeEnabled(config.isDarkMode);
    await dataSource.setTimeLimit(config.timeLimit);
  }

  @override
  Future<bool> isSoundEnabled() async {
    return await dataSource.getSoundEnabled();
  }

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    await dataSource.setSoundEnabled(enabled);
  }

  @override
  Future<bool> isVibrationEnabled() async {
    return await dataSource.getVibrationEnabled();
  }

  @override
  Future<void> setVibrationEnabled(bool enabled) async {
    await dataSource.setVibrationEnabled(enabled);
  }

  @override
  Future<bool> isDarkModeEnabled() async {
    return await dataSource.getDarkModeEnabled();
  }

  @override
  Future<void> setDarkModeEnabled(bool enabled) async {
    await dataSource.setDarkModeEnabled(enabled);
  }
}

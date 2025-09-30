import 'package:mathsgames/domain/entities/game_entity.dart';

/// Repository interface for game configuration and settings
/// Clean Architecture: Domain Layer - Repository contracts
abstract class GameConfigRepository {
  /// Gets current game configuration
  Future<GameConfigEntity> getGameConfig();

  /// Updates game configuration
  Future<void> updateGameConfig(GameConfigEntity config);

  /// Gets sound setting
  Future<bool> isSoundEnabled();

  /// Sets sound setting
  Future<void> setSoundEnabled(bool enabled);

  /// Gets vibration setting
  Future<bool> isVibrationEnabled();

  /// Sets vibration setting
  Future<void> setVibrationEnabled(bool enabled);

  /// Gets dark mode setting
  Future<bool> isDarkModeEnabled();

  /// Sets dark mode setting
  Future<void> setDarkModeEnabled(bool enabled);
}

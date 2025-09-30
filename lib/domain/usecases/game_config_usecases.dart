import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/repositories/game_config_repository.dart';

/// Use case for getting game configuration
/// Clean Architecture: Domain Layer - Use Cases
class GetGameConfigUseCase {
  final GameConfigRepository repository;

  GetGameConfigUseCase(this.repository);

  Future<GameConfigEntity> execute() async {
    return await repository.getGameConfig();
  }
}

/// Use case for updating game configuration
class UpdateGameConfigUseCase {
  final GameConfigRepository repository;

  UpdateGameConfigUseCase(this.repository);

  Future<void> execute(GameConfigEntity config) async {
    await repository.updateGameConfig(config);
  }
}

/// Use case for toggling sound
class ToggleSoundUseCase {
  final GameConfigRepository repository;

  ToggleSoundUseCase(this.repository);

  Future<void> execute(bool enabled) async {
    await repository.setSoundEnabled(enabled);
  }
}

/// Use case for toggling vibration
class ToggleVibrationUseCase {
  final GameConfigRepository repository;

  ToggleVibrationUseCase(this.repository);

  Future<void> execute(bool enabled) async {
    await repository.setVibrationEnabled(enabled);
  }
}

/// Use case for toggling dark mode
class ToggleDarkModeUseCase {
  final GameConfigRepository repository;

  ToggleDarkModeUseCase(this.repository);

  Future<void> execute(bool enabled) async {
    await repository.setDarkModeEnabled(enabled);
  }
}

import 'package:flutter/foundation.dart';
import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/usecases/game_config_usecases.dart';

/// ViewModel for game configuration
/// Clean Architecture: Presentation Layer - ViewModels
class GameConfigViewModel extends ChangeNotifier {
  final GetGameConfigUseCase getGameConfigUseCase;
  final UpdateGameConfigUseCase updateGameConfigUseCase;
  final ToggleSoundUseCase toggleSoundUseCase;
  final ToggleVibrationUseCase toggleVibrationUseCase;
  final ToggleDarkModeUseCase toggleDarkModeUseCase;

  GameConfigViewModel({
    required this.getGameConfigUseCase,
    required this.updateGameConfigUseCase,
    required this.toggleSoundUseCase,
    required this.toggleVibrationUseCase,
    required this.toggleDarkModeUseCase,
  });

  GameConfigEntity? _config;
  bool _isLoading = false;
  String? _error;

  // Getters
  GameConfigEntity? get config => _config;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSoundEnabled => _config?.isSoundEnabled ?? true;
  bool get isVibrationEnabled => _config?.isVibrationEnabled ?? true;
  bool get isDarkModeEnabled => _config?.isDarkMode ?? false;
  int get timeLimit => _config?.timeLimit ?? 60;

  /// Loads game configuration
  Future<void> loadConfig() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _config = await getGameConfigUseCase.execute();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Toggles sound setting
  Future<void> toggleSound() async {
    if (_config == null) return;
    
    try {
      final newValue = !_config!.isSoundEnabled;
      await toggleSoundUseCase.execute(newValue);
      _config = GameConfigEntity(
        isSoundEnabled: newValue,
        isVibrationEnabled: _config!.isVibrationEnabled,
        isDarkMode: _config!.isDarkMode,
        timeLimit: _config!.timeLimit,
      );
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Toggles vibration setting
  Future<void> toggleVibration() async {
    if (_config == null) return;
    
    try {
      final newValue = !_config!.isVibrationEnabled;
      await toggleVibrationUseCase.execute(newValue);
      _config = GameConfigEntity(
        isSoundEnabled: _config!.isSoundEnabled,
        isVibrationEnabled: newValue,
        isDarkMode: _config!.isDarkMode,
        timeLimit: _config!.timeLimit,
      );
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Toggles dark mode setting
  Future<void> toggleDarkMode() async {
    if (_config == null) return;
    
    try {
      final newValue = !_config!.isDarkMode;
      await toggleDarkModeUseCase.execute(newValue);
      _config = GameConfigEntity(
        isSoundEnabled: _config!.isSoundEnabled,
        isVibrationEnabled: _config!.isVibrationEnabled,
        isDarkMode: newValue,
        timeLimit: _config!.timeLimit,
      );
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Updates entire configuration
  Future<void> updateConfig(GameConfigEntity newConfig) async {
    try {
      await updateGameConfigUseCase.execute(newConfig);
      _config = newConfig;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

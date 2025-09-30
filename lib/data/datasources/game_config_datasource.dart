import 'package:shared_preferences/shared_preferences.dart';

/// Data source for game configuration and settings
/// Clean Architecture: Data Layer - Data Sources
abstract class GameConfigDataSource {
  Future<bool> getSoundEnabled();
  Future<void> setSoundEnabled(bool enabled);
  
  Future<bool> getVibrationEnabled();
  Future<void> setVibrationEnabled(bool enabled);
  
  Future<bool> getDarkModeEnabled();
  Future<void> setDarkModeEnabled(bool enabled);
  
  Future<int> getTimeLimit();
  Future<void> setTimeLimit(int seconds);
}

/// Implementation using SharedPreferences
/// This bridges to the existing preference storage
class GameConfigDataSourceImpl implements GameConfigDataSource {
  final SharedPreferences sharedPreferences;

  // Keys used in existing code
  static const String _soundKey = 'com.tws.math_game_sound';
  static const String _vibrationKey = 'com.tws.math_game_vibration';
  static const String _darkModeKey = 'isDarkMode';
  static const String _timeLimitKey = 'time_limit';

  GameConfigDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getSoundEnabled() async {
    return sharedPreferences.getBool(_soundKey) ?? true;
  }

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    await sharedPreferences.setBool(_soundKey, enabled);
  }

  @override
  Future<bool> getVibrationEnabled() async {
    return sharedPreferences.getBool(_vibrationKey) ?? true;
  }

  @override
  Future<void> setVibrationEnabled(bool enabled) async {
    await sharedPreferences.setBool(_vibrationKey, enabled);
  }

  @override
  Future<bool> getDarkModeEnabled() async {
    return sharedPreferences.getBool(_darkModeKey) ?? false;
  }

  @override
  Future<void> setDarkModeEnabled(bool enabled) async {
    await sharedPreferences.setBool(_darkModeKey, enabled);
  }

  @override
  Future<int> getTimeLimit() async {
    return sharedPreferences.getInt(_timeLimitKey) ?? 60;
  }

  @override
  Future<void> setTimeLimit(int seconds) async {
    await sharedPreferences.setInt(_timeLimitKey, seconds);
  }
}

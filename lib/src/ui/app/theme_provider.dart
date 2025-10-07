import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

String lightFolder = 'assets/light/';
String darkFolder = 'assets/dark/';

/// Provider for managing the application's theme mode (light/dark).
/// Persists theme selection using SharedPreferences and syncs with global themeMode variable.
class ThemeProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeMode _themeMode = ThemeMode.light;

  /// Gets the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Initializes ThemeProvider and loads the saved theme mode.
  ThemeProvider({required this.sharedPreferences}) {
    _themeMode = ThemeMode.values[sharedPreferences.getInt(KeyUtil.IS_DARK_MODE) ?? 0];
    // Initialize the theme manager and sync with global state
    ThemeManager.initialize(_themeMode);
  }

  /// Changes the theme mode and saves the selection.
  void changeTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    // Update the theme manager
    ThemeManager.updateGlobalTheme(_themeMode);

    notifyListeners();
    await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, _themeMode.index);
  }

  /// Sets a specific theme mode
  void setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;

      // Update the theme manager
      ThemeManager.updateGlobalTheme(_themeMode);

      notifyListeners();
      await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, _themeMode.index);
    }
  }
}

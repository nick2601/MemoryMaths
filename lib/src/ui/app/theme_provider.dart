import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

String lightFolder = 'assets/light/';
String darkFolder = 'assets/dark/';
ThemeMode themeMode = ThemeMode.light;

/// Provider for managing the application's theme mode (light/dark).
/// Persists theme selection using SharedPreferences.
class ThemeProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  /// Initializes ThemeProvider and loads the saved theme mode.
  ThemeProvider({required this.sharedPreferences}) {
    themeMode =
        ThemeMode.values[sharedPreferences.getInt(KeyUtil.IS_DARK_MODE) ?? 1];
  }

  /// Changes the theme mode and saves the selection.
  void changeTheme() async {
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;

    notifyListeners();
    await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, themeMode.index);
  }
}

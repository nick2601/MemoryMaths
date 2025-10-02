import 'package:flutter/material.dart';

/// Global theme manager to handle theme synchronization
/// This provides a centralized way to manage theme state across the app
class ThemeManager {
  static ThemeMode _currentTheme = ThemeMode.light;

  /// Updates the global theme mode
  static void updateGlobalTheme(ThemeMode newTheme) {
    _currentTheme = newTheme;
  }

  /// Gets the current global theme mode
  static ThemeMode getCurrentTheme() {
    return _currentTheme;
  }

  /// Initializes the theme manager with the saved theme
  static void initialize(ThemeMode savedTheme) {
    _currentTheme = savedTheme;
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';

/// Theme wrapper utility to apply correct fonts and themes to different screen types
class ThemeWrapper {
  /// Wraps a widget with dyslexic-friendly theme for specific screens
  /// Used for: login, signup, dashboard, home, settings, report screens
  static Widget dyslexicScreen({
    required Widget child,
    required bool isDarkMode,
  }) {
    return Theme(
      data: isDarkMode ? DyslexicTheme.darkTheme : DyslexicTheme.lightTheme,
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: DyslexicTheme.dyslexicFont,
          fontSize: 16,
          color: isDarkMode ? Colors.white : DyslexicTheme.primaryTextColor,
        ),
        child: child,
      ),
    );
  }

  /// Wraps a widget with Montserrat theme for game screens
  /// Used for: all game screens and level view screens
  static Widget gameScreen({
    required Widget child,
    required bool isDarkMode,
  }) {
    return Theme(
      data: _buildMontserratTheme(isDarkMode),
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: isDarkMode ? Colors.white : Color(0xFF1A202C),
        ),
        child: child,
      ),
    );
  }

  /// Builds Montserrat theme for game screens using existing theme structure
  static ThemeData _buildMontserratTheme(bool isDarkMode) {
    if (isDarkMode) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF64B5F6),
          secondary: Color(0xFF81C784),
          surface: Color(0xFF121212),
          background: Color(0xFF121212),
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0xFF121212),
      );
    } else {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.light(
          primary: Color(0xFF1A365D),
          secondary: Color(0xFF3182CE),
          surface: Colors.white,
          background: Color(0xFFFAFAFA),
          onSurface: Color(0xFF1A202C),
          onBackground: Color(0xFF1A202C),
        ),
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
      );
    }
  }
}

/// Enum to identify screen types for theme application
enum ScreenType {
  /// Screens that should use dyslexic-friendly fonts: login, signup, dashboard, home, settings, report
  dyslexicFriendly,

  /// Screens that should use Montserrat fonts: game screens and level views
  game,
}

/// Extension to help identify screen type based on route name
extension ScreenTypeExtension on String {
  ScreenType get screenType {
    // Define which routes should use dyslexic fonts
    const dyslexicRoutes = [
      '/login',
      '/signup',
      '/dashboard',
      '/home',
      '/settings',
      '/reports',
      '/user-report',
      '/splash',
    ];

    // Check if current route should use dyslexic theme
    for (final route in dyslexicRoutes) {
      if (contains(route) || startsWith(route)) {
        return ScreenType.dyslexicFriendly;
      }
    }

    // All other routes (games, levels) use Montserrat
    return ScreenType.game;
  }
}

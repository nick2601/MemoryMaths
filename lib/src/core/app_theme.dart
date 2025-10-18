import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';

/// AppTheme defines the light and dark theme configurations for the application.
/// This class provides static getters for both theme variants with Material 3 support.
/// Different screens use different font families based on their purpose.
class AppTheme {
  /// Returns the dyslexic-friendly light theme configuration for specific screens
  /// Used for: login, signup, dashboard, home, settings, report screens
  static ThemeData get dyslexicLightTheme {
    return DyslexicTheme.lightTheme.copyWith(
      appBarTheme: DyslexicTheme.lightTheme.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  /// Returns the dyslexic-friendly dark theme configuration for specific screens
  /// Used for: login, signup, dashboard, home, settings, report screens
  static ThemeData get dyslexicDarkTheme {
    return DyslexicTheme.darkTheme.copyWith(
      appBarTheme: DyslexicTheme.darkTheme.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  /// Returns the Montserrat light theme configuration for game screens
  /// Used for: all game screens and level view screens
  static ThemeData get montserratLightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.light(
        primary: Color(0xFF1A365D),
        secondary: Color(0xFF3182CE),
        surface: Colors.white,
        onSurface: Color(0xFF1A202C),
      ),
      scaffoldBackgroundColor: Color(0xFFFAFAFA),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFFAFAFA),
        foregroundColor: Color(0xFF1A202C),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  /// Returns the Montserrat dark theme configuration for game screens
  /// Used for: all game screens and level view screens
  static ThemeData get montserratDarkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF64B5F6),
        secondary: Color(0xFF81C784),
        surface: Color(0xFF121212),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF121212),
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  // Keep backward compatibility - default to dyslexic theme
  static ThemeData get theme => dyslexicLightTheme;

  static ThemeData get darkTheme => dyslexicDarkTheme;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppTheme defines vibrant light and dark themes for the app.
/// Colors are inspired by playful puzzle/game palettes.
class AppTheme {
  /// Vibrant Light Theme
  static ThemeData get theme {
    final base = ThemeData.light();

    return base.copyWith(
      colorScheme: ColorScheme.light(
        primary: const Color(0xFFFF6B6B), // Coral Red
        secondary: const Color(0xFF4ECDC4), // Teal Mint
        surface: Colors.white,
        error: const Color(0xFFFF4C4C),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      cardColor: Colors.white,
      textTheme: base.textTheme
          .apply(
        fontFamily: 'Montserrat',
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      )
          .copyWith(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1D3557), // Deep Navy
        ),
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: Colors.grey.shade600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFF6B6B),
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar icons
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF4ECDC4),
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Vibrant Dark Theme
  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return base.copyWith(
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF00BFA6), // Teal Green
        secondary: const Color(0xFFFFC857), // Vibrant Yellow
        surface: const Color(0xFF2B2D42),
        background: const Color(0xFF1D1E2C),
        error: const Color(0xFFFF6B6B),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF1D1E2C),
      cardColor: const Color(0xFF2B2D42),
      textTheme: base.textTheme
          .apply(
        fontFamily: 'Montserrat',
        bodyColor: Colors.white,
        displayColor: Colors.white,
      )
          .copyWith(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFFC857), // Accent Yellow
        ),
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: Colors.grey.shade400,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF00BFA6),
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light, // Light status bar icons
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFFFC857),
        foregroundColor: Colors.black,
      ),
    );
  }
}
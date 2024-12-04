import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppTheme defines the light and dark theme configurations for the application.
/// This class provides static getters for both theme variants, ensuring consistent
/// styling throughout the app.
class AppTheme {
  /// Returns the light theme configuration for the application.
  ///
  /// This theme uses a light color palette with:
  /// - White-tinted background
  /// - Pure white cards
  /// - Custom text styling
  /// - Light brightness mode
  /// - Dark system overlay for status bar
  static ThemeData get theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: Colors.white70,
      cardColor: Colors.white,
      textTheme: base.textTheme.copyWith(
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: Color(0xff757575), // Medium grey color for small body text
        ),
      ),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar icons
      ),
    );
  }

  /// Returns the dark theme configuration for the application.
  ///
  /// This theme uses a dark color palette with:
  /// - Pure black background and surfaces
  /// - Custom text styling
  /// - Dark brightness mode
  /// - Light system overlay for status bar
  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      textTheme: base.textTheme.copyWith(
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: Color(0xff616161), // Darker grey color for small body text
        ),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle.light, // Light status bar icons
      ),
    );
  }
}

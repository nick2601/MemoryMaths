import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';

/// AppTheme defines the light and dark theme configurations for the application.
/// This class provides static getters for both theme variants with Material 3 and dyslexic-friendly design.
class AppTheme {
  /// Returns the light theme configuration using Material 3 with dyslexic-friendly settings
  static ThemeData get theme {
    return DyslexicTheme.lightTheme.copyWith(
      appBarTheme: DyslexicTheme.lightTheme.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar icons
      ),
    );
  }

  /// Returns the dark theme configuration using Material 3 with dyslexic-friendly settings
  static ThemeData get darkTheme {
    return DyslexicTheme.darkTheme.copyWith(
      appBarTheme: DyslexicTheme.darkTheme.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.light, // Light status bar icons
      ),
    );
  }
}

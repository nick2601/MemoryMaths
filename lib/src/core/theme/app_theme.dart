import 'package:flutter/material.dart';

class AppTheme1 {
  static ThemeData get lightTheme {
    return ThemeData(
      // ... existing theme properties ...
      fontFamily: 'OpenDyslexic',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        displayMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        displaySmall: TextStyle(fontFamily: 'OpenDyslexic'),
        headlineMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        headlineSmall: TextStyle(fontFamily: 'OpenDyslexic'),
        titleLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        bodyLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        bodyMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        bodySmall: TextStyle(fontFamily: 'OpenDyslexic'),
        labelLarge: TextStyle(fontFamily: 'OpenDyslexic'),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      // ... existing theme properties ...
      fontFamily: 'OpenDyslexic',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        displayMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        displaySmall: TextStyle(fontFamily: 'OpenDyslexic'),
        headlineMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        headlineSmall: TextStyle(fontFamily: 'OpenDyslexic'),
        titleLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        bodyLarge: TextStyle(fontFamily: 'OpenDyslexic'),
        bodyMedium: TextStyle(fontFamily: 'OpenDyslexic'),
        bodySmall: TextStyle(fontFamily: 'OpenDyslexic'),
        labelLarge: TextStyle(fontFamily: 'OpenDyslexic'),
      ),
    );
  }
}

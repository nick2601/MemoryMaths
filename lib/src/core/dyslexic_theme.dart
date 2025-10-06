import 'package:flutter/material.dart';

/// Dyslexic-friendly theme configuration with Material 3 integration
/// Based on research for optimal readability for users with dyslexia
class DyslexicTheme {
  // Primary colors - high contrast, avoiding problematic combinations
  static const primaryColor = Color(0xFF1A365D); // Deep blue-gray
  static const secondaryColor = Color(0xFF2D3748); // Dark gray
  static const accentColor = Color(0xFF3182CE); // Clear blue

  // Background colors - cream/off-white instead of pure white
  static const backgroundColor = Color(0xFFFDF6E3); // Warm cream
  static const surfaceColor = Color(0xFFF7FAFC); // Very light blue-gray
  static const cardColor = Color(0xFFFFFFFF); // Pure white for cards

  // Text colors - high contrast
  static const primaryTextColor = Color(0xFF1A202C); // Near black
  static const secondaryTextColor = Color(0xFF4A5568); // Medium gray
  static const hintTextColor = Color(0xFF718096); // Light gray

  // Input field colors
  static const inputBorderColor = Color(0xFFCBD5E0); // Light blue-gray
  static const inputFocusColor = Color(0xFF3182CE); // Clear blue
  static const inputFillColor = Color(0xFFFFFFFF); // White fill

  // Status colors - avoiding red/green confusion
  static const successColor = Color(0xFF2B6CB0); // Blue for success
  static const warningColor = Color(0xFFD69E2E); // Amber for warning
  static const errorColor = Color(0xFF9F2C2C); // Dark red for errors

  // Spacing and sizing for better readability
  static const double baseFontSize = 16.0;
  static const double headingFontSize = 24.0;
  static const double buttonHeight = 56.0;
  static const double inputHeight = 60.0;
  static const double borderRadius = 12.0;

  // Font families
  static const String dyslexicFont = 'OpenDyslexic';
  static const String regularFont = 'Montserrat';

  /// Get Material 3 light theme with dyslexic-friendly configurations
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: backgroundColor,
        surfaceContainerHighest: cardColor,
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
        onSurface: primaryTextColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      // Typography with dyslexic-friendly fonts
      textTheme: _buildTextTheme(Brightness.light),

      // Component themes
      appBarTheme: _buildAppBarTheme(Brightness.light),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      cardTheme: _buildCardTheme(),
      chipTheme: _buildChipTheme(),
      switchTheme: _buildSwitchTheme(),
      checkboxTheme: _buildCheckboxTheme(),
      radioTheme: _buildRadioTheme(),
      navigationBarTheme: _buildNavigationBarTheme(),
      bottomAppBarTheme: _buildBottomAppBarTheme(),
      floatingActionButtonTheme: _buildFABTheme(),

      // Scaffold configuration
      scaffoldBackgroundColor: backgroundColor,

      // Typography
      fontFamily: dyslexicFont,
    );
  }

  /// Get Material 3 dark theme with dyslexic-friendly configurations
  static ThemeData get darkTheme {
    const darkBackground = Color(0xFF0F1419);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: darkBackground,
        surfaceContainerHighest: Color(0xFF2A2F35),
        primary: Color(0xFF64B5F6),
        secondary: Color(0xFF81C784),
        error: Color(0xFFEF5350),
        onSurface: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
      ),

      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: _buildAppBarTheme(Brightness.dark),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      cardTheme: _buildCardTheme(),
      chipTheme: _buildChipTheme(),
      switchTheme: _buildSwitchTheme(),
      checkboxTheme: _buildCheckboxTheme(),
      radioTheme: _buildRadioTheme(),
      navigationBarTheme: _buildNavigationBarTheme(),
      bottomAppBarTheme: _buildBottomAppBarTheme(),
      floatingActionButtonTheme: _buildFABTheme(),

      scaffoldBackgroundColor: darkBackground,
      fontFamily: dyslexicFont,
    );
  }

  // Private helper methods for component themes
  static TextTheme _buildTextTheme(Brightness brightness) {
    final textColor = brightness == Brightness.light ? primaryTextColor : Colors.white;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: textColor,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme(Brightness brightness) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: brightness == Brightness.light ? primaryTextColor : Colors.white,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: TextStyle(
          fontSize: baseFontSize + 2,
          fontFamily: dyslexicFont,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: baseFontSize,
          fontFamily: dyslexicFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: TextStyle(
          fontSize: baseFontSize + 2,
          fontFamily: dyslexicFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: inputFillColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: inputBorderColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: inputBorderColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: inputFocusColor, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      labelStyle: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: baseFontSize,
      ),
    );
  }

  static CardThemeData _buildCardTheme() {
    return CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  static ChipThemeData _buildChipTheme() {
    return ChipThemeData(
      labelStyle: TextStyle(
        fontFamily: dyslexicFont,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  static SwitchThemeData _buildSwitchTheme() {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return null;
      }),
    );
  }

  static CheckboxThemeData _buildCheckboxTheme() {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static RadioThemeData _buildRadioTheme() {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return null;
      }),
    );
  }

  static NavigationBarThemeData _buildNavigationBarTheme() {
    return NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(
          fontFamily: dyslexicFont,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static BottomAppBarThemeData _buildBottomAppBarTheme() {
    return BottomAppBarThemeData(
      elevation: 8,
      shape: CircularNotchedRectangle(),
    );
  }

  static FloatingActionButtonThemeData _buildFABTheme() {
    return FloatingActionButtonThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

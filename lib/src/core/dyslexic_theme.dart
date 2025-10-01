import 'package:flutter/material.dart';

/// Dyslexic-friendly theme configuration for accessibility
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
}

/// InputDecoration theme optimized for dyslexic users
class DyslexicInputTheme {
  static InputDecoration getInputDecoration({
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: DyslexicTheme.secondaryTextColor)
        : null,
      suffixIcon: suffixIcon,

      // Enhanced styling for better visibility
      labelStyle: TextStyle(
        color: DyslexicTheme.secondaryTextColor,
        fontSize: DyslexicTheme.baseFontSize,
        fontFamily: DyslexicTheme.dyslexicFont,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: DyslexicTheme.hintTextColor,
        fontSize: DyslexicTheme.baseFontSize,
        fontFamily: DyslexicTheme.dyslexicFont,
      ),

      // Border styling - rounded corners, good contrast
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        borderSide: BorderSide(
          color: DyslexicTheme.inputBorderColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        borderSide: BorderSide(
          color: DyslexicTheme.inputBorderColor,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        borderSide: BorderSide(
          color: DyslexicTheme.inputFocusColor,
          width: 3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        borderSide: BorderSide(
          color: DyslexicTheme.errorColor,
          width: 2,
        ),
      ),

      // Fill and content padding
      filled: true,
      fillColor: DyslexicTheme.inputFillColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    );
  }

  static TextStyle getInputTextStyle() {
    return TextStyle(
      color: DyslexicTheme.primaryTextColor,
      fontSize: DyslexicTheme.baseFontSize,
      fontFamily: DyslexicTheme.dyslexicFont,
      fontWeight: FontWeight.w500,
      height: 1.4, // Better line spacing
    );
  }
}

/// Button theme optimized for dyslexic users
class DyslexicButtonTheme {
  static ButtonStyle getPrimaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: DyslexicTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: DyslexicTheme.primaryColor.withValues(alpha: 0.3),

      // Size and shape
      minimumSize: Size(double.infinity, DyslexicTheme.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
      ),

      // Text style
      textStyle: TextStyle(
        fontSize: DyslexicTheme.baseFontSize + 2,
        fontFamily: DyslexicTheme.dyslexicFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  static ButtonStyle getSecondaryButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: DyslexicTheme.accentColor,
      textStyle: TextStyle(
        fontSize: DyslexicTheme.baseFontSize,
        fontFamily: DyslexicTheme.dyslexicFont,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

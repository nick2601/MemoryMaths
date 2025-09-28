import 'package:flutter/material.dart';

/// Extension on [ColorScheme] that provides custom vibrant colors
/// for a playful, game-like app.
extension CustomColorScheme on ColorScheme {
  /// Base background color
  Color get baseColor =>
      brightness == Brightness.light ? const Color(0xFFFDF6F0) : const Color(0xFF1B1B2F);

  /// Semi-transparent base color
  Color get baseLightColor =>
      brightness == Brightness.light ? const Color(0xFFFFEEDD) : const Color(0xFF2E2E3A);

  /// Main contrasting color (text/icons on primary surfaces)
  Color get crossColor =>
      brightness == Brightness.light ? const Color(0xFF1D3557) : Colors.white;

  /// Lighter contrasting color for subtitles and hints
  Color get crossLightColor =>
      brightness == Brightness.light ? const Color(0xFF8D99AE) : Colors.white70;

  /// Divider lines
  Color get dividerColor =>
      brightness == Brightness.light ? const Color(0xFFFFC857) : const Color(0xFF4ECDC4);

  /// Card background
  Color get cardBgColor =>
      brightness == Brightness.light ? const Color(0xFFFFF3E0) : const Color(0xFF2C2C54);

  /// Icon card background
  Color get iconCardBgColor =>
      brightness == Brightness.light ? const Color(0xFFE0F7FA) : const Color(0xFF3A3A6A);

  /// Expanded toolbar
  Color get toolbarExpandedColor =>
      brightness == Brightness.light ? const Color(0xFFEDF6F9) : const Color(0xFF1F2235);

  /// Collapsed toolbar
  Color get toolbarCollapsedColor =>
      brightness == Brightness.light ? const Color(0xFFFFD6A5) : const Color(0xFF2C2C54);

  /// Standard dialog background
  Color get dialogBgColor =>
      brightness == Brightness.light ? const Color(0xFFFFFDF9) : const Color(0xFF24243E);

  /// Info dialog background
  Color get infoDialogBgColor =>
      brightness == Brightness.light ? const Color(0xFFE6F7FF) : const Color(0xFF1B2430);

  /// GIF dialog background
  Color get dialogGifBgColor =>
      brightness == Brightness.light ? const Color(0xFFFDE2E4) : const Color(0xFF3D2C8D);

  /// Triangle lines / borders
  Color get triangleLineColor =>
      brightness == Brightness.light ? const Color(0xFFBDE0FE) : const Color(0xFF5E60CE);

  /// Progress indicator (unselected)
  Color get unSelectedProgressColor =>
      brightness == Brightness.light ? const Color(0xFFFFC8DD) : const Color(0xFF6A4C93);
}
import 'package:flutter/material.dart';

/// Extension on [ColorScheme] that provides custom colors for light and dark themes.
/// Each getter returns a different color based on the current brightness setting.
extension CustomColorScheme on ColorScheme {
  /// Base background color: white for light theme, black for dark theme
  Color get baseColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;

  /// Semi-transparent base color: white60 for light theme, black54 for dark theme
  Color get baseLightColor =>
      brightness == Brightness.light ? Colors.white60 : Colors.black54;

  /// Contrasting color: black for light theme, white for dark theme
  /// Typically used for text and icons that need to stand out against baseColor
  Color get crossColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  /// Light contrasting color: light grey for light theme, semi-transparent white for dark theme
  Color get crossLightColor =>
      brightness == Brightness.light ? Color(0xffcdcdcd) : Colors.white60;

  /// Color used for dividers and separators
  Color get dividerColor =>
      brightness == Brightness.light ? Color(0xFFeeeeee) : Color(0xFFeeeeee);

  /// Background color for cards
  Color get cardBgColor =>
      brightness == Brightness.light ? Color(0xffF5F5F5) : Color(0xff212121);

  /// Background color for cards containing icons
  Color get iconCardBgColor =>
      brightness == Brightness.light ? Color(0xffF5F5F5) : Colors.black;

  /// Color for expanded toolbar state
  Color get toolbarExpandedColor =>
      brightness == Brightness.light ? Color(0xFFffffff) : Color(0xFF000000);

  /// Color for collapsed toolbar state
  Color get toolbarCollapsedColor =>
      brightness == Brightness.light ? Color(0xFFffffff) : Color(0xFF212121);

  /// Background color for standard dialogs
  Color get dialogBgColor =>
      brightness == Brightness.light ? Colors.white : Color(0xff212121);

  /// Background color for information dialogs
  Color get infoDialogBgColor =>
      brightness == Brightness.light ? Color(0xFFf7f7f7) : Color(0xff212121);

  /// Background color for dialogs containing GIFs
  Color get dialogGifBgColor =>
      brightness == Brightness.light ? Colors.white : Color(0xff424242);

  /// Color for triangle lines or borders
  Color get triangleLineColor =>
      brightness == Brightness.light ? Color(0xffeeeeee) : Color(0xff424242);

  /// Color for unselected progress indicators
  Color get unSelectedProgressColor => brightness == Brightness.light
      ? Colors.grey.shade100
      : Colors.grey.shade700;
}

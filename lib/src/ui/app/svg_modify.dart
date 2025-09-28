import 'package:flutter/material.dart';

class SvgModify {
  /// Converts a [Color] to hex string usable in SVG (#RRGGBB).
  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Returns a modified SVG string with dynamic color replacement.
  /// - [color] → main accent color (replaces #FCBB10).
  /// - [forceWhite] → if true, replaces black strokes with white.
  /// - [isDark] → if true, applies dark theme adjustments.
  static String hintSvg(Color color, {bool forceWhite = false, bool isDark = false}) {
    const rawSvg = """
<svg width="20" height="20" viewBox="0 0 20 20" fill="none"
     xmlns="http://www.w3.org/2000/svg">
  <path d="M11.5431 15.8285H8.45565C8.42756 14.7077 ..." stroke="black" stroke-width="1.2"/>
  <path d="M10.2147 2.5C10.2147 2.61835 ..." stroke="#FCBB10"/>
  <!-- other paths -->
</svg>
""";

    // Replace accent color
    String svg = rawSvg.replaceAll("#FCBB10", _colorToHex(color));

    // Handle black/white stroke adjustments
    if (forceWhite || isDark) {
      svg = svg.replaceAll('stroke="black"', 'stroke="white"');
      svg = svg.replaceAll('fill="black"', 'fill="white"');
    }

    return svg;
  }
}
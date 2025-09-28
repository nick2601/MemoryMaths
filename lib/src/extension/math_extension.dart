/// Extension on [double] providing utility methods for
/// mathematical operations and value transformations,
/// commonly used in UI animations & scroll effects.
extension MathExtension on double {
  /// Remaps a number from one range to another.
  ///
  /// Example:
  /// ```dart
  /// 0.5.remap(0, 1, 0, 100) // returns 50
  /// ```
  double remap(double from1, double to1, double from2, double to2) {
    assert(from1 != to1, 'remap: input range cannot be zero');
    return (this - from1) / (to1 - from1) * (to2 - from2) + from2;
  }

  /// Normalizes a value into a range [0,1].
  ///
  /// Commonly used in scroll-based calculations.
  double toRange(double maxExtent, double minExtent) {
    assert(maxExtent != minExtent, 'toRange: range cannot be zero');
    final maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - this) / maxScrollAllowed)
        .clamp(0.0, 1.0);
  }

  /// Inverts the result of [toRange].
  double toReverseRange(double maxExtent, double minExtent) =>
      1 - toRange(maxExtent, minExtent);

  /// Calculates an elevation value based on scroll position.
  double toElevation(
      double maxExtent,
      double minExtent,
      double after,
      double elevation,
      ) {
    if (this < after) return 0;
    return elevation *
        (this - after).toReverseRange(maxExtent, minExtent);
  }

  /// Calculates a radius value based on scroll position.
  double toRadius(
      double maxExtent,
      double minExtent,
      double after,
      double radius,
      ) {
    if (this < after) return 0;
    return radius *
        (this - after).toReverseRange(maxExtent, minExtent);
  }

  /// Maps scroll position to a text size between [from] and [to].
  double toTextSize(
      double maxExtent,
      double minExtent,
      double from,
      double to,
      ) =>
      toRange(maxExtent, minExtent).remap(0, 1, from, to);
}
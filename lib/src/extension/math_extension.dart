/// Extension on [double] providing utility methods for mathematical operations
/// and value transformations commonly used in UI calculations.
extension MathExtension on double {
  /// Remaps a number from one range to another.
  ///
  /// Maps this value from the range [from1]-[to1] to the range [from2]-[to2].
  /// Useful for converting between different numeric ranges while maintaining proportions.
  ///
  /// Example:
  /// ```dart
  /// 0.5.remap(0, 1, 0, 100) // returns 50
  /// ```
  double remap(double from1, double to1, double from2, double to2) {
    return (this - from1) / (to1 - from1) * (to2 - from2) + from2;
  }

  /// Converts a value to a normalized range between 0 and 1.
  ///
  /// Uses [maxExtent] and [minExtent] to calculate the range.
  /// Commonly used in scroll calculations where values need to be normalized.
  double toRange(double maxExtent, double minExtent) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - this) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  /// Inverts the result of [toRange].
  ///
  /// Returns a value between 0 and 1, where 1 represents [minExtent]
  /// and 0 represents [maxExtent].
  double toReverseRange(double maxExtent, double minExtent) {
    return 1 - toRange(maxExtent, minExtent);
  }

  /// Calculates an elevation value based on scroll position.
  ///
  /// Returns 0 if the current value is less than [after],
  /// otherwise returns a proportional value of [elevation] based on the scroll position.
  ///
  /// Parameters:
  /// - [maxExtent]: The maximum extent of the scroll
  /// - [minExtent]: The minimum extent of the scroll
  /// - [after]: The threshold value after which elevation starts
  /// - [elevation]: The maximum elevation value
  double toElevation(
      double maxExtent, double minExtent, double after, double elevation) {
    if (this < after)
      return 0;
    else
      return elevation * (this - after).toReverseRange(maxExtent, minExtent);
  }

  /// Calculates a radius value based on scroll position.
  ///
  /// Returns 0 if the current value is less than [after],
  /// otherwise returns a proportional value of [radius] based on the scroll position.
  ///
  /// Parameters:
  /// - [maxExtent]: The maximum extent of the scroll
  /// - [minExtent]: The minimum extent of the scroll
  /// - [after]: The threshold value after which radius starts
  /// - [radius]: The maximum radius value
  double toRadius(
      double maxExtent, double minExtent, double after, double radius) {
    if (this < after)
      return 0;
    else
      return radius * (this - after).toReverseRange(maxExtent, minExtent);
  }

  /// Calculates a text size value based on scroll position.
  ///
  /// Maps the scroll position to a text size between [from] and [to].
  ///
  /// Parameters:
  /// - [maxExtent]: The maximum extent of the scroll
  /// - [minExtent]: The minimum extent of the scroll
  /// - [from]: The minimum text size
  /// - [to]: The maximum text size
  double toTextSize(
      double maxExtent, double minExtent, double from, double to) {
    return this.toRange(maxExtent, minExtent).remap(0, 1, from, to);
  }
}

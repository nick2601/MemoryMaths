import 'package:hive/hive.dart';

part 'magic_triangle.g.dart';

/// Model class representing a magic triangle puzzle.
/// Players arrange numbers to make all sides sum to the target value.
@HiveType(typeId: 10) // ⚡ ensure unique typeId
class MagicTriangle {
  /// Whether this is a 3x3 triangle (false = 4x4)
  bool get is3x3 => listGrid.length == 6;

  /// List of available numbers to place
  @HiveField(0)
  final List<MagicTriangleGrid> listGrid;

  /// List of triangle positions where numbers can be placed
  @HiveField(1)
  final List<MagicTriangleInput> listTriangle;

  /// Target sum that each side should equal
  @HiveField(2)
  final int answer;

  /// Number of digits still available to place
  int get availableDigit => listGrid.where((g) => g.isVisible).length;

  MagicTriangle({
    required this.listGrid,
    required this.listTriangle,
    required this.answer,
  });

  /// Checks if the current arrangement forms a valid solution.
  /// Returns true if all sides equal the target [answer].
  bool checkTotal() {
    if (is3x3) {
      final sumOfLeftSide =
          (listTriangle[0].value ?? 0) + (listTriangle[1].value ?? 0) + (listTriangle[3].value ?? 0);
      final sumOfRightSide =
          (listTriangle[0].value ?? 0) + (listTriangle[2].value ?? 0) + (listTriangle[5].value ?? 0);
      final sumOfBottomSide =
          (listTriangle[3].value ?? 0) + (listTriangle[4].value ?? 0) + (listTriangle[5].value ?? 0);

      return answer == sumOfLeftSide &&
          answer == sumOfRightSide &&
          answer == sumOfBottomSide;
    } else {
      final sumOfLeftSide =
          (listTriangle[0].value ?? 0) + (listTriangle[1].value ?? 0) + (listTriangle[3].value ?? 0) + (listTriangle[5].value ?? 0);
      final sumOfRightSide =
          (listTriangle[0].value ?? 0) + (listTriangle[2].value ?? 0) + (listTriangle[4].value ?? 0) + (listTriangle[8].value ?? 0);
      final sumOfBottomSide =
          (listTriangle[5].value ?? 0) + (listTriangle[6].value ?? 0) + (listTriangle[7].value ?? 0) + (listTriangle[8].value ?? 0);

      return answer == sumOfLeftSide &&
          answer == sumOfRightSide &&
          answer == sumOfBottomSide;
    }
  }
}

/// Represents an available number in the grid.
@HiveType(typeId: 11)
class MagicTriangleGrid {
  /// The numerical value
  @HiveField(0)
  final int value;

  /// Whether this number is still visible/available
  @HiveField(1)
  bool isVisible;

  MagicTriangleGrid(this.value, this.isVisible);
}

/// Represents a position in the triangle where numbers can be placed.
@HiveType(typeId: 12)
class MagicTriangleInput {
  /// Whether this position is currently selected
  @HiveField(0)
  bool isActive;

  /// The number placed in this position (null if none)
  @HiveField(1)
  int? value;

  MagicTriangleInput(this.isActive, this.value);
}
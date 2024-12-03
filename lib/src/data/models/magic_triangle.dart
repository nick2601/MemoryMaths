/// Model class representing a magic triangle puzzle.
/// Players arrange numbers to make all sides sum to the target value.
class MagicTriangle {
  /// Whether this is a 3x3 triangle (false for 4x4)
  late bool is3x3;

  /// List of available numbers to place
  List<MagicTriangleGrid> listGrid;

  /// List of triangle positions where numbers can be placed
  List<MagicTriangleInput> listTriangle;

  /// Number of digits still available to place
  late int availableDigit;

  /// Target sum that each side should equal
  int answer;

  /// Creates a new MagicTriangle instance.
  ///
  /// Parameters:
  /// - [listGrid]: Available numbers
  /// - [listTriangle]: Triangle positions
  /// - [answer]: Target sum for each side
  MagicTriangle({
    required this.listGrid,
    required this.listTriangle,
    required this.answer,
  }) {
    this.availableDigit = listGrid.length;
    this.is3x3 = listGrid.length == 6 ? true : false;
  }

  /// Checks if the current arrangement forms a valid solution.
  /// Verifies that all sides sum to the target answer.
  ///
  /// Returns true if the triangle is solved correctly.
  bool checkTotal() {
    if (is3x3) {
      int sumOfLeftSide = (int.parse(listTriangle[0].value) +
          int.parse(listTriangle[1].value) +
          int.parse(listTriangle[3].value));
      int sumOfRightSide = (int.parse(listTriangle[0].value) +
          int.parse(listTriangle[2].value) +
          int.parse(listTriangle[5].value));
      int sumOfBottomSide = (int.parse(listTriangle[3].value) +
          int.parse(listTriangle[4].value) +
          int.parse(listTriangle[5].value));
      if (answer == sumOfLeftSide &&
          answer == sumOfRightSide &&
          answer == sumOfBottomSide) {
        return true;
      } else {
        return false;
      }
    } else {
      int sumOfLeftSide = (int.parse(listTriangle[0].value) +
          int.parse(listTriangle[1].value) +
          int.parse(listTriangle[3].value) +
          int.parse(listTriangle[5].value));
      int sumOfRightSide = (int.parse(listTriangle[0].value) +
          int.parse(listTriangle[2].value) +
          int.parse(listTriangle[4].value) +
          int.parse(listTriangle[8].value));
      int sumOfBottomSide = (int.parse(listTriangle[5].value) +
          int.parse(listTriangle[6].value) +
          int.parse(listTriangle[7].value) +
          int.parse(listTriangle[8].value));
      if (answer == sumOfLeftSide &&
          answer == sumOfRightSide &&
          answer == sumOfBottomSide) {
        return true;
      } else {
        return false;
      }
    }
  }
}

/// Model class representing an available number in the grid.
class MagicTriangleGrid {
  /// The numerical value
  String value;

  /// Whether this number is still visible/available
  bool isVisible;

  /// Creates a new MagicTriangleGrid instance.
  MagicTriangleGrid(this.value, this.isVisible);
}

/// Model class representing a position in the triangle where numbers can be placed.
class MagicTriangleInput {
  /// Whether this position is currently selected
  bool isActive;

  /// The number placed in this position (empty if none)
  String value;

  /// Creates a new MagicTriangleInput instance.
  MagicTriangleInput(this.isActive, this.value);
}

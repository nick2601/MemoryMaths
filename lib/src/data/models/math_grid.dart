import 'dart:math';

/// Model class representing a mathematical grid game.
/// Players select cells to reach a target sum.
class MathGrid {
  /// List of all cells in the grid
  List<MathGridCellModel> listForSquare;

  /// The target sum players need to achieve
  late int currentAnswer;

  /// Creates a new MathGrid instance.
  ///
  /// Parameters:
  /// - [listForSquare]: List of cells in the grid
  MathGrid({
    required this.listForSquare,
  }) {
    currentAnswer = getNewAnswer();
  }

  /// Generates a new target answer based on available cells.
  /// Randomly selects 3-6 non-removed cells and sums their values.
  ///
  /// Returns the new target sum for players to achieve.
  int getNewAnswer() {
    List<MathGridCellModel> list = listForSquare
        .where((element) => !element.isRemoved)
        .toList()
      ..shuffle();
    int noOfDigit = 3 + Random().nextInt(4);
    if (noOfDigit > list.length) {
      return list.map((e) {
        return e.value;
      }).fold(0, (previousValue, element) => previousValue + element);
    } else {
      return list.take(noOfDigit).map((e) {
        return e.value;
      }).fold(0, (previousValue, element) => previousValue + element);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathGrid &&
          runtimeType == other.runtimeType &&
          listForSquare == other.listForSquare &&
          currentAnswer == other.currentAnswer;

  @override
  int get hashCode => currentAnswer.hashCode;

  @override
  String toString() {
    return 'MathGrid{listOfAnswer: currentAnswer: $currentAnswer}';
  }
}

/// Model class representing a single cell in the math grid.
/// Contains the cell's value and state information.
class MathGridCellModel {
  /// Position index in the grid
  int index;

  /// Numerical value of the cell
  int value;

  /// Whether the cell is currently selected
  bool isActive;

  /// Whether the cell has been removed from play
  bool isRemoved;

  /// Creates a new MathGridCellModel instance.
  ///
  /// Parameters:
  /// - [index]: Cell's position in grid
  /// - [value]: Numerical value
  /// - [isActive]: Initial selection state
  /// - [isRemoved]: Whether cell is removed
  MathGridCellModel(this.index, this.value, this.isActive, this.isRemoved);
}

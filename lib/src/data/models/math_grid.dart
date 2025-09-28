import 'dart:math';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'math_grid.g.dart';

/// Model class representing a mathematical grid game.
/// Players select cells to reach a target sum.
@HiveType(typeId: 20)
class MathGrid {
  /// List of all cells in the grid
  @HiveField(0)
  final List<MathGridCellModel> listForSquare;

  /// The current target sum players need to achieve
  @HiveField(1)
  final int currentAnswer;

  /// Creates a new MathGrid instance.
  ///
  /// - [listForSquare]: List of cells in the grid
  /// - [currentAnswer]: Optional override (useful when restoring from Hive/JSON)
  MathGrid({
    required this.listForSquare,
    int? currentAnswer,
  }) : currentAnswer = currentAnswer ?? _generateNewAnswer(listForSquare);

  /// Generates a new target answer based on available cells.
  /// Randomly selects 3–6 non-removed cells and sums their values.
  static int _generateNewAnswer(List<MathGridCellModel> cells) {
    final available = cells.where((c) => !c.isRemoved).toList()..shuffle();
    final count = min(available.length, 3 + Random().nextInt(4));

    return available.take(count).fold(0, (sum, cell) => sum + cell.value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MathGrid &&
              const DeepCollectionEquality().equals(listForSquare, other.listForSquare) &&
              currentAnswer == other.currentAnswer;

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(listForSquare) ^ currentAnswer.hashCode;

  @override
  String toString() =>
      'MathGrid(currentAnswer: $currentAnswer, cells: $listForSquare)';
}

/// Model class representing a single cell in the math grid.
/// Contains the cell's value and state information.
@HiveType(typeId: 21)
class MathGridCellModel {
  /// Position index in the grid
  @HiveField(0)
  final int index;

  /// Numerical value of the cell
  @HiveField(1)
  final int value;

  /// Whether the cell is currently selected
  @HiveField(2)
  final bool isActive;

  /// Whether the cell has been removed from play
  @HiveField(3)
  final bool isRemoved;

  MathGridCellModel({
    required this.index,
    required this.value,
    this.isActive = false,
    this.isRemoved = false,
  });

  MathGridCellModel copyWith({
    int? index,
    int? value,
    bool? isActive,
    bool? isRemoved,
  }) {
    return MathGridCellModel(
      index: index ?? this.index,
      value: value ?? this.value,
      isActive: isActive ?? this.isActive,
      isRemoved: isRemoved ?? this.isRemoved,
    );
  }

  @override
  String toString() =>
      'Cell(index: $index, value: $value, isActive: $isActive, isRemoved: $isRemoved)';
}
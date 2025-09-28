import 'package:hive/hive.dart';

part 'number_pyramid.g.dart';

/// Model class representing a Number Pyramid puzzle.
/// Each pyramid has an ID, list of cells, and remaining unsolved cells.
@HiveType(typeId: 40)
class NumberPyramid {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<NumPyramidCellModel> list;

  @HiveField(2)
  final int remainingCell;

  const NumberPyramid({
    required this.id,
    required this.list,
    required this.remainingCell,
  });

  /// Copy with modified fields
  NumberPyramid copyWith({
    int? id,
    List<NumPyramidCellModel>? list,
    int? remainingCell,
  }) {
    return NumberPyramid(
      id: id ?? this.id,
      list: list ?? this.list,
      remainingCell: remainingCell ?? this.remainingCell,
    );
  }

  @override
  String toString() =>
      'NumberPyramid(id: $id, remainingCell: $remainingCell, list: $list)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NumberPyramid &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              list == other.list &&
              remainingCell == other.remainingCell;

  @override
  int get hashCode => id.hashCode ^ list.hashCode ^ remainingCell.hashCode;
}

/// Model class representing a single cell in the Number Pyramid puzzle.
@HiveType(typeId: 41)
class NumPyramidCellModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int numberOnCell;

  @HiveField(3)
  final bool isActive;

  @HiveField(4)
  final bool isCorrect;

  @HiveField(5)
  final bool isHidden;

  @HiveField(6)
  final bool isHint;

  @HiveField(7)
  final bool isDone;

  const NumPyramidCellModel({
    required this.id,
    required this.text,
    required this.numberOnCell,
    this.isActive = false,
    this.isCorrect = false,
    this.isHidden = false,
    this.isHint = false,
    this.isDone = false,
  });

  /// Copy with modified fields
  NumPyramidCellModel copyWith({
    int? id,
    String? text,
    int? numberOnCell,
    bool? isActive,
    bool? isCorrect,
    bool? isHidden,
    bool? isHint,
    bool? isDone,
  }) {
    return NumPyramidCellModel(
      id: id ?? this.id,
      text: text ?? this.text,
      numberOnCell: numberOnCell ?? this.numberOnCell,
      isActive: isActive ?? this.isActive,
      isCorrect: isCorrect ?? this.isCorrect,
      isHidden: isHidden ?? this.isHidden,
      isHint: isHint ?? this.isHint,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() =>
      'NumPyramidCellModel(id: $id, text: $text, value: $numberOnCell, '
          'active: $isActive, correct: $isCorrect, hidden: $isHidden, '
          'hint: $isHint, done: $isDone)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NumPyramidCellModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              text == other.text;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ numberOnCell.hashCode;
}
import 'package:hive/hive.dart';

part 'picture_puzzle.g.dart';

/// Defines the type of item in the picture puzzle
@HiveType(typeId: 50)
enum PicturePuzzleQuestionItemType {
  @HiveField(0) shape,
  @HiveField(1) sign,
  @HiveField(2) hint,
  @HiveField(3) answer,
}

/// Defines the available shape types
@HiveType(typeId: 51)
enum PicturePuzzleShapeType {
  @HiveField(0) circle,
  @HiveField(1) square,
  @HiveField(2) triangle,
}

/// Model representing an entire picture puzzle
@HiveType(typeId: 52)
class PicturePuzzle {
  @HiveField(0)
  final List<PicturePuzzleShapeList> list;

  @HiveField(1)
  final int answer;

  const PicturePuzzle({
    required this.list,
    required this.answer,
  });

  PicturePuzzle copyWith({
    List<PicturePuzzleShapeList>? list,
    int? answer,
  }) =>
      PicturePuzzle(
        list: list ?? this.list,
        answer: answer ?? this.answer,
      );

  @override
  String toString() => 'PicturePuzzle(answer: $answer, list: $list)';
}

/// A row or group of shapes in the puzzle
@HiveType(typeId: 53)
class PicturePuzzleShapeList {
  @HiveField(0)
  final List<PicturePuzzleShape> shapeList;

  const PicturePuzzleShapeList(this.shapeList);

  @override
  String toString() => 'PicturePuzzleShapeList(shapeList: $shapeList)';
}

/// Individual shape or symbol in the puzzle
@HiveType(typeId: 54)
class PicturePuzzleShape {
  @HiveField(0)
  final PicturePuzzleShapeType? shapeType;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final PicturePuzzleQuestionItemType type;

  const PicturePuzzleShape({
    this.shapeType,
    required this.text,
    required this.type,
  });

  @override
  String toString() =>
      'PicturePuzzleShape(type: $type, shapeType: $shapeType, text: $text)';
}

/// Data structure for combining shapes and operators in a puzzle equation

@HiveType(typeId: 55)
class PicturePuzzleData {
  @HiveField(0)
  final PicturePuzzleShapeType shapeType1;

  @HiveField(1)
  final String sign1;

  @HiveField(2)
  final PicturePuzzleShapeType shapeType2;

  @HiveField(3)
  final String sign2;

  @HiveField(4)
  final PicturePuzzleShapeType shapeType3;

  @HiveField(5)
  final String text;

  const PicturePuzzleData(
      this.shapeType1,
      this.sign1,
      this.shapeType2,
      this.sign2,
      this.shapeType3,
      this.text,
      );

  PicturePuzzleShapeType get picturePuzzleShapeType1 => shapeType1;
  PicturePuzzleShapeType get picturePuzzleShapeType2 => shapeType2;
  PicturePuzzleShapeType get picturePuzzleShapeType3 => shapeType3;

  @override
  String toString() =>
      'PicturePuzzleData($shapeType1 $sign1 $shapeType2 $sign2 $shapeType3 = $text)';
}

import 'package:hive/hive.dart';

part 'magic_triangle.g.dart';

@HiveType(typeId: 10)
class MagicTriangle {
  bool get is3x3 => listGrid.length == 6;

  @HiveField(0)
  final List<MagicTriangleGrid> listGrid;

  @HiveField(1)
  final List<MagicTriangleInput> listTriangle;

  @HiveField(2)
  final int answer;

  @HiveField(3)
  int? availableDigit;

  MagicTriangle({
    required this.listGrid,
    required this.listTriangle,
    required this.answer,
  }) {
    availableDigit = listGrid.where((g) => g.isVisible).length;
  }

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

@HiveType(typeId: 11)
class MagicTriangleGrid {
  @HiveField(0)
  final int value;

  @HiveField(1)
  bool isVisible;

  MagicTriangleGrid(this.value, this.isVisible);
}

@HiveType(typeId: 12)
class MagicTriangleInput {
  @HiveField(0)
  bool isActive;

  @HiveField(1)
  int? value;

  MagicTriangleInput(this.isActive, this.value);
}

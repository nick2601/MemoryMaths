import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class that manages picture puzzle data and generation
/// This class creates mathematical puzzles using shapes and operators
class PicturePuzzleRepository {
  /// Keeps track of previously generated puzzle codes to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of picture puzzles for a given level
  /// [level] determines the difficulty and complexity of the puzzles
  /// Returns a list of 5 [PicturePuzzle] objects
  static getPicturePuzzleDataList(int level) {
    // Reset hash codes when starting level 1
    if (level == 1) {
      listHasCode.clear();
    }

    List<PicturePuzzle> list = <PicturePuzzle>[];
    while (list.length < 5) {
      List<PicturePuzzleShapeList> puzzleList = <PicturePuzzleShapeList>[];
      List<PicturePuzzleData> picturePuzzleDataList =
          getNewShapeMatrix(level, list.length);

      picturePuzzleDataList
          .asMap()
          .forEach((int i, PicturePuzzleData picturePuzzleData) {
        puzzleList.add(PicturePuzzleShapeList([
          PicturePuzzleShape(
            picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType1,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: picturePuzzleData.sign1,
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType2,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: picturePuzzleData.sign2,
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType3,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: "=",
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            text: i == picturePuzzleDataList.length - 1
                ? "?"
                : picturePuzzleData.text,
            type: i == picturePuzzleDataList.length - 1
                ? PicturePuzzleQuestionItemType.answer
                : PicturePuzzleQuestionItemType.hint,
          )
        ]));
      });

      list.add(PicturePuzzle(
          puzzleList, int.parse(picturePuzzleDataList.last.text)));
    }
    return list;
  }

  /// Creates a matrix of shape-based mathematical expressions
  /// [level] determines the difficulty of calculations
  /// [index] determines the pattern of operators used
  static List<PicturePuzzleData> getNewShapeMatrix(int level, int index) {
    List<PicturePuzzleData> list = <PicturePuzzleData>[];
    List<String> listDigit = <String>[];
    List<String> listSign = <String>[];

    // Initialize available shapes and shuffle them
    List<PicturePuzzleShapeType> listShape = [
      PicturePuzzleShapeType.CIRCLE,
      PicturePuzzleShapeType.TRIANGLE,
      PicturePuzzleShapeType.SQUARE
    ]..shuffle();

    // Level 1 has specific patterns based on index
    if (level == 1) {
      switch (index) {
        case 0:
        case 1:
          // Simple addition patterns
          listSign = ["+", "+", "+"];
          while (listDigit.length < 3) {
            MathUtil.generateRandomNumber(1, 10, 3).forEach((digit) {
              if (!listDigit.contains(digit)) {
                listDigit.add(digit);
              }
            });
          }
          list.add(getRowFirst(
              listShape[0], listSign[0], listSign[1], listDigit[0]));
          list.add(getRowSecond(listShape[0], listSign[0], listShape[1],
              listSign[0], listDigit[0], listDigit[1], listDigit[2]));
          list.add(getRowThird(listSign[0], listShape[1], listSign[2],
              listShape[2], listDigit[0], listDigit[1], listDigit[2]));
          list.add(getRowLast(
              listShape[0],
              listSign[0],
              listShape[1],
              listSign[1],
              listShape[2],
              listDigit[0],
              listDigit[1],
              listDigit[2]));
          break;

        case 2:
        case 3:
        case 4:
          // Mixed operator patterns
          listSign = ["+", "-", "*"]
            ..shuffle()
            ..removeAt(1);

          while (listDigit.length < 3) {
            MathUtil.generateRandomNumber(level, 10 + level, 3)
                .forEach((digit) {
              if (!listDigit.contains(digit)) {
                listDigit.add(digit);
              }
            });
          }
          list.add(getRowFirst(listShape[0], "+", "+", listDigit[0]));
          list.add(getRowSecond(listShape[0], listSign[0], listShape[1], "+",
              listDigit[0], listDigit[1], listDigit[2]));
          list.add(getRowThird(listSign[0], listShape[1], "-", listShape[2],
              listDigit[0], listDigit[1], listDigit[2]));
          list.add(getRowLast(listShape[0], "+", listShape[1], "+",
              listShape[2], listDigit[0], listDigit[1], listDigit[2]));
          break;
      }
    } else {
      // Higher levels use random operators and larger numbers
      while (listDigit.length < 3) {
        MathUtil.generateRandomNumber(level, 10 + level, 3).forEach((digit) {
          if (!listDigit.contains(digit)) {
            listDigit.add(digit);
          }
        });
      }
      listSign = ["+", "-", "*"]..shuffle();
      list.add(
          getRowFirst(listShape[0], listSign[0], listSign[2], listDigit[0]));
      list.add(getRowSecond(listShape[0], listSign[0], listShape[1], "+",
          listDigit[0], listDigit[1], listDigit[2]));
      list.add(getRowThird(listSign[0], listShape[1], "-", listShape[2],
          listDigit[0], listDigit[1], listDigit[2]));
      list.add(getRowLast(listShape[0], listSign[0], listShape[1], listSign[1],
          listShape[2], listDigit[0], listDigit[1], listDigit[2]));
    }
    return list;
  }

  /// Generates the first row of the puzzle matrix
  /// Uses the same shape with different operators
  static PicturePuzzleData getRowFirst(
      PicturePuzzleShapeType picturePuzzleShapeType1,
      String sign1,
      String sign2,
      String op1) {
    return PicturePuzzleData(
        picturePuzzleShapeType1,
        sign1,
        picturePuzzleShapeType1,
        sign2,
        picturePuzzleShapeType1,
        getResult(op1, sign1, op1, sign2, op1));
  }

  /// Generates the second row of the puzzle matrix
  /// Introduces a second shape type
  static PicturePuzzleData getRowSecond(
      PicturePuzzleShapeType picturePuzzleShapeType1,
      String sign1,
      PicturePuzzleShapeType picturePuzzleShapeType2,
      String sign2,
      String op1,
      String op2,
      String op3) {
    // Adjust operators to avoid invalid combinations
    if ((sign1 == "-" && sign2 == "+") || sign1 == "+" && sign2 == "-") {
      sign1 = "*";
    }
    return PicturePuzzleData(
        picturePuzzleShapeType1,
        sign1,
        picturePuzzleShapeType2,
        sign2,
        picturePuzzleShapeType2,
        getResult(op1, sign1, op2, sign2, op2));
  }

  /// Generates the third row of the puzzle matrix
  /// Introduces a third shape type
  static PicturePuzzleData getRowThird(
      String sign1,
      PicturePuzzleShapeType picturePuzzleShapeType2,
      String sign2,
      PicturePuzzleShapeType picturePuzzleShapeType3,
      String op1,
      String op2,
      String op3) {
    if ((sign1 == "-" && sign2 == "+") || sign1 == "+" && sign2 == "-") {
      sign2 = "*";
    }

    return PicturePuzzleData(
        picturePuzzleShapeType2,
        sign1,
        picturePuzzleShapeType3,
        sign2,
        picturePuzzleShapeType3,
        getResult(op2, sign1, op3, sign2, op3));
  }

  /// Generates the final row of the puzzle matrix
  /// This row contains the question that players need to solve
  static PicturePuzzleData getRowLast(
      PicturePuzzleShapeType picturePuzzleShapeType1,
      String sign1,
      PicturePuzzleShapeType picturePuzzleShapeType2,
      String sign2,
      PicturePuzzleShapeType picturePuzzleShapeType3,
      String op1,
      String op2,
      String op3) {
    return PicturePuzzleData(
        picturePuzzleShapeType1,
        sign1 == "-" ? "+" : sign1,
        picturePuzzleShapeType2,
        sign2 == "-" ? "+" : sign2,
        picturePuzzleShapeType3,
        getResult(op1, sign1 == "-" ? "+" : sign1, op2,
            sign2 == "-" ? "+" : sign2, op3));
  }

  /// Calculates the result of a mathematical expression
  /// Handles operator precedence correctly
  /// Returns the result as a String
  static String getResult(
      String op1, String sign1, String op2, String sign2, String op3) {
    return "${(MathUtil.getPrecedence(sign1) >= MathUtil.getPrecedence(sign2)) ? (MathUtil.evaluate(MathUtil.evaluate(int.parse(op1), sign1, int.parse(op2)), sign2, int.parse(op3))) : (MathUtil.evaluate(int.parse(op1), sign1, MathUtil.evaluate(int.parse(op2), sign2, int.parse(op3))))}";
  }
}

void main() {
//  for (int k = 1; k < 2; k++)
  for (int j = 1; j < 4; j++) {
//    for (int i = 0; i < 5; i++) {
    PicturePuzzleRepository.getPicturePuzzleDataList(j);
//    }
  }
}

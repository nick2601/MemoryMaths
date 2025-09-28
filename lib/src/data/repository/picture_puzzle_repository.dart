import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/utility/math_util.dart';

class PicturePuzzleRepository {
  static final List<int> _listHasCode = <int>[];

  static List<PicturePuzzle> getPicturePuzzleDataList(int level) {
    if (level == 1) _listHasCode.clear();

    final List<PicturePuzzle> list = [];

    while (list.length < 5) {
      final List<PicturePuzzleData> picturePuzzleDataList =
      getNewShapeMatrix(level, list.length);

      final puzzleList = picturePuzzleDataList.asMap().entries.map((entry) {
        final i = entry.key;
        final data = entry.value;

        return PicturePuzzleShapeList([
          PicturePuzzleShape(
            shapeType: data.picturePuzzleShapeType1,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: data.sign1,
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            shapeType: data.picturePuzzleShapeType2,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: data.sign2,
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            shapeType: data.picturePuzzleShapeType3,
            text: "",
            type: PicturePuzzleQuestionItemType.shape,
          ),
          PicturePuzzleShape(
            text: "=",
            type: PicturePuzzleQuestionItemType.sign,
          ),
          PicturePuzzleShape(
            text: i == picturePuzzleDataList.length - 1 ? "?" : data.text,
            type: i == picturePuzzleDataList.length - 1
                ? PicturePuzzleQuestionItemType.answer
                : PicturePuzzleQuestionItemType.hint,
          ),
        ]);
      }).toList();

      final puzzle = PicturePuzzle(
        list: puzzleList,
        answer: int.parse(picturePuzzleDataList.last.text),
      );

      if (!_listHasCode.contains(puzzle.hashCode)) {
        _listHasCode.add(puzzle.hashCode);
        list.add(puzzle);
      }
    }

    return list;
  }

  static List<PicturePuzzleData> getNewShapeMatrix(int level, int index) {
    final List<PicturePuzzleData> list = [];
    final List<String> listDigit = [];
    List<String> listSign = [];

    final List<PicturePuzzleShapeType> listShape = [
      PicturePuzzleShapeType.circle,
      PicturePuzzleShapeType.triangle,
      PicturePuzzleShapeType.square,
    ]..shuffle();

    if (level == 1) {
      switch (index) {
        case 0:
        case 1:
          listSign = ["+", "+", "+"];
          while (listDigit.length < 3) {
            MathUtil.generateRandomNumbers(1, 10, 3).forEach((digit) {
              if (!listDigit.contains(digit)) listDigit.add(digit);
            });
          }
          list
            ..add(getRowFirst(listShape[0], listSign[0], listSign[1], listDigit[0]))
            ..add(getRowSecond(listShape[0], listSign[0], listShape[1],
                listSign[0], listDigit[0], listDigit[1], listDigit[2]))
            ..add(getRowThird(listSign[0], listShape[1], listSign[2],
                listShape[2], listDigit[0], listDigit[1], listDigit[2]))
            ..add(getRowLast(listShape[0], listSign[0], listShape[1],
                listSign[1], listShape[2], listDigit[0], listDigit[1], listDigit[2]));
          break;

        case 2:
        case 3:
        case 4:
          listSign = ["+", "-", "*"]..shuffle()..removeAt(1);
          while (listDigit.length < 3) {
            MathUtil.generateRandomNumbers(level, 10 + level, 3).forEach((digit) {
              if (!listDigit.contains(digit)) listDigit.add(digit);
            });
          }
          list
            ..add(getRowFirst(listShape[0], "+", "+", listDigit[0]))
            ..add(getRowSecond(listShape[0], listSign[0], listShape[1], "+",
                listDigit[0], listDigit[1], listDigit[2]))
            ..add(getRowThird(listSign[0], listShape[1], "-", listShape[2],
                listDigit[0], listDigit[1], listDigit[2]))
            ..add(getRowLast(listShape[0], "+", listShape[1], "+", listShape[2],
                listDigit[0], listDigit[1], listDigit[2]));
          break;
      }
    } else {
      while (listDigit.length < 3) {
        MathUtil.generateRandomNumbers(level, 10 + level, 3).forEach((digit) {
          if (!listDigit.contains(digit)) listDigit.add(digit);
        });
      }
      listSign = ["+", "-", "*"]..shuffle();
      list
        ..add(getRowFirst(listShape[0], listSign[0], listSign[2], listDigit[0]))
        ..add(getRowSecond(listShape[0], listSign[0], listShape[1], "+",
            listDigit[0], listDigit[1], listDigit[2]))
        ..add(getRowThird(listSign[0], listShape[1], "-", listShape[2],
            listDigit[0], listDigit[1], listDigit[2]))
        ..add(getRowLast(listShape[0], listSign[0], listShape[1], listSign[1],
            listShape[2], listDigit[0], listDigit[1], listDigit[2]));
    }

    return list;
  }

  static PicturePuzzleData getRowFirst(
      PicturePuzzleShapeType shape,
      String sign1,
      String sign2,
      String op1,
      ) {
    return PicturePuzzleData(
      shape,
      sign1,
      shape,
      sign2,
      shape,
      getResult(op1, sign1, op1, sign2, op1),
    );
  }

  static PicturePuzzleData getRowSecond(
      PicturePuzzleShapeType shape1,
      String sign1,
      PicturePuzzleShapeType shape2,
      String sign2,
      String op1,
      String op2,
      String op3,
      ) {
    if ((sign1 == "-" && sign2 == "+") || (sign1 == "+" && sign2 == "-")) {
      sign1 = "*";
    }
    return PicturePuzzleData(
      shape1,
      sign1,
      shape2,
      sign2,
      shape2,
      getResult(op1, sign1, op2, sign2, op2),
    );
  }

  static PicturePuzzleData getRowThird(
      String sign1,
      PicturePuzzleShapeType shape2,
      String sign2,
      PicturePuzzleShapeType shape3,
      String op1,
      String op2,
      String op3,
      ) {
    if ((sign1 == "-" && sign2 == "+") || (sign1 == "+" && sign2 == "-")) {
      sign2 = "*";
    }
    return PicturePuzzleData(
      shape2,
      sign1,
      shape3,
      sign2,
      shape3,
      getResult(op2, sign1, op3, sign2, op3),
    );
  }

  static PicturePuzzleData getRowLast(
      PicturePuzzleShapeType shape1,
      String sign1,
      PicturePuzzleShapeType shape2,
      String sign2,
      PicturePuzzleShapeType shape3,
      String op1,
      String op2,
      String op3,
      ) {
    return PicturePuzzleData(
      shape1,
      sign1 == "-" ? "+" : sign1,
      shape2,
      sign2 == "-" ? "+" : sign2,
      shape3,
      getResult(op1, sign1 == "-" ? "+" : sign1, op2,
          sign2 == "-" ? "+" : sign2, op3),
    );
  }

  static String getResult(
      String op1,
      String sign1,
      String op2,
      String sign2,
      String op3,
      ) {
    final leftPrecedence = MathUtil.getPrecedence(sign1);
    final rightPrecedence = MathUtil.getPrecedence(sign2);

    final result = (leftPrecedence >= rightPrecedence)
        ? MathUtil.evaluate(
      MathUtil.evaluate(int.parse(op1), sign1, int.parse(op2)),
      sign2,
      int.parse(op3),
    )
        : MathUtil.evaluate(
      int.parse(op1),
      sign1,
      MathUtil.evaluate(int.parse(op2), sign2, int.parse(op3)),
    );

    return result.toString();
  }
}

void main() {
  for (int j = 1; j < 4; j++) {
    PicturePuzzleRepository.getPicturePuzzleDataList(j);
  }
}

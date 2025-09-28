import 'dart:math';
import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/utility/math_util.dart';
import 'package:tuple/tuple.dart';

class NumberPyramidRepository {
  static const int _baseRowLength = 7;
  static const int _totalCells = 28;
  static const int _pyramidsPerLevel = 20;

  static const List<List<int>> _hintLists = [
    [0, 6, 9, 10, 17, 20, 26],
    [1, 5, 10, 13, 19, 21, 22, 25],
    [3, 4, 8, 12, 16, 18, 24, 26],
    [2, 4, 5, 14, 16, 22, 24, 27],
    [3, 5, 8, 15, 19, 25, 27],
    [1, 4, 9, 12, 14, 16, 25],
    [0, 9, 11, 16, 19, 24, 25],
    [2, 4, 5, 14, 16, 22, 24, 27],
    [1, 3, 5, 11, 13, 15, 21, 23],
    [3, 4, 11, 13, 21, 22, 23, 27],
    [2, 3, 13, 16, 18, 20, 21],
    [0, 1, 9, 13, 16, 17, 20],
    [3, 11, 14, 19, 20, 22, 26],
    [0, 12, 13, 21, 22, 26, 27],
    [4, 8, 9, 19, 21, 24, 27],
    [1, 2, 4, 5, 7, 9, 12],
    [0, 1, 2, 4, 5, 6, 10],
    [0, 12, 13, 18, 22, 26, 27],
    [6, 12, 13, 18, 22, 26, 27],
    [0, 7, 17, 21, 24, 25, 27],
    [0, 7, 13, 18, 22, 25, 27],
    [6, 12, 17, 21, 24, 26, 27],
    [0, 12, 13, 21, 22, 25, 27],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 7, 8, 9, 10, 11, 12],
    [6, 7, 12, 14, 15, 16, 17],
    [18, 19, 20, 21, 17, 7, 6],
    [2, 3, 7, 8, 11, 12, 14],
  ];

  static List<NumberPyramid> getPyramidDataList(int level) {
    final List<NumberPyramid> pyramidsList = <NumberPyramid>[];

    for (int i = 0; i < _pyramidsPerLevel; i++) {
      final tuple = _generateSinglePyramidValues();
      pyramidsList.add(NumberPyramid(id: i, list: tuple.item1, remainingCell: tuple.item2));
    }
    return pyramidsList;
  }

  static Tuple2<List<NumPyramidCellModel>, int> _generateSinglePyramidValues() {
    final List<NumPyramidCellModel> singlePyramidList = <NumPyramidCellModel>[];
    int counter = 1;

    final baseLineList = _generateBaseLineOfPyramid(1, 8, counter);
    singlePyramidList.addAll(baseLineList.item1);
    counter = baseLineList.item2;

    _generateUpperLineOfPyramid(baseLineList.item1, 6, counter, singlePyramidList);

    final random = Random();
    final selectedHintList = _hintLists[random.nextInt(_hintLists.length)];

    for (final index in selectedHintList) {
      if (index < singlePyramidList.length) {
        singlePyramidList[index] = NumPyramidCellModel(
          id: singlePyramidList[index].id,
          text: singlePyramidList[index].text,
          numberOnCell: singlePyramidList[index].numberOnCell,
          isHidden: false,
          isHint: true,
          isCorrect: singlePyramidList[index].isCorrect,
        );
      }
    }

    final cellsToFill = _totalCells - selectedHintList.length;
    return Tuple2(singlePyramidList, cellsToFill);
  }

  static void _generateUpperLineOfPyramid(
      List<NumPyramidCellModel> baseLine,
      int rowsToGenerate,
      int counter,
      List<NumPyramidCellModel> pyramidList,
      ) {
    if (rowsToGenerate == 0) return;

    final List<NumPyramidCellModel> nextRow = [];
    for (int k = 0; k < baseLine.length - 1; k++) {
      final sum = baseLine[k].numberOnCell + baseLine[k + 1].numberOnCell;
      final newCell = NumPyramidCellModel(
          id: counter, text: "", numberOnCell: sum, isHidden: false, isHint: false, isCorrect: false);
      pyramidList.add(newCell);
      nextRow.add(newCell);
      counter++;
    }
    _generateUpperLineOfPyramid(nextRow, rowsToGenerate - 1, counter, pyramidList);
  }

  static Tuple2<List<NumPyramidCellModel>, int> _generateBaseLineOfPyramid(
      int min, int max, int counter) {
    final List<NumPyramidCellModel> baseRow = [];
    for (int i = 0; i < _baseRowLength; i++) {
      final randomNum = MathUtil.generateRandomAnswer(min, max);
      baseRow.add(
          NumPyramidCellModel(id: counter, text: "", numberOnCell: randomNum, isHidden: false, isHint: false, isCorrect: false));
      counter++;
    }
    return Tuple2(baseRow, counter);
  }
}

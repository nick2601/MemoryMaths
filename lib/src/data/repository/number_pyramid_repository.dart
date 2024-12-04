import 'dart:math';

import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/utility/math_util.dart';
import 'package:tuple/tuple.dart';

/// Repository class responsible for managing number pyramid game data and generation
/// A number pyramid is a triangular arrangement of numbers where each number is the
/// sum of the two numbers below it
class NumberPyramidRepository {
  // List to store cells of a single pyramid instance
  static List<NumPyramidCellModel> singlePyramidList = <NumPyramidCellModel>[];
  static late int counter;

  // Predefined hint patterns for different pyramid configurations
  // Each list contains cell indices that should be revealed as hints
  static List<List<int>> hintLists = [
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

  /// Generates a list of number pyramids for a given level
  /// [level] - The difficulty level of the pyramids
  /// Returns a list of [NumberPyramid] objects
  static getPyramidDataList(int level) {
    List<NumberPyramid> pyramidsList = <NumberPyramid>[];

    for (int i = 0; i < 20; i++) {
      var singlePyramidResult = generateSinglePyramidValues();
      pyramidsList.add(NumberPyramid(
          i, singlePyramidResult.item1, singlePyramidResult.item2 + 1));
    }

    return pyramidsList;
  }

  /// Generates values for a single pyramid instance
  /// Returns a tuple containing:
  /// - List of pyramid cells
  /// - Number of cells to be filled by the player
  static Tuple2<List<NumPyramidCellModel>, int> generateSinglePyramidValues() {
    singlePyramidList = <NumPyramidCellModel>[];
    counter = 1;
    // Define range for base numbers
    int min = 1;
    int max = 8;

    // Generate the bottom row of the pyramid
    List<NumPyramidCellModel> baseLineList =
        generateBaseLineOfPyramid(min, max);
    singlePyramidList.addAll(baseLineList);

    // Generate upper rows by calculating sums
    generateUpperLineOfPyramid(baseLineList, counter);

    // Randomly select and apply hints
    final _random = new Random();
    var selectedHintList = hintLists[_random.nextInt(hintLists.length)];

    // Reveal selected cells as hints
    for (int i = 0; i < selectedHintList.length; i++) {
      singlePyramidList[selectedHintList[i]].isHidden = false;
      singlePyramidList[selectedHintList[i]].isHint = true;
    }

    return new Tuple2(singlePyramidList, (27 - selectedHintList.length));
  }

  /// Initiates the generation of upper pyramid rows
  /// [baseLineCellList] - The bottom row cells
  /// [counter] - Current cell counter
  static generateUpperLineOfPyramid(
      List<NumPyramidCellModel> baseLineCellList, int counter) {
    makeSumForPyramid(baseLineCellList, 6, counter);
  }

  /// Recursively generates upper rows of the pyramid
  /// [list] - Current row cells
  /// [loopTime] - Number of remaining rows to generate
  /// [counter] - Current cell counter
  static makeSumForPyramid(
      List<NumPyramidCellModel> list, int loopTime, int counter) {
    // Base case: stop when all rows are generated
    if (loopTime == 0) {
      return;
    }

    // Generate next row by summing adjacent cells
    List<NumPyramidCellModel> tempList = <NumPyramidCellModel>[];
    for (int k = 0; k < list.length - 1; k++) {
      int sum = list[k].numberOnCell + list[k + 1].numberOnCell;
      var newCell = NumPyramidCellModel(
          counter, "", sum, false, false, true, false, false);
      singlePyramidList.add(newCell);
      tempList.add(newCell);
      counter++;
    }

    // Recursive call for next row
    loopTime--;
    makeSumForPyramid(tempList, loopTime, counter);
  }

  /// Generates the base row of the pyramid with random numbers
  /// [min] - Minimum value for random numbers
  /// [max] - Maximum value for random numbers
  /// Returns a list of [NumPyramidCellModel] for the base row
  static List<NumPyramidCellModel> generateBaseLineOfPyramid(int min, int max) {
    List<NumPyramidCellModel> cellList = <NumPyramidCellModel>[];
    cellList.clear();

    // Generate 7 random numbers for the base
    for (int i = 0; i < 7; i++) {
      int randomNum = MathUtil.generateRandomAnswer(min, max);
      cellList.add(NumPyramidCellModel(
          counter, "", randomNum, false, false, true, false, false));
      counter++;
    }
    return cellList;
  }
}

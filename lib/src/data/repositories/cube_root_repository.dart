import 'package:mathsgames/src/utility/math_util.dart';

import '../models/cube_root.dart';

/// Repository class that handles the generation of cube root math problems
/// for different difficulty levels.
class CubeRootRepository {
  /// Keeps track of previously generated cube root problems to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of cube root problems for a given difficulty level
  ///
  /// [level] The difficulty level (1-n) that determines the range of numbers
  /// Returns a List of [CubeRoot] objects containing the problems
  static getCubeDataList(int level) {
    // Reset the hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }
    List<CubeRoot> list = <CubeRoot>[];

    // Calculate min and max ranges based on level
    // Level 1: 1-10
    // Level 2: 5-15
    // Level 3: 10-20, etc.
    int min = level == 1 ? 1 : (5 * level) - 5;
    int max = level == 1 ? 10 : (5 * level) + 5;

    // Generate 5 unique cube root problems
    while (list.length < 5) {
      // Generate random numbers within the range
      MathUtil.generateRandomNumber(min, max, 5 - list.length)
          .map((String x1) => int.parse(x1))
          .forEach((int x1) {
        // Create list for the correct answer and 3 wrong options
        List<int> operandList = <int>[];
        operandList.add(x1); // Add correct answer first

        // Generate 3 wrong options within range [x1-5, x1+5]
        while (operandList.length < 4) {
          int operand =
              MathUtil.generateRandomAnswer((x1 - 5) < 1 ? 2 : x1 - 5, x1 + 5);
          if (!operandList.contains(operand)) operandList.add(operand);
        }

        // Randomize the order of options
        operandList.shuffle();

        // Create cube root problem with question (x³) and 4 options
        CubeRoot cubeRootQandS = CubeRoot(
            (x1 * x1 * x1).toString(), // The cube number as question
            operandList[0].toString(),
            operandList[1].toString(),
            operandList[2].toString(),
            operandList[3].toString(),
            x1); // Correct answer

        // Only add if this exact problem hasn't been generated before
        if (!listHasCode.contains(cubeRootQandS.hashCode)) {
          listHasCode.add(cubeRootQandS.hashCode);
          list.add(cubeRootQandS);
        }
      });
    }
    return list;
  }
}

/// Test function to generate cube root problems for levels 1-4
void main() {
  for (int i = 1; i < 5; i++) {
    CubeRootRepository.getCubeDataList(i);
  }
}

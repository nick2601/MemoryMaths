import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating square root math problems
/// with multiple choice answers based on different difficulty levels.
class SquareRootRepository {
  /// Keeps track of previously generated questions to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of square root problems for a given difficulty level
  ///
  /// [level] determines the range of numbers used:
  /// - Level 1: Numbers between 1-10
  /// - Level n: Numbers between (5n-5) to (5n+5)
  ///
  /// Returns a list of [SquareRoot] objects containing questions and answers
  static getSquareDataList(int level) {
    // Reset tracking list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }
    List<SquareRoot> list = <SquareRoot>[];

    // Calculate range based on level
    int min =
        level == 1 ? 1 : (5 * level) - 5; // Examples: 1, 5, 10, 15, 20, 25
    int max =
        level == 1 ? 10 : (5 * level) + 5; // Examples: 10, 15, 20, 25, 30, 35

    // Generate 5 unique square root problems
    while (list.length < 5) {
      // Generate random numbers within the range
      MathUtil.generateRandomNumber(min, max, 5 - list.length)
          .map((String x1) => int.parse(x1))
          .forEach((int x1) {
        // Create list for multiple choice answers
        List<int> operandList = <int>[];
        operandList.add(x1); // Add correct answer first

        // Generate 3 incorrect answers within range [x1-5, x1+5]
        while (operandList.length < 4) {
          int operand =
              MathUtil.generateRandomAnswer((x1 - 5) < 1 ? 2 : x1 - 5, x1 + 5);
          if (!operandList.contains(operand)) operandList.add(operand);
        }

        // Randomize answer positions
        operandList.shuffle();

        // Create square root problem with question (x1²) and multiple choice answers
        SquareRoot squareRootQandS = SquareRoot(
            (x1 * x1).toString(), // Question is the square
            operandList[0].toString(),
            operandList[1].toString(),
            operandList[2].toString(),
            operandList[3].toString(),
            x1); // Correct answer is the original number

        // Only add if this exact problem hasn't been generated before
        if (!listHasCode.contains(squareRootQandS.hashCode)) {
          listHasCode.add(squareRootQandS.hashCode);
          list.add(squareRootQandS);
        }
      });
    }
    return list;
  }
}

// Test function to generate problems for levels 1-4
void main() {
  for (int i = 1; i < 5; i++) {
    SquareRootRepository.getSquareDataList(i);
  }
}

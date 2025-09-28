import 'package:mathsgames/src/utility/math_util.dart';
import '../models/cube_root.dart';

/// Repository class that handles the generation of cube root math problems
/// for different difficulty levels.
class CubeRootRepository {
  /// Keeps track of previously generated cube root problems to avoid duplicates
  static final List<int> listHasCode = <int>[];

  /// Generates a list of cube root problems for a given difficulty level.
  ///
  /// [level] The difficulty level (1-n) that determines the range of numbers.
  /// Returns a List of [CubeRoot] objects containing the problems.
  static List<CubeRoot> getCubeDataList(int level) {
    // Reset the hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    final List<CubeRoot> list = <CubeRoot>[];

    // Calculate min and max ranges based on level
    // Example:
    // Level 1 -> 1–10
    // Level 2 -> 5–15
    // Level 3 -> 10–20 ...
    final int min = level == 1 ? 1 : (5 * level) - 5;
    final int max = level == 1 ? 10 : (5 * level) + 5;

    // Generate 5 unique cube root problems
    while (list.length < 5) {
      MathUtil.generateRandomNumbers(min, max, 5 - list.length)
          .map(int.parse)
          .forEach((int base) {
        // Skip invalid values
        if (base <= 0) return;

        // Collect correct + 3 unique wrong options
        final Set<int> operandSet = {base};

        while (operandSet.length < 4) {
          final int candidate =
          MathUtil.generateRandomAnswer(base > 5 ? base - 5 : 1, base + 5);
          operandSet.add(candidate);
        }

        // Shuffle the options
        final List<int> operandList = operandSet.toList()..shuffle();

        // Create cube root problem
        final CubeRoot cubeRootQandS = CubeRoot(
          question: (base * base * base).toString(), // Question (cube number)
          firstAns: operandList[0].toString(),
          secondAns: operandList[1].toString(),
          thirdAns: operandList[2].toString(),
          fourthAns: operandList[3].toString(),
          answer: base, // Correct answer
        );

        // Only add unique problems
        if (!listHasCode.contains(cubeRootQandS.hashCode)) {
          listHasCode.add(cubeRootQandS.hashCode);
          list.add(cubeRootQandS);
        }
      });
    }

    return list;
  }
}

/// Test function to generate cube root problems for levels 1–4
void main() {
  for (int i = 1; i < 5; i++) {
    final problems = CubeRootRepository.getCubeDataList(i);
    for (var p in problems) {
      print("Q: ${p.question}, Options: "
          "[${p.firstAns}, ${p.secondAns}, ${p.thirdAns}, ${p.fourthAns}], "
          "Answer: ${p.answer}");
    }
  }
}

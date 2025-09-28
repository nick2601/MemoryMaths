import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mental arithmetic problems
/// based on different difficulty levels.
class MentalArithmeticRepository {
  /// Stores hash codes of previously generated arithmetic problems
  /// to avoid duplicates within a session
  static final List<int> _usedHashCodes = <int>[];

  /// Number of problems to generate per level
  static const int _problemsPerLevel = 5;

  /// Generates a list of mental arithmetic problems for a given difficulty level
  ///
  /// [level] - Integer representing the difficulty level (1–9)
  /// Returns a [List<MentalArithmetic>] containing generated questions
  static List<MentalArithmetic> getMentalArithmeticDataList(int level) {
    // Reset tracking list when starting from level 1
    if (level == 1) {
      _usedHashCodes.clear();
    }

    final List<MentalArithmetic> problems = <MentalArithmetic>[];

    // Generate until we have the required number of unique problems
    while (problems.length < _problemsPerLevel) {
      final Expression? expression = MathUtil.getMentalExp(level);

      if (expression != null) {
        // Build question list for sequential mental arithmetic
        final MentalArithmetic problem = MentalArithmetic(
          questionList: [
            expression.firstOperand,
            "${expression.operator1} ${expression.secondOperand}",
            if (expression.operator2 != null && expression.thirdOperand != null)
              "${expression.operator2} ${expression.thirdOperand}",
            "",
          ],
          answer: expression.answer,
        );

        // Ensure uniqueness
        if (!_usedHashCodes.contains(problem.hashCode)) {
          _usedHashCodes.add(problem.hashCode);
          problems.add(problem);
        }
      }
    }
    return problems;
  }
}

/// Test function to generate arithmetic problems for levels 1–9
void main() {
  for (int i = 1; i <= 9; i++) {
    final problems = MentalArithmeticRepository.getMentalArithmeticDataList(i);
    print("Level $i -> ${problems.length} problems generated");
  }
}

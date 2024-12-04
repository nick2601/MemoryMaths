import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mental arithmetic problems
/// based on different difficulty levels.
class MentalArithmeticRepository {
  /// Stores hash codes of previously generated arithmetic problems
  /// to avoid duplicates within a session
  static List<int> listHasCode = <int>[];

  /// Generates a list of mental arithmetic problems for a given difficulty level
  ///
  /// Parameters:
  ///   - level: Integer representing the difficulty level (1-9)
  ///
  /// Returns:
  ///   A list of [MentalArithmetic] objects containing questions and answers
  static getMentalArithmeticDataList(int level) {
    // Reset hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    List<MentalArithmetic> list = <MentalArithmetic>[];

    // Generate 5 unique arithmetic problems
    while (list.length < 5) {
      // Get a new expression based on the current level
      Expression? expression = MathUtil.getMentalExp(level);
      if (expression != null) {
        // Create a mental arithmetic problem from the expression
        // Format: firstOperand operator1 secondOperand operator2 thirdOperand
        MentalArithmetic mentalArithmeticQandS = MentalArithmetic(
          questionList: [
            expression.firstOperand,
            "${expression.operator1}${expression.secondOperand}",
            "${expression.operator2}${expression.thirdOperand}",
            ""
          ],
          answer: expression.answer,
        );

        // Only add unique problems by checking hash codes
        if (!listHasCode.contains(mentalArithmeticQandS.hashCode)) {
          listHasCode.add(mentalArithmeticQandS.hashCode);
          list.add(mentalArithmeticQandS);
        }
      }
    }
    return list;
  }
}

/// Test function to generate arithmetic problems for levels 1-9
void main() {
  for (int i = 1; i < 10; i++) {
    MentalArithmeticRepository.getMentalArithmeticDataList(i);
  }
}

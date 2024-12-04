import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class that handles the generation and management of calculator problems
/// for the math games application.
class CalculatorRepository {
  /// Stores hash codes of previously generated calculator problems to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of calculator problems for a specific difficulty level
  ///
  /// Parameters:
  ///   - level: Integer representing the difficulty level (1-8)
  ///
  /// Returns:
  ///   A list of [Calculator] objects containing math problems and their answers
  static getCalculatorDataList(int level) {
    // Reset hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Initialize empty list to store calculator problems
    List<Calculator> list = <Calculator>[];

    // Generate problems until we have 5 unique ones
    while (list.length < 5) {
      // Generate mathematical expressions based on the level
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        Calculator calculatorQandS;

        // Create calculator problem based on whether it's a two-operand
        // or three-operand expression
        if (expression.operator2 == null) {
          // Two-operand expression (e.g., "2 + 3")
          calculatorQandS = Calculator(
              question:
                  "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
              answer: expression.answer);
        } else {
          // Three-operand expression (e.g., "2 + 3 * 4")
          calculatorQandS = Calculator(
              question:
                  "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
              answer: expression.answer);
        }

        // Only add the problem if it's unique (not seen before)
        if (!listHasCode.contains(calculatorQandS.hashCode)) {
          listHasCode.add(calculatorQandS.hashCode);
          list.add(calculatorQandS);
        }
      });
    }
    return list;
  }
}

/// Test function to generate calculator problems for all levels
void main() {
  for (int i = 1; i <= 8; i++) {
    CalculatorRepository.getCalculatorDataList(i);
  }
}

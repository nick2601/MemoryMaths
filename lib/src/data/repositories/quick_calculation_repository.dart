import 'package:mathsgames/src/data/models/quick_calculation.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mathematical calculation questions
/// with varying difficulty levels.
class QuickCalculationRepository {
  /// Stores hash codes of previously generated calculations to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of quick calculation questions based on the specified level and quantity
  ///
  /// Parameters:
  /// - [level]: Difficulty level of the calculations (1-5)
  /// - [noItem]: Number of calculation items to generate
  ///
  /// Returns a List of [QuickCalculation] objects containing questions and answers
  static getQuickCalculationDataList(int level, int noItem) {
    // Reset hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }
    List<QuickCalculation> list = <QuickCalculation>[];

    // Keep generating expressions until we have the requested number of unique items
    while (list.length < noItem) {
      // Generate mathematical expressions for the current level
      MathUtil.generate(level, noItem - list.length)
          .forEach((Expression expression) {
        QuickCalculation quickCalculationQandS;

        // Create question string based on whether it's a binary or ternary operation
        if (expression.operator2 == null) {
          // Binary operation (e.g., "2 + 3")
          quickCalculationQandS = QuickCalculation(
            question:
                "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            answer: expression.answer,
          );
        } else {
          // Ternary operation (e.g., "2 + 3 * 4")
          quickCalculationQandS = QuickCalculation(
            question:
                "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
            answer: expression.answer,
          );
        }

        // Only add unique questions to avoid duplicates
        if (!listHasCode.contains(quickCalculationQandS.hashCode)) {
          listHasCode.add(quickCalculationQandS.hashCode);
          list.add(quickCalculationQandS);
        }
      });
    }

    return list;
  }
}

/// Test function to generate sample calculations for levels 1-5
void main() {
  for (int i = 1; i <= 5; i++) {
    QuickCalculationRepository.getQuickCalculationDataList(i, 1);
  }
}

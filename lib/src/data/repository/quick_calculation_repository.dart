import 'package:mathsgames/src/data/models/quick_calculation.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mathematical calculation questions
/// with varying difficulty levels.
class QuickCalculationRepository {
  /// Stores unique question strings to avoid duplicates
  static final Set<String> _uniqueQuestions = <String>{};

  /// Generates a list of quick calculation questions for a given [level].
  ///
  /// Parameters:
  /// - [level]: Difficulty level of the calculations (1-5)
  /// - [noItem]: Number of calculation items to generate
  ///
  /// Returns: A List of [QuickCalculation] objects containing questions and answers
  static List<QuickCalculation> getQuickCalculationDataList(
      int level, int noItem) {
    if (level == 1) {
      _uniqueQuestions.clear();
    }

    final List<QuickCalculation> list = <QuickCalculation>[];

    // Keep generating until we have the requested number of unique items
    while (list.length < noItem) {
      MathUtil.generate(level, noItem - list.length).forEach((expression) {
        final question = _buildQuestion(expression);
        final quickCalculation = QuickCalculation(
          question: question,
          answer: expression.answer,
        );

        // Ensure uniqueness by checking the actual question string
        if (_uniqueQuestions.add(question)) {
          list.add(quickCalculation);
        }
      });
    }

    return list;
  }

  /// Builds the question string from an [Expression].
  static String _buildQuestion(Expression expression) {
    if (expression.operator2 == null) {
      // Binary operation (e.g., "2 + 3")
      return "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}";
    } else {
      // Ternary operation (e.g., "2 + 3 * 4")
      return "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} "
          "${expression.operator2} ${expression.thirdOperand}";
    }
  }
}

/// Test function to generate sample calculations for levels 1-5
void main() {
  for (int i = 1; i <= 5; i++) {
    final data = QuickCalculationRepository.getQuickCalculationDataList(i, 3);
    data.forEach((q) => print("${q.question} = ${q.answer}"));
  }
}
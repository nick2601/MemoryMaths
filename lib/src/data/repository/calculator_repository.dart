import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class that handles the generation and management of
/// calculator problems for the math games application.
class CalculatorRepository {
  /// Stores hash codes of generated calculator problems
  /// to avoid duplicates within a session.
  static final Set<int> _generatedHashes = <int>{};

  /// Generates a list of unique calculator problems for a specific difficulty level.
  ///
  /// Parameters:
  /// - [level]: Difficulty level (1–8).
  ///
  /// Returns:
  /// A list of [Calculator] objects containing math problems and their answers.
  static List<Calculator> getCalculatorDataList(int level) {
    // Reset when starting from level 1
    if (level == 1) {
      _generatedHashes.clear();
    }

    final List<Calculator> calculators = <Calculator>[];

    // Generate problems until we have 5 unique ones
    while (calculators.length < 5) {
      final expressions = MathUtil.generate(level, 5 - calculators.length);

      for (final expression in expressions) {
        final calculator = expression.operator2 == null
            ? Calculator(
          question:
          "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
          answer: expression.answer,
        )
            : Calculator(
          question:
          "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
          answer: expression.answer,
        );

        // Ensure uniqueness
        if (_generatedHashes.add(calculator.hashCode)) {
          calculators.add(calculator);
        }
      }
    }

    return calculators;
  }
}

/// Test function to generate calculator problems for all levels.
void main() {
  for (int i = 1; i <= 8; i++) {
    final problems = CalculatorRepository.getCalculatorDataList(i);
    print("Level $i => ${problems.length} problems");
    problems.forEach(print);
  }
}
import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mathematical sign expressions
/// and managing their unique instances.
class SignRepository {
  /// Tracks unique question strings to prevent duplicates
  static final Set<String> _uniqueQuestions = <String>{};

  /// Generates a list of mathematical sign expressions for the given [level].
  ///
  /// Always returns 5 unique [Sign] problems.
  static List<Sign> getSignDataList(int level) {
    final List<Sign> list = <Sign>[];

    // Reset when starting fresh at level 1
    if (level == 1) {
      _uniqueQuestions.clear();
    }

    int attempts = 0; // safeguard against infinite loop
    const int maxAttempts = 200;

    while (list.length < 5 && attempts < maxAttempts) {
      attempts++;
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        final signQandS = _buildSign(expression, list.length);

        if (signQandS != null) {
          final key =
              "${signQandS.firstDigit} ${signQandS.sign} ${signQandS.secondDigit}";

          if (_uniqueQuestions.add(key)) {
            list.add(signQandS);
          }
        }
      });
    }

    return list;
  }

  /// Builds a [Sign] object from a given [Expression].
  static Sign? _buildSign(Expression expression, int index) {
    // Handle single operator expressions
    if (expression.operator2 == null) {
      final first = int.parse(expression.firstOperand);
      final second = int.parse(expression.secondOperand);

      if (expression.operator1 == "+") {
        if (MathUtil.evaluate(first, "+", second) !=
            MathUtil.evaluate(first, "*", second)) {
          return Sign(
            firstDigit: expression.firstOperand,
            sign: expression.operator1,
            secondDigit: expression.secondOperand,
            answer: expression.answer.toString(),
          );
        }
      } else if (expression.operator1 == "/") {
        if (MathUtil.evaluate(first, "/", second) !=
            MathUtil.evaluate(first, "-", second)) {
          return Sign(
            firstDigit: expression.firstOperand,
            sign: expression.operator1,
            secondDigit: expression.secondOperand,
            answer: expression.answer.toString(),
          );
        }
      } else {
        return Sign(
          firstDigit: expression.firstOperand,
          sign: expression.operator1,
          secondDigit: expression.secondOperand,
          answer: expression.answer.toString(),
        );
      }
    }
    // Handle two-operator expressions
    else {
      return Sign(
        firstDigit: index % 2 == 0
            ? "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}"
            : expression.firstOperand,
        sign: index % 2 == 0 ? expression.operator2! : expression.operator1,
        secondDigit: index % 2 == 0
            ? expression.thirdOperand ?? ""
            : "${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand ?? ""}",
        answer: expression.answer.toString(),
      );
    }

    return null;
  }
}

/// Test function to generate and print sign expressions for levels 1-5
void main() {
  for (int i = 1; i <= 5; i++) {
    final list = SignRepository.getSignDataList(i);
    print("Level $i:");
    for (final sign in list) {
      print("${sign.firstDigit} ${sign.sign} ${sign.secondDigit} = ${sign.answer}");
    }
  }
}

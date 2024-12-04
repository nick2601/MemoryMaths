import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating mathematical sign expressions
/// and managing their unique instances.
class SignRepository {
  /// Stores hash codes of generated signs to prevent duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of mathematical sign expressions based on the given level
  ///
  /// [level] determines the complexity of the generated expressions
  /// Returns a List<Sign> containing 5 unique mathematical expressions
  static getSignDataList(int level) {
    List<Sign> list = <Sign>[];

    // Reset hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Continue generating expressions until we have 5 unique ones
    while (list.length < 5) {
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        Sign? signQandS;

        // Handle single operator expressions
        if (expression.operator2 == null) {
          if (expression.operator1 == "+") {
            // Only create addition sign if addition result differs from multiplication
            if (MathUtil.evaluate(int.parse(expression.firstOperand), "+",
                    int.parse(expression.secondOperand)) !=
                MathUtil.evaluate(int.parse(expression.firstOperand), "*",
                    int.parse(expression.secondOperand))) {
              signQandS = Sign(
                firstDigit: expression.firstOperand,
                sign: expression.operator1,
                secondDigit: expression.secondOperand,
                answer: expression.answer.toString(),
              );
            }
          } else if (expression.operator1 == "/") {
            // Only create division sign if division result differs from subtraction
            if (MathUtil.evaluate(int.parse(expression.firstOperand), "/",
                    int.parse(expression.secondOperand)) !=
                MathUtil.evaluate(int.parse(expression.firstOperand), "-",
                    int.parse(expression.secondOperand))) {
              signQandS = Sign(
                firstDigit: expression.firstOperand,
                sign: expression.operator1,
                secondDigit: expression.secondOperand,
                answer: expression.answer.toString(),
              );
            }
          } else {
            // Create sign for other operators (* and -)
            signQandS = Sign(
              firstDigit: expression.firstOperand,
              sign: expression.operator1,
              secondDigit: expression.secondOperand,
              answer: expression.answer.toString(),
            );
          }
        } else {
          // Handle complex expressions with two operators
          // Alternates between putting the compound expression on left or right side
          signQandS = Sign(
            firstDigit: list.length % 2 == 0
                ? ("${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}")
                : (expression.firstOperand),
            sign: list.length % 2 == 0
                ? expression.operator2!
                : expression.operator1,
            secondDigit: list.length % 2 == 0
                ? expression.thirdOperand
                : ("${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}"),
            answer: expression.answer.toString(),
          );
        }

        // Add sign to list if it's valid and unique
        if (signQandS != null) {
          if (!listHasCode.contains(signQandS.hashCode)) {
            listHasCode.add(signQandS.hashCode);
            list.add(signQandS);
          }
        }
      });
    }
    return list;
  }
}

/// Test function to generate and print sign expressions for levels 1-5
void main() {
  for (int i = 1; i <= 5; i++) {
    print(SignRepository.getSignDataList(i));
  }
}

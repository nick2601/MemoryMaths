import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating math questions and their corresponding answers
/// for different difficulty levels.
class CorrectAnswerRepository {
  /// Stores hash codes of previously generated questions to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of 5 unique math questions with multiple choice answers for a given level
  ///
  /// [level] The difficulty level of the math questions (1-4)
  /// Returns a List of [CorrectAnswer] objects containing questions and answer choices
  static getCorrectAnswerDataList(int level) {
    // Reset hash list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    List<CorrectAnswer> list = <CorrectAnswer>[];

    // Generate questions until we have 5 unique ones
    while (list.length < 5) {
      // Generate mathematical expressions based on level
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        List<int> x = <int>[];
        int val;

        // Handle two-operand expressions
        if (expression.operator2 == null) {
          // Alternate between first and second operand as the answer
          val = (list.length % 2 == 0)
              ? int.parse(expression.firstOperand)
              : int.parse(expression.secondOperand);
          x.add(val);
        }
        // Handle three-operand expressions
        else {
          // Cycle through all three operands as possible answers
          val = (list.length % 3 == 0)
              ? int.parse(expression.firstOperand)
              : (list.length % 3 == 1
                  ? int.parse(expression.secondOperand)
                  : int.parse(expression.thirdOperand));
          x.add(val);
        }

        // Generate 3 additional answer choices within ±5 of the correct answer
        while (x.length < 4) {
          int x4 = int.parse(MathUtil.generateRandomNumber(
                  (val - 5) < 0 ? 1 : val - 5, val + 5, 1)
              .first);
          if (!x.contains(x4)) x.add(x4);
        }

        // Randomize the order of answer choices
        x.shuffle();

        CorrectAnswer correctAnswerQandS;
        // Create question object for two-operand expression
        if (expression.operator2 == null) {
          correctAnswerQandS = CorrectAnswer(
              question: Question(
                firstOperand: Operand(
                    value: expression.firstOperand,
                    isQuestionMark: list.length % 2 == 0),
                firstOperator: expression.operator1,
                secondOperand: Operand(
                  value: expression.secondOperand,
                  isQuestionMark: list.length % 2 == 1,
                ),
                secondOperator: null,
                thirdOperand: null,
                answer: expression.answer,
              ),
              firstAns: x[0].toString(),
              secondAns: x[1].toString(),
              thirdAns: x[2].toString(),
              fourthAns: x[3].toString(),
              answer: (list.length % 2 == 0)
                  ? int.parse(expression.firstOperand)
                  : int.parse(expression.secondOperand));
        }
        // Create question object for three-operand expression
        else {
          correctAnswerQandS = CorrectAnswer(
              question: Question(
                firstOperand: Operand(
                    value: expression.firstOperand,
                    isQuestionMark: list.length % 3 == 0),
                firstOperator: expression.operator1,
                secondOperand: Operand(
                  value: expression.secondOperand,
                  isQuestionMark: list.length % 3 == 1,
                ),
                secondOperator: expression.operator2,
                thirdOperand: Operand(
                  value: expression.thirdOperand,
                  isQuestionMark: list.length % 3 == 2,
                ),
                answer: expression.answer,
              ),
              firstAns: x[0].toString(),
              secondAns: x[1].toString(),
              thirdAns: x[2].toString(),
              fourthAns: x[3].toString(),
              answer: (list.length % 3 == 0)
                  ? int.parse(expression.firstOperand)
                  : (list.length % 3 == 1
                      ? int.parse(expression.secondOperand)
                      : int.parse(expression.thirdOperand)));
        }

        // Only add question if it's unique (based on hash code)
        if (!listHasCode.contains(correctAnswerQandS.hashCode)) {
          listHasCode.add(correctAnswerQandS.hashCode);
          list.add(correctAnswerQandS);
        }
      });
    }

    return list;
  }
}

/// Test function to generate questions for levels 1-4
void main() {
  for (int i = 1; i < 5; i++) {
    CorrectAnswerRepository.getCorrectAnswerDataList(i);
  }
}

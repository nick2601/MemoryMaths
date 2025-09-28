import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository responsible for generating math questions with multiple-choice answers.
/// Supports both two-operand and three-operand arithmetic expressions.
class CorrectAnswerRepository {
  /// Stores hash codes of generated questions to avoid duplicates
  static final Set<int> _generatedHashes = <int>{};

  /// Generates a list of 5 unique math questions with answer choices for a given [level].
  ///
  /// [level] The difficulty level of the math questions (1–4).
  /// Returns a list of [CorrectAnswer] objects.
  static List<CorrectAnswer> getCorrectAnswerDataList(int level) {
    // Reset when starting at level 1
    if (level == 1) {
      _generatedHashes.clear();
    }

    final List<CorrectAnswer> questions = [];

    // Generate until we have 5 unique questions
    while (questions.length < 5) {
      final expressions = MathUtil.generate(level, 5 - questions.length);

      for (final expression in expressions) {
        final List<int> options = [];
        late int correctValue;

        // Select which operand is the "missing" one
        if (expression.operator2 == null) {
          // Two-operand expression
          correctValue = (questions.length % 2 == 0)
              ? int.parse(expression.firstOperand)
              : int.parse(expression.secondOperand);
        } else {
          // Three-operand expression
          correctValue = (questions.length % 3 == 0)
              ? int.parse(expression.firstOperand)
              : (questions.length % 3 == 1
              ? int.parse(expression.secondOperand)
              : int.parse(expression.thirdOperand ?? ''));
        }

        // Add correct value first
        options.add(correctValue);

        // Generate 3 unique distractors within ±5 range
        while (options.length < 4) {
          final candidate = int.parse(MathUtil.generateRandomNumbers(
            (correctValue - 5).clamp(1, correctValue), // avoid negatives
            correctValue + 5,
            1,
          ).first);
          if (!options.contains(candidate)) {
            options.add(candidate);
          }
        }

        options.shuffle();

        final CorrectAnswer question = (expression.operator2 == null)
            ? CorrectAnswer(
          question: Question(
            firstOperand: Operand(
              value: expression.firstOperand,
              isQuestionMark: questions.length % 2 == 0,
            ),
            firstOperator: expression.operator1,
            secondOperand: Operand(
              value: expression.secondOperand,
              isQuestionMark: questions.length % 2 == 1,
            ),
            secondOperator: null,
            thirdOperand: null,
            answer: expression.answer,
          ),
          firstAns: options[0].toString(),
          secondAns: options[1].toString(),
          thirdAns: options[2].toString(),
          fourthAns: options[3].toString(),
          answer: correctValue,
        )
            : CorrectAnswer(
          question: Question(
            firstOperand: Operand(
              value: expression.firstOperand,
              isQuestionMark: questions.length % 3 == 0,
            ),
            firstOperator: expression.operator1,
            secondOperand: Operand(
              value: expression.secondOperand,
              isQuestionMark: questions.length % 3 == 1,
            ),
            secondOperator: expression.operator2,
            thirdOperand: Operand(
              value: expression.thirdOperand ?? '',
              isQuestionMark: questions.length % 3 == 2,
            ),
            answer: expression.answer,
          ),
          firstAns: options[0].toString(),
          secondAns: options[1].toString(),
          thirdAns: options[2].toString(),
          fourthAns: options[3].toString(),
          answer: correctValue,
        );

        // Only add if unique
        if (_generatedHashes.add(question.hashCode)) {
          questions.add(question);
        }

        if (questions.length >= 5) break;
      }
    }

    return questions;
  }
}

/// Test function to generate questions for levels 1–4
void main() {
  for (int i = 1; i <= 4; i++) {
    final questions = CorrectAnswerRepository.getCorrectAnswerDataList(i);
    print("Level $i generated ${questions.length} questions:");
    questions.forEach(print);
  }
}

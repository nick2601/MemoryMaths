/// A model class representing a True/False question with multiple-choice options.
class TrueFalseModel {
  /// The mathematical operator or sign (e.g., "+", "-", etc.).
  String? sign;

  /// The remainder or additional information related to the question.
  String? rem;

  /// A unique identifier for the question.
  int? id;

  /// The first digit or operand in the question.
  String? firstDigit;

  /// The second digit or operand in the question.
  String? secondDigit;

  /// The question text or expression.
  String? question;

  /// The correct answer to the question.
  String? answer;

  /// The first multiple-choice option.
  String? op_1;

  /// The second multiple-choice option.
  String? op_2;

  /// The third multiple-choice option.
  String? op_3;

  /// A list of all multiple-choice options.
  List<String> optionList = [];

  /// Constructs a `TrueFalseModel` object.
  ///
  /// Parameters:
  /// - `answer` (String): The correct answer to the question.
  /// - `firstDigit` (String?): The first digit or operand in the question.
  /// - `secondDigit` (String?): The second digit or operand in the question.
  /// - `question` (String?): The question text or expression.
  /// - `op_1` (String?): The first multiple-choice option.
  /// - `op_2` (String?): The second multiple-choice option.
  /// - `op_3` (String?): The third multiple-choice option.
  TrueFalseModel(String answer, {
    this.firstDigit,
    this.secondDigit,
    this.question,
    this.op_1,
    this.op_2,
    this.op_3,
  }) {
    this.firstDigit = firstDigit;
    this.secondDigit = secondDigit;
    this.question = question;
    this.answer = answer;
    this.op_1 = op_1;
    this.op_2 = op_2;
    this.op_3 = op_3;
  }
}

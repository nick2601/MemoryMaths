/// Represents a simple calculator model with a question and its corresponding answer.
class Calculator {
  /// The mathematical question or expression as a string.
  String question;

  /// The answer to the mathematical question.
  int answer;

  /// Constructs a `Calculator` object.
  ///
  /// Parameters:
  /// - `question` (String): The mathematical question or expression.
  /// - `answer` (int): The answer to the question.
  Calculator({required this.question, required this.answer});

  /// Returns a string representation of the `Calculator` object.
  ///
  /// Example:
  /// ```
  /// Calculator(question: "5 + 3", answer: 8).toString();
  /// // Output: "Calculator{question: 5 + 3, answer: 8}"
  /// ```
  @override
  String toString() {
    return 'Calculator{question: $question, answer: $answer}';
  }

  /// Compares two `Calculator` objects for equality.
  ///
  /// Returns `true` if the `question` fields of both objects are equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Calculator &&
              runtimeType == other.runtimeType &&
              question == other.question;

  /// Returns the hash code for the `Calculator` object.
  ///
  /// The hash code is based on the `question` field.
  @override
  int get hashCode => question.hashCode;
}

/// Model class representing a quick calculation question.
/// Used for timed mathematical challenges where players need to solve problems quickly.
class QuickCalculation {
  /// The mathematical question or expression to solve
  String question;

  /// The correct numerical answer to the question
  int answer;

  /// Creates a new QuickCalculation instance.
  ///
  /// Parameters:
  /// - [question]: Mathematical expression to solve
  /// - [answer]: Correct numerical result
  QuickCalculation({required this.question, required this.answer});

  @override
  String toString() {
    return 'QuickCalculationQandS{question: $question, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickCalculation &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}

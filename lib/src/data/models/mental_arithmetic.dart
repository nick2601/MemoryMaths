/// Model class representing a mental arithmetic challenge.
/// Contains a sequence of questions that form a complete arithmetic problem.
class MentalArithmetic {
  /// The current question being displayed
  late String currentQuestion;

  /// List of all questions in the sequence
  List<String> questionList;

  /// The final correct answer to the complete problem
  int answer;

  /// Number of digits in the answer
  late int answerLength;

  /// Creates a new MentalArithmetic instance.
  ///
  /// Parameters:
  /// - [questionList]: Sequence of questions to display
  /// - [answer]: Final correct answer
  MentalArithmetic({required this.questionList, required this.answer}) {
    this.currentQuestion = questionList[0];
    this.answerLength = answer.toString().trim().length;
  }

  @override
  String toString() {
    return 'CalculatorQandS{question: $questionList, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalArithmetic &&
          runtimeType == other.runtimeType &&
          questionList == other.questionList;

  @override
  int get hashCode => questionList.hashCode;
}

/// Model class representing a square root quiz question.
/// Contains the question, multiple choice answers, and correct answer index.
class SquareRoot {
  /// The complete question text
  String question;

  /// First multiple choice answer option
  String firstAns;

  /// Second multiple choice answer option
  String secondAns;

  /// Third multiple choice answer option
  String thirdAns;

  /// Fourth multiple choice answer option
  String fourthAns;

  /// Index of the correct answer (1-4)
  int answer;

  /// Creates a new SquareRoot instance.
  ///
  /// Parameters:
  /// - [question]: The square root question text
  /// - [firstAns]: First answer choice
  /// - [secondAns]: Second answer choice
  /// - [thirdAns]: Third answer choice
  /// - [fourthAns]: Fourth answer choice
  /// - [answer]: Index of correct answer
  SquareRoot(this.question, this.firstAns, this.secondAns, this.thirdAns,
      this.fourthAns, this.answer);

  @override
  String toString() {
    return 'SignQandS{ question: $question, firstAns: $firstAns, secondAns: $secondAns, thirdAns: $thirdAns, fourthAns: $fourthAns, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SquareRoot &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}

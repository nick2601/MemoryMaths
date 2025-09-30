/// Domain entity for Calculator
/// This represents the business logic model for calculator problems
/// Clean Architecture: Domain Layer - Entities are pure business objects
class CalculatorEntity {
  final String question;
  final int answer;

  CalculatorEntity({
    required this.question,
    required this.answer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorEntity &&
          runtimeType == other.runtimeType &&
          question == other.question &&
          answer == other.answer;

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;

  @override
  String toString() {
    return 'CalculatorEntity{question: $question, answer: $answer}';
  }
}

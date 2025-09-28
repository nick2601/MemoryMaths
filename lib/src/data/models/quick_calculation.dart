import 'package:hive/hive.dart';

part 'quick_calculation.g.dart';

/// Model class representing a quick calculation question.
/// Used for timed mathematical challenges where players need to solve problems quickly.
@HiveType(typeId: 60) // Ensure typeId is unique across your models
class QuickCalculation {
  /// The mathematical question or expression to solve
  @HiveField(0)
  final String question;

  /// The correct numerical answer to the question
  @HiveField(1)
  final int answer;

  /// Creates a new QuickCalculation instance.
  const QuickCalculation({
    required this.question,
    required this.answer,
  });

  /// Creates a copy of this QuickCalculation with optional new values.
  QuickCalculation copyWith({
    String? question,
    int? answer,
  }) {
    return QuickCalculation(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  /// Converts this object to a JSON map (useful for API integration).
  Map<String, dynamic> toJson() => {
    'question': question,
    'answer': answer,
  };

  /// Creates a new instance from a JSON map.
  factory QuickCalculation.fromJson(Map<String, dynamic> json) {
    return QuickCalculation(
      question: json['question'] as String,
      answer: json['answer'] as int,
    );
  }

  @override
  String toString() =>
      'QuickCalculation(question: $question, answer: $answer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is QuickCalculation && question == other.question;

  @override
  int get hashCode => question.hashCode;
}
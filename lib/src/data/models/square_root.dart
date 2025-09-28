import 'package:hive/hive.dart';

part 'square_root.g.dart';

/// Model class representing a square root quiz question.
/// Contains the question, multiple choice answers, and correct answer index.
@HiveType(typeId: 12) // 👈 choose a unique typeId for this model
class SquareRoot {
  /// The complete question text
  @HiveField(0)
  final String question;

  /// First multiple choice answer option
  @HiveField(1)
  final String firstAns;

  /// Second multiple choice answer option
  @HiveField(2)
  final String secondAns;

  /// Third multiple choice answer option
  @HiveField(3)
  final String thirdAns;

  /// Fourth multiple choice answer option
  @HiveField(4)
  final String fourthAns;

  /// Index of the correct answer (1-4)
  @HiveField(5)
  final int answer;

  /// Creates a new SquareRoot instance.
  const SquareRoot(
      this.question,
      this.firstAns,
      this.secondAns,
      this.thirdAns,
      this.fourthAns,
      this.answer,
      );

  /// Factory constructor to create from JSON
  factory SquareRoot.fromJson(Map<String, dynamic> json) => SquareRoot(
    json['question'] as String,
    json['firstAns'] as String,
    json['secondAns'] as String,
    json['thirdAns'] as String,
    json['fourthAns'] as String,
    json['answer'] as int,
  );

  /// Converts this instance to JSON
  Map<String, dynamic> toJson() => {
    'question': question,
    'firstAns': firstAns,
    'secondAns': secondAns,
    'thirdAns': thirdAns,
    'fourthAns': fourthAns,
    'answer': answer,
  };

  @override
  String toString() =>
      'SquareRoot(question: $question, firstAns: $firstAns, '
          'secondAns: $secondAns, thirdAns: $thirdAns, fourthAns: $fourthAns, '
          'answer: $answer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SquareRoot &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer;

  @override
  int get hashCode => Object.hash(question, answer);
}
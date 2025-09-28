import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'mental_arithmetic.g.dart';

/// Model class representing a mental arithmetic challenge.
/// Contains a sequence of questions that form a complete arithmetic problem.
@HiveType(typeId: 32)
class MentalArithmetic {
  /// List of all questions in the sequence
  @HiveField(0)
  final List<String> questionList;

  /// The final correct answer to the complete problem
  @HiveField(1)
  final int answer;

  /// The current question being displayed
  String get currentQuestion => questionList.isNotEmpty ? questionList[0] : '';

  /// Number of digits in the answer
  int get answerLength => answer.toString().trim().length;

  /// Creates a new MentalArithmetic instance.
  MentalArithmetic({
    required this.questionList,
    required this.answer,
  });

  /// Copy constructor for immutability
  MentalArithmetic copyWith({
    List<String>? questionList,
    int? answer,
  }) {
    return MentalArithmetic(
      questionList: questionList ?? this.questionList,
      answer: answer ?? this.answer,
    );
  }

  @override
  String toString() =>
      'MentalArithmetic(questions: $questionList, answer: $answer, answerLength: $answerLength)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MentalArithmetic &&
              const DeepCollectionEquality().equals(questionList, other.questionList) &&
              answer == other.answer;

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(questionList) ^ answer.hashCode;
}
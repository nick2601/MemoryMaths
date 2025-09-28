import 'package:hive/hive.dart';

part 'model_workout_data.g.dart';

/// Model class representing a workout quiz question with multiple options.
@HiveType(typeId: 33)
class ModelWorkoutData {
  /// The workout question text
  @HiveField(0)
  final String question;

  /// The correct answer
  @HiveField(1)
  final String answer;

  /// Option A
  @HiveField(2)
  final String optA;

  /// Option B
  @HiveField(3)
  final String optB;

  /// Option C
  @HiveField(4)
  final String optC;

  /// Creates a new ModelWorkoutData instance.
  ModelWorkoutData({
    required this.question,
    required this.answer,
    required this.optA,
    required this.optB,
    required this.optC,
  });

  /// Copy constructor for immutability
  ModelWorkoutData copyWith({
    String? question,
    String? answer,
    String? optA,
    String? optB,
    String? optC,
  }) {
    return ModelWorkoutData(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      optA: optA ?? this.optA,
      optB: optB ?? this.optB,
      optC: optC ?? this.optC,
    );
  }

  @override
  String toString() =>
      'ModelWorkoutData(question: $question, answer: $answer, optA: $optA, optB: $optB, optC: $optC)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ModelWorkoutData &&
              question == other.question &&
              answer == other.answer &&
              optA == other.optA &&
              optB == other.optB &&
              optC == other.optC;

  @override
  int get hashCode =>
      question.hashCode ^
      answer.hashCode ^
      optA.hashCode ^
      optB.hashCode ^
      optC.hashCode;
}
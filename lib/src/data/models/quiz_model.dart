import 'package:hive/hive.dart';

part 'quiz_model.g.dart';

/// Model class representing a quiz question in the game.
/// Contains all the information needed to display and evaluate a math quiz question.
@HiveType(typeId: 61) // ⚠️ Ensure unique typeId across all models
class QuizModel {
  /// Mathematical operator or sign for the question
  @HiveField(0)
  final String? sign;

  /// Remainder value for division questions
  @HiveField(1)
  final String? rem;

  /// Unique identifier for the quiz question
  @HiveField(2)
  final int? id;

  /// First number in the mathematical expression
  @HiveField(3)
  final String? firstDigit;

  /// Second number in the mathematical expression
  @HiveField(4)
  final String? secondDigit;

  /// The complete question text
  @HiveField(5)
  final String? question;

  /// The correct answer to the question
  @HiveField(6)
  final String answer;

  /// First multiple choice option
  @HiveField(7)
  final String? op1;

  /// Second multiple choice option
  @HiveField(8)
  final String? op2;

  /// Third multiple choice option
  @HiveField(9)
  final String? op3;

  /// List of all available options for the question
  @HiveField(10)
  final List<String> optionList;

  /// Creates a new QuizModel instance.
  QuizModel({
    required this.answer,
    this.sign,
    this.rem,
    this.id,
    this.firstDigit,
    this.secondDigit,
    this.question,
    this.op1,
    this.op2,
    this.op3,
    List<String>? optionList,
  }) : optionList = optionList ?? [];

  /// Copy this object with optional new values
  QuizModel copyWith({
    String? sign,
    String? rem,
    int? id,
    String? firstDigit,
    String? secondDigit,
    String? question,
    String? answer,
    String? op1,
    String? op2,
    String? op3,
    List<String>? optionList,
  }) {
    return QuizModel(
      sign: sign ?? this.sign,
      rem: rem ?? this.rem,
      id: id ?? this.id,
      firstDigit: firstDigit ?? this.firstDigit,
      secondDigit: secondDigit ?? this.secondDigit,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      op1: op1 ?? this.op1,
      op2: op2 ?? this.op2,
      op3: op3 ?? this.op3,
      optionList: optionList ?? this.optionList,
    );
  }

  /// Convert object to JSON for API or Firebase
  Map<String, dynamic> toJson() => {
    'sign': sign,
    'rem': rem,
    'id': id,
    'firstDigit': firstDigit,
    'secondDigit': secondDigit,
    'question': question,
    'answer': answer,
    'op1': op1,
    'op2': op2,
    'op3': op3,
    'optionList': optionList,
  };

  /// Create object from JSON
  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    sign: json['sign'] as String?,
    rem: json['rem'] as String?,
    id: json['id'] as int?,
    firstDigit: json['firstDigit'] as String?,
    secondDigit: json['secondDigit'] as String?,
    question: json['question'] as String?,
    answer: json['answer'] as String,
    op1: json['op1'] as String?,
    op2: json['op2'] as String?,
    op3: json['op3'] as String?,
    optionList: List<String>.from(json['optionList'] ?? []),
  );

  @override
  String toString() =>
      'QuizModel(question: $question, answer: $answer, options: $optionList)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is QuizModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              question == other.question;

  @override
  int get hashCode => id.hashCode ^ question.hashCode;
}
import 'package:hive/hive.dart';

part 'correct_answer.g.dart';

@HiveType(typeId: 4)
class CorrectAnswer {
  @HiveField(0)
  final Question question;

  @HiveField(1)
  final String firstAns;

  @HiveField(2)
  final String secondAns;

  @HiveField(3)
  final String thirdAns;

  @HiveField(4)
  final String fourthAns;

  @HiveField(5)
  final int answer;

  CorrectAnswer({
    required this.question,
    required this.firstAns,
    required this.secondAns,
    required this.thirdAns,
    required this.fourthAns,
    required this.answer,
  });

  @override
  String toString() =>
      'CorrectAnswer(question: $question, '
          'firstAns: $firstAns, secondAns: $secondAns, '
          'thirdAns: $thirdAns, fourthAns: $fourthAns, answer: $answer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CorrectAnswer &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer;

  @override
  int get hashCode => Object.hash(question, answer);
}

@HiveType(typeId: 5)
class Question {
  @HiveField(0)
  final Operand firstOperand;

  @HiveField(1)
  final String firstOperator;

  @HiveField(2)
  final Operand secondOperand;

  @HiveField(3)
  final String? secondOperator;

  @HiveField(4)
  final Operand? thirdOperand;

  @HiveField(5)
  final int answer;

  Question({
    required this.firstOperand,
    required this.firstOperator,
    required this.secondOperand,
    this.secondOperator,
    this.thirdOperand,
    required this.answer,
  });

  @override
  String toString() =>
      'Question($firstOperand $firstOperator $secondOperand '
          '${secondOperator ?? ""} ${thirdOperand ?? ""} = $answer)';
}

@HiveType(typeId: 6)
class Operand {
  @HiveField(0)
  final String value;

  @HiveField(1)
  final bool isQuestionMark;

  Operand({
    required this.value,
    required this.isQuestionMark,
  });

  @override
  String toString() => isQuestionMark ? "?" : value;
}
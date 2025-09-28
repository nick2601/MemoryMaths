import 'package:hive/hive.dart';

part 'calculator.g.dart';

@HiveType(typeId: 2) // Make sure it's unique in your app
class Calculator {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final int answer;

  Calculator({required this.question, required this.answer});

  @override
  String toString() => 'Calculator{question: $question, answer: $answer}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Calculator &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer; // include answer too

  @override
  int get hashCode => Object.hash(question, answer);
}
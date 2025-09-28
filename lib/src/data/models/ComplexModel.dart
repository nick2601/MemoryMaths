import 'package:hive/hive.dart';

part 'ComplexModel.g.dart';
@HiveType(typeId: 31) // ensure unique typeId
class ComplexModel {
  @HiveField(0)
  final String? question;

  @HiveField(1)
  final String? finalAnswer;

  @HiveField(2)
  final String? answer;

  @HiveField(3)
  final List<String> optionList;

  ComplexModel({
    this.question,
    this.finalAnswer,
    this.answer,
    List<String>? optionList,
  }) : optionList = optionList ?? []; // avoid shared list bug

  @override
  String toString() =>
      'ComplexModel(question: $question, finalAnswer: $finalAnswer, answer: $answer, optionList: $optionList)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ComplexModel &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              finalAnswer == other.finalAnswer &&
              answer == other.answer &&
              optionList.toString() == other.optionList.toString();

  @override
  int get hashCode =>
      Object.hash(question, finalAnswer, answer, optionList.toString());
}
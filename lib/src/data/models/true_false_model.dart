import 'package:hive/hive.dart';

part 'true_false_model.g.dart';

/// Model class representing a True/False quiz question.
/// Supports Hive for local persistence.
@HiveType(typeId: 13) // 👈 ensure a unique typeId across all your models
class TrueFalseModel {
  @HiveField(0)
  String? sign;

  @HiveField(1)
  String? rem;

  @HiveField(2)
  int? id;

  @HiveField(3)
  String? firstDigit;

  @HiveField(4)
  String? secondDigit;

  @HiveField(5)
  String? question;

  @HiveField(6)
  String? answer;

  @HiveField(7)
  String? op1;

  @HiveField(8)
  String? op2;

  @HiveField(9)
  String? op3;

  @HiveField(10)
  List<String> optionList;

  /// Creates a new TrueFalseModel instance.
  TrueFalseModel({
    this.sign,
    this.rem,
    this.id,
    this.firstDigit,
    this.secondDigit,
    this.question,
    this.answer,
    this.op1,
    this.op2,
    this.op3,
    List<String>? optionList,
  }) : optionList = optionList ?? [];

  /// Factory to create from JSON
  factory TrueFalseModel.fromJson(Map<String, dynamic> json) => TrueFalseModel(
    sign: json['sign'] as String?,
    rem: json['rem'] as String?,
    id: json['id'] as int?,
    firstDigit: json['firstDigit'] as String?,
    secondDigit: json['secondDigit'] as String?,
    question: json['question'] as String?,
    answer: json['answer'] as String?,
    op1: json['op1'] as String?,
    op2: json['op2'] as String?,
    op3: json['op3'] as String?,
    optionList: (json['optionList'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList() ??
        [],
  );

  /// Convert to JSON
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

  @override
  String toString() =>
      'TrueFalseModel(id: $id, question: $question, answer: $answer, options: $optionList)';
}
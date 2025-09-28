import 'package:hive/hive.dart';

part 'find_missing_model.g.dart';  // 👈 add this line

@HiveType(typeId: 4) // make sure the typeId is unique
class FindMissingQuizModel {
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
  String? op_1;

  @HiveField(8)
  String? op_2;

  @HiveField(9)
  String? op_3;

  @HiveField(10)
  List<String> optionList;

  FindMissingQuizModel({
    this.sign,
    this.rem,
    this.id,
    this.firstDigit,
    this.secondDigit,
    this.question,
    this.answer,
    this.op_1,
    this.op_2,
    this.op_3,
    List<String>? optionList,
  }) : optionList = optionList ?? [];
}
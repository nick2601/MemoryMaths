import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'duel_score_model.freezed.dart';
part 'duel_score_model.g.dart';

@freezed
@HiveType(typeId: 2) // Make sure typeId is unique across your models
class DuelScoreModel with _$DuelScoreModel {
  const factory DuelScoreModel({
    @HiveField(0) String? title,
    @HiveField(1) String? subTitle,
    @HiveField(2) @Default(0) int score,
  }) = _DuelScoreModel;

  factory DuelScoreModel.fromJson(Map<String, dynamic> json) =>
      _$DuelScoreModelFromJson(json);
}
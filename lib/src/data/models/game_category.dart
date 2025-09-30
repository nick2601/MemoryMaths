import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/score_board.dart';

part 'game_category.g.dart';

/// GameCategory defines the structure and properties of a game category.
/// Each game category represents a unique type of mathematical game or challenge.
@HiveType(typeId: 4) // ⚡ Ensure unique typeId across all models
@JsonSerializable()
class GameCategory {
  /// Unique identifier for the game category
  @HiveField(0)
  final int id;

  /// Display name of the game category
  @HiveField(1)
  final String name;

  /// Unique key identifier used for internal references
  @HiveField(2)
  final String key;

  /// Type of game category, defined in GameCategoryType enum
  @HiveField(3)
  final GameCategoryType gameCategoryType;

  /// Navigation route path for this game category
  @HiveField(4)
  final String routePath;

  /// Scoreboard associated with this game category
  @HiveField(5)
  final ScoreBoard scoreboard;

  /// Icon asset path for the game category
  @HiveField(6)
  final String icon;

  GameCategory({
    required this.id,
    required this.name,
    required this.key,
    required this.gameCategoryType,
    required this.routePath,
    required this.scoreboard,
    required this.icon,
  });

  /// JSON factory for Firebase/API integration
  factory GameCategory.fromJson(Map<String, dynamic> json) =>
      _$GameCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$GameCategoryToJson(this);
}
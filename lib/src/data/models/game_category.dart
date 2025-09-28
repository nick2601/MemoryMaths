import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/score_board.dart';

part 'game_category.freezed.dart';
part 'game_category.g.dart';

/// GameCategory defines the structure and properties of a game category.
/// Each game category represents a unique type of mathematical game or challenge.
@freezed
@HiveType(typeId: 4) // ⚡ Ensure unique typeId across all models
class GameCategory with _$GameCategory {
  /// Creates a new GameCategory instance.
  const factory GameCategory({
    /// Unique identifier for the game category
    @HiveField(0) required int id,

    /// Display name of the game category
    @HiveField(1) required String name,

    /// Unique key identifier used for internal references
    @HiveField(2) required String key,

    /// Type of game category, defined in GameCategoryType enum
    @HiveField(3) required GameCategoryType gameCategoryType,

    /// Navigation route path for this game category
    @HiveField(4) required String routePath,

    /// Scoreboard associated with this game category
    @HiveField(5) required ScoreBoard scoreboard,

    /// Icon asset path for the game category
    @HiveField(6) required String icon,
  }) = _GameCategory;

  /// JSON factory for Firebase/API integration
  factory GameCategory.fromJson(Map<String, dynamic> json) =>
      _$GameCategoryFromJson(json);
}
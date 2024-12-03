/// Model class representing a game category in the Memory Maths application.
/// Contains all necessary information to identify and manage a specific game type.
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/score_board.dart';

/// GameCategory defines the structure and properties of a game category.
/// Each game category represents a unique type of mathematical game or challenge.
class GameCategory {
  /// Unique identifier for the game category
  int id;
  
  /// Display name of the game category
  String name;
  
  /// Unique key identifier used for internal references
  String key;
  
  /// Type of game category, defined in GameCategoryType enum
  GameCategoryType gameCategoryType;
  
  /// Navigation route path for this game category
  String routePath;
  
  /// Scoreboard associated with this game category
  ScoreBoard scoreboard;
  
  /// Icon asset path for the game category
  String icon;

  /// Creates a new GameCategory instance.
  /// 
  /// Parameters:
  /// - [id]: Unique identifier
  /// - [name]: Display name
  /// - [key]: Internal reference key
  /// - [gameCategoryType]: Type of game
  /// - [routePath]: Navigation route
  /// - [scoreboard]: Associated scoreboard
  /// - [icon]: Icon asset path
  GameCategory(
    this.id,
    this.name,
    this.key,
    this.gameCategoryType,
    this.routePath,
    this.scoreboard,
    this.icon,
  );
}

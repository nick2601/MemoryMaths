/// Model class representing an alert request in the game.
/// This class encapsulates information needed to display game alerts and notifications.
import 'package:mathsgames/src/core/app_constant.dart';

/// AlertRequest holds information about game alerts and notifications.
/// Used to communicate game state changes and achievements to the user.
class AlertRequest {
  /// The type of game category this alert is associated with
  final GameCategoryType gameCategoryType;
  
  /// The type of alert to be displayed
  final String type;
  
  /// The score achieved in the game
  final double score;
  
  /// The number of coins earned or affected
  final double coin;
  
  /// Indicates if the game is in a paused state
  final bool isPause;

  /// Creates a new AlertRequest instance.
  /// 
  /// Parameters:
  /// - [type]: The type of alert to be shown
  /// - [gameCategoryType]: The category of game generating this alert
  /// - [score]: The current score in the game
  /// - [coin]: The number of coins involved
  /// - [isPause]: Whether the game is paused
  AlertRequest(
      {required this.type,
      required this.gameCategoryType,
      required this.score,
      required this.coin,
      required this.isPause});
}

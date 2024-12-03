/// Model class representing a player's score board in the game.
/// Manages high scores and tracks if the game is being played for the first time.
class ScoreBoard {
  /// The highest score achieved in the game
  int highestScore;
  
  /// Indicates if this is the first time playing the game
  late bool firstTime;

  /// Creates a new ScoreBoard instance with a required highest score.
  /// 
  /// Parameters:
  /// - [highestScore]: The initial highest score to set
  ScoreBoard({required this.highestScore});

  /// Creates a ScoreBoard instance from a JSON map.
  /// 
  /// Parameters:
  /// - [json]: Map containing the score board data with keys:
  ///   - 'highestScore': The highest score achieved (defaults to 0)
  ///   - 'firstTime': Whether this is the first time playing (defaults to true)
  ScoreBoard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0,
        firstTime = json['firstTime'] ?? true;

  /// Converts the ScoreBoard instance to a JSON map.
  /// 
  /// Returns a Map containing:
  /// - 'highestScore': The current highest score
  /// - 'firstTime': The first time play status
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestScore'] = this.highestScore;
    data['firstTime'] = this.firstTime;
    return data;
  }
}

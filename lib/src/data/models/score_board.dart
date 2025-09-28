import 'package:hive/hive.dart';

part 'score_board.g.dart';

/// Model class representing a player's score board in the game.
/// Manages high scores and tracks if the game is being played for the first time.
@HiveType(typeId: 62) // ⚠️ ensure unique ID across all Hive models
class ScoreBoard {
  /// The highest score achieved in the game
  @HiveField(0)
  final int highestScore;

  /// Indicates if this is the first time playing the game
  @HiveField(1)
  final bool firstTime;

  /// Creates a new ScoreBoard instance.
  const ScoreBoard({
    this.highestScore = 0,
    this.firstTime = true,
  });

  /// Creates a ScoreBoard instance from a JSON map.
  factory ScoreBoard.fromJson(Map<String, dynamic> json) => ScoreBoard(
    highestScore: json['highestScore'] as int? ?? 0,
    firstTime: json['firstTime'] as bool? ?? true,
  );

  /// Converts the ScoreBoard instance to a JSON map.
  Map<String, dynamic> toJson() => {
    'highestScore': highestScore,
    'firstTime': firstTime,
  };

  /// Creates a copy of the ScoreBoard with updated fields.
  ScoreBoard copyWith({
    int? highestScore,
    bool? firstTime,
  }) {
    return ScoreBoard(
      highestScore: highestScore ?? this.highestScore,
      firstTime: firstTime ?? this.firstTime,
    );
  }

  @override
  String toString() =>
      'ScoreBoard(highestScore: $highestScore, firstTime: $firstTime)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ScoreBoard &&
              runtimeType == other.runtimeType &&
              highestScore == other.highestScore &&
              firstTime == other.firstTime;

  @override
  int get hashCode => highestScore.hashCode ^ firstTime.hashCode;
}
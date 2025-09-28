import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mathsgames/src/core/app_constant.dart';

part 'alert_request.g.dart';
/// Model class representing an alert request in the game.
/// Supports Hive persistence & Riverpod state management.
@HiveType(typeId: 0) //
class AlertRequest extends Equatable {
  /// The type of game category this alert is associated with
  @HiveField(0)
  final GameCategoryType gameCategoryType;

  /// The type of alert to be displayed (e.g., "pause", "achievement")
  @HiveField(1)
  final String type;

  /// The score achieved in the game
  @HiveField(2)
  final double score;

  /// The number of coins earned or affected
  @HiveField(3)
  final double coin;

  /// Indicates if the game is in a paused state
  @HiveField(4)
  final bool isPause;

  /// Creates a new AlertRequest instance.
  const AlertRequest({
    required this.type,
    required this.gameCategoryType,
    required this.score,
    required this.coin,
    required this.isPause,
  });

  /// Creates a copy with overridden values (useful for Riverpod notifiers)
  AlertRequest copyWith({
    String? type,
    GameCategoryType? gameCategoryType,
    double? score,
    double? coin,
    bool? isPause,
  }) {
    return AlertRequest(
      type: type ?? this.type,
      gameCategoryType: gameCategoryType ?? this.gameCategoryType,
      score: score ?? this.score,
      coin: coin ?? this.coin,
      isPause: isPause ?? this.isPause,
    );
  }

  @override
  List<Object?> get props => [type, gameCategoryType, score, coin, isPause];

  @override
  String toString() {
    return 'AlertRequest(type: $type, '
        'gameCategoryType: $gameCategoryType, '
        'score: $score, coin: $coin, '
        'isPause: $isPause)';
  }
}
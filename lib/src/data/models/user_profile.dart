import 'package:mathsgames/src/core/app_constant.dart';

/// Model representing a user's profile and gaming statistics
class UserProfile {
  /// User's email address (unique identifier)
  final String email;

  /// User's display name
  final String name;

  /// Date when the user was created
  final DateTime createdAt;

  /// Last time the user played any game
  final DateTime lastPlayedAt;

  /// Total coins earned by the user
  final int totalCoins;

  /// Total games played across all categories
  final int totalGamesPlayed;

  /// Map of game statistics for each game category
  final Map<GameCategoryType, GameStatistics> gameStats;

  /// User's skill level (Beginner, Intermediate, Advanced, Expert)
  final SkillLevel skillLevel;

  const UserProfile({
    required this.email,
    required this.name,
    required this.createdAt,
    required this.lastPlayedAt,
    required this.totalCoins,
    required this.totalGamesPlayed,
    required this.gameStats,
    required this.skillLevel,
  });

  /// Creates UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final gameStatsMap = <GameCategoryType, GameStatistics>{};
    if (json['gameStats'] != null) {
      (json['gameStats'] as Map<String, dynamic>).forEach((key, value) {
        final gameType = GameCategoryType.values.firstWhere(
          (e) => e.toString() == key,
          orElse: () => GameCategoryType.CALCULATOR,
        );
        gameStatsMap[gameType] = GameStatistics.fromJson(value);
      });
    }

    return UserProfile(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastPlayedAt: DateTime.parse(
          json['lastPlayedAt'] ?? DateTime.now().toIso8601String()),
      totalCoins: json['totalCoins'] ?? 0,
      totalGamesPlayed: json['totalGamesPlayed'] ?? 0,
      gameStats: gameStatsMap,
      skillLevel: SkillLevel.values.firstWhere(
        (e) => e.toString() == json['skillLevel'],
        orElse: () => SkillLevel.beginner,
      ),
    );
  }

  /// Converts UserProfile to JSON
  Map<String, dynamic> toJson() {
    final gameStatsJson = <String, dynamic>{};
    gameStats.forEach((key, value) {
      gameStatsJson[key.toString()] = value.toJson();
    });

    return {
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'lastPlayedAt': lastPlayedAt.toIso8601String(),
      'totalCoins': totalCoins,
      'totalGamesPlayed': totalGamesPlayed,
      'gameStats': gameStatsJson,
      'skillLevel': skillLevel.toString(),
    };
  }

  /// Creates a copy of UserProfile with updated values
  UserProfile copyWith({
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? lastPlayedAt,
    int? totalCoins,
    int? totalGamesPlayed,
    Map<GameCategoryType, GameStatistics>? gameStats,
    SkillLevel? skillLevel,
  }) {
    return UserProfile(
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      totalCoins: totalCoins ?? this.totalCoins,
      totalGamesPlayed: totalGamesPlayed ?? this.totalGamesPlayed,
      gameStats: gameStats ?? this.gameStats,
      skillLevel: skillLevel ?? this.skillLevel,
    );
  }

  /// Calculate overall accuracy across all games
  double get overallAccuracy {
    if (gameStats.isEmpty) return 0.0;

    double totalAccuracy = 0.0;
    int gameTypesCount = 0;

    gameStats.values.forEach((stats) {
      if (stats.gamesPlayed > 0) {
        totalAccuracy += stats.accuracy;
        gameTypesCount++;
      }
    });

    return gameTypesCount > 0 ? totalAccuracy / gameTypesCount : 0.0;
  }

  /// Get average score across all games
  double get averageScore {
    if (gameStats.isEmpty) return 0.0;

    double totalAverage = 0.0;
    int gameTypesCount = 0;

    gameStats.values.forEach((stats) {
      if (stats.gamesPlayed > 0) {
        totalAverage += stats.averageScore;
        gameTypesCount++;
      }
    });

    return gameTypesCount > 0 ? totalAverage / gameTypesCount : 0.0;
  }

  /// Get total playing time in minutes
  int get totalPlayTimeMinutes {
    return gameStats.values
        .fold(0, (total, stats) => total + stats.totalPlayTimeMinutes);
  }
}

/// Model representing statistics for a specific game category
class GameStatistics {
  /// Number of games played in this category
  final int gamesPlayed;

  /// Highest score achieved
  final double highestScore;

  /// Lowest score achieved
  final double lowestScore;

  /// Average score
  final double averageScore;

  /// Number of correct answers
  final int correctAnswers;

  /// Number of wrong answers
  final int wrongAnswers;

  /// Total time spent playing this game (in minutes)
  final int totalPlayTimeMinutes;

  /// Highest level reached
  final int highestLevel;

  /// Current level
  final int currentLevel;

  /// List of recent scores (last 10 games)
  final List<GameSession> recentSessions;

  /// Improvement suggestions for this game
  final List<String> suggestions;

  const GameStatistics({
    required this.gamesPlayed,
    required this.highestScore,
    required this.lowestScore,
    required this.averageScore,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalPlayTimeMinutes,
    required this.highestLevel,
    required this.currentLevel,
    required this.recentSessions,
    required this.suggestions,
  });

  /// Calculate accuracy percentage
  double get accuracy {
    final totalAnswers = correctAnswers + wrongAnswers;
    return totalAnswers > 0 ? (correctAnswers / totalAnswers) * 100 : 0.0;
  }

  /// Get improvement trend based on recent sessions
  ImprovementTrend get improvementTrend {
    if (recentSessions.length < 3) return ImprovementTrend.noData;

    final recent = recentSessions.take(3).toList();
    final older = recentSessions.skip(3).take(3).toList();

    if (older.isEmpty) return ImprovementTrend.noData;

    final recentAvg =
        recent.fold<double>(0, (sum, session) => sum + session.score) /
            recent.length;
    final olderAvg =
        older.fold<double>(0, (sum, session) => sum + session.score) /
            older.length;

    final improvement = ((recentAvg - olderAvg) / olderAvg) * 100;

    if (improvement > 10) return ImprovementTrend.improving;
    if (improvement < -10) return ImprovementTrend.declining;
    return ImprovementTrend.stable;
  }

  /// Creates GameStatistics from JSON
  factory GameStatistics.fromJson(Map<String, dynamic> json) {
    final sessionsList = <GameSession>[];
    if (json['recentSessions'] != null) {
      (json['recentSessions'] as List).forEach((sessionJson) {
        sessionsList.add(GameSession.fromJson(sessionJson));
      });
    }

    return GameStatistics(
      gamesPlayed: json['gamesPlayed'] ?? 0,
      highestScore: (json['highestScore'] ?? 0.0).toDouble(),
      lowestScore: (json['lowestScore'] ?? 0.0).toDouble(),
      averageScore: (json['averageScore'] ?? 0.0).toDouble(),
      correctAnswers: json['correctAnswers'] ?? 0,
      wrongAnswers: json['wrongAnswers'] ?? 0,
      totalPlayTimeMinutes: json['totalPlayTimeMinutes'] ?? 0,
      highestLevel: json['highestLevel'] ?? 1,
      currentLevel: json['currentLevel'] ?? 1,
      recentSessions: sessionsList,
      suggestions: List<String>.from(json['suggestions'] ?? []),
    );
  }

  /// Converts GameStatistics to JSON
  Map<String, dynamic> toJson() {
    return {
      'gamesPlayed': gamesPlayed,
      'highestScore': highestScore,
      'lowestScore': lowestScore,
      'averageScore': averageScore,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'totalPlayTimeMinutes': totalPlayTimeMinutes,
      'highestLevel': highestLevel,
      'currentLevel': currentLevel,
      'recentSessions':
          recentSessions.map((session) => session.toJson()).toList(),
      'suggestions': suggestions,
    };
  }

  /// Creates a copy with updated values
  GameStatistics copyWith({
    int? gamesPlayed,
    double? highestScore,
    double? lowestScore,
    double? averageScore,
    int? correctAnswers,
    int? wrongAnswers,
    int? totalPlayTimeMinutes,
    int? highestLevel,
    int? currentLevel,
    List<GameSession>? recentSessions,
    List<String>? suggestions,
  }) {
    return GameStatistics(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      highestScore: highestScore ?? this.highestScore,
      lowestScore: lowestScore ?? this.lowestScore,
      averageScore: averageScore ?? this.averageScore,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      totalPlayTimeMinutes: totalPlayTimeMinutes ?? this.totalPlayTimeMinutes,
      highestLevel: highestLevel ?? this.highestLevel,
      currentLevel: currentLevel ?? this.currentLevel,
      recentSessions: recentSessions ?? this.recentSessions,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

/// Model representing a single game session
class GameSession {
  /// Score achieved in this session
  final double score;

  /// Level played
  final int level;

  /// Date and time when the session was played
  final DateTime playedAt;

  /// Duration of the session in minutes
  final int durationMinutes;

  /// Number of correct answers in this session
  final int correctAnswers;

  /// Number of wrong answers in this session
  final int wrongAnswers;

  const GameSession({
    required this.score,
    required this.level,
    required this.playedAt,
    required this.durationMinutes,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  /// Calculate session accuracy
  double get accuracy {
    final total = correctAnswers + wrongAnswers;
    return total > 0 ? (correctAnswers / total) * 100 : 0.0;
  }

  /// Creates GameSession from JSON
  factory GameSession.fromJson(Map<String, dynamic> json) {
    return GameSession(
      score: (json['score'] ?? 0.0).toDouble(),
      level: json['level'] ?? 1,
      playedAt:
          DateTime.parse(json['playedAt'] ?? DateTime.now().toIso8601String()),
      durationMinutes: json['durationMinutes'] ?? 0,
      correctAnswers: json['correctAnswers'] ?? 0,
      wrongAnswers: json['wrongAnswers'] ?? 0,
    );
  }

  /// Converts GameSession to JSON
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'level': level,
      'playedAt': playedAt.toIso8601String(),
      'durationMinutes': durationMinutes,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
    };
  }
}

/// Enum representing user skill levels
enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

/// Enum representing improvement trends
enum ImprovementTrend {
  improving,
  declining,
  stable,
  noData,
}

/// Extension on SkillLevel for display purposes
extension SkillLevelExtension on SkillLevel {
  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }

  String get description {
    switch (this) {
      case SkillLevel.beginner:
        return 'Just getting started with math games';
      case SkillLevel.intermediate:
        return 'Developing good math skills';
      case SkillLevel.advanced:
        return 'Strong mathematical abilities';
      case SkillLevel.expert:
        return 'Exceptional mathematical prowess';
    }
  }
}

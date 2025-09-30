class ReportConstants {
  static const String userProfilePrefix = 'user_profile_';
  static const String reportHistoryPrefix = 'report_history_';
  static const int maxReportHistory = 10;
  static const int maxRecentSessions = 10;

  // Skill level thresholds
  static const double beginnerThreshold = 70.0;
  static const double intermediateThreshold = 80.0;
  static const double advancedThreshold = 90.0;

  // Achievement thresholds
  static const int consistencyAchievementGames = 7;
  static const double highAccuracyThreshold = 90.0;
  static const double masteryAccuracyThreshold = 95.0;
  static const int masteryMinGames = 10;
}

// User Analytics Events
enum AnalyticsEvent {
  gameStarted,
  gameCompleted,
  levelCompleted,
  achievementEarned,
  reportGenerated,
  skillLevelChanged,
}

// Report Generation Status
enum ReportStatus {
  generating,
  completed,
  error,
  notStarted,
}
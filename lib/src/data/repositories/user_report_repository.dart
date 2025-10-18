import 'dart:convert';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/user_profile.dart';
import 'package:mathsgames/src/data/models/user_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for managing user reports and analytics
class UserReportRepository {
  static const String _userProfileKey = 'user_profile_';
  static const String _reportHistoryKey = 'report_history_';

  /// Generate a comprehensive report for a user
  Future<UserReport> generateUserReport(String email) async {
    final userProfile = await getUserProfile(email);
    if (userProfile == null) {
      throw Exception('User profile not found for email: $email');
    }

    // Generate performance summary
    final overallSummary = _generatePerformanceSummary(userProfile);

    // Generate game-specific reports
    final gameReports = _generateGameReports(userProfile);

    // Generate skill assessment
    final skillAssessment = _generateSkillAssessment(userProfile);

    // Generate learning path
    final learningPath = _generateLearningPath(userProfile, skillAssessment);

    // Generate achievements
    final achievements = _generateAchievements(userProfile);

    final report = UserReport(
      userProfile: userProfile,
      generatedAt: DateTime.now(),
      overallSummary: overallSummary,
      gameReports: gameReports,
      skillAssessment: skillAssessment,
      learningPath: learningPath,
      achievements: achievements,
    );

    // Save report to history
    await _saveReportToHistory(email, report);

    return report;
  }

  /// Get user profile by email
  Future<UserProfile?> getUserProfile(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('$_userProfileKey$email');

    if (profileJson != null) {
      return UserProfile.fromJson(json.decode(profileJson));
    }
    return null;
  }

  /// Save or update user profile
  Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_userProfileKey${profile.email}',
      json.encode(profile.toJson()),
    );
  }

  /// Update user statistics after a game session
  Future<void> updateUserStatistics({
    required String email,
    required GameCategoryType gameType,
    required double score,
    required int level,
    required int correctAnswers,
    required int wrongAnswers,
    required int durationMinutes,
  }) async {
    var userProfile = await getUserProfile(email);

    if (userProfile == null) {
      // Create new user profile
      userProfile = UserProfile(
        email: email,
        name: email.split('@').first,
        createdAt: DateTime.now(),
        lastPlayedAt: DateTime.now(),
        totalCoins: 0,
        totalGamesPlayed: 0,
        gameStats: {},
        skillLevel: SkillLevel.beginner,
      );
    }

    // Create new game session
    final newSession = GameSession(
      score: score,
      level: level,
      playedAt: DateTime.now(),
      durationMinutes: durationMinutes,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
    );

    // Update game statistics
    final currentStats = userProfile.gameStats[gameType] ??
        GameStatistics(
          gamesPlayed: 0,
          highestScore: 0.0,
          lowestScore: double.infinity,
          averageScore: 0.0,
          correctAnswers: 0,
          wrongAnswers: 0,
          totalPlayTimeMinutes: 0,
          highestLevel: 1,
          currentLevel: 1,
          recentSessions: [],
          suggestions: [],
        );

    // Calculate new statistics
    final newGamesPlayed = currentStats.gamesPlayed + 1;
    final newHighestScore =
        score > currentStats.highestScore ? score : currentStats.highestScore;
    final newLowestScore = currentStats.lowestScore == double.infinity
        ? score
        : (score < currentStats.lowestScore ? score : currentStats.lowestScore);
    final newAverageScore =
        ((currentStats.averageScore * currentStats.gamesPlayed) + score) /
            newGamesPlayed;
    final newCorrectAnswers = currentStats.correctAnswers + correctAnswers;
    final newWrongAnswers = currentStats.wrongAnswers + wrongAnswers;
    final newTotalPlayTime =
        currentStats.totalPlayTimeMinutes + durationMinutes;
    final newHighestLevel =
        level > currentStats.highestLevel ? level : currentStats.highestLevel;

    // Update recent sessions (keep last 10)
    final newRecentSessions =
        [newSession, ...currentStats.recentSessions].take(10).toList();

    // Generate suggestions
    final newSuggestions =
        _generateSuggestions(gameType, newSession, currentStats);

    final updatedStats = GameStatistics(
      gamesPlayed: newGamesPlayed,
      highestScore: newHighestScore,
      lowestScore: newLowestScore,
      averageScore: newAverageScore,
      correctAnswers: newCorrectAnswers,
      wrongAnswers: newWrongAnswers,
      totalPlayTimeMinutes: newTotalPlayTime,
      highestLevel: newHighestLevel,
      currentLevel: level,
      recentSessions: newRecentSessions,
      suggestions: newSuggestions,
    );

    // Update user profile
    final updatedGameStats =
        Map<GameCategoryType, GameStatistics>.from(userProfile.gameStats);
    updatedGameStats[gameType] = updatedStats;

    final updatedProfile = userProfile.copyWith(
      lastPlayedAt: DateTime.now(),
      totalGamesPlayed: userProfile.totalGamesPlayed + 1,
      gameStats: updatedGameStats,
      skillLevel: _calculateSkillLevel(updatedGameStats),
    );

    await saveUserProfile(updatedProfile);
  }

  /// Get report history for a user
  Future<List<UserReport>> getReportHistory(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('$_reportHistoryKey$email');

    if (historyJson != null) {
      final historyList = json.decode(historyJson) as List;
      return historyList
          .map((reportJson) => UserReport.fromJson(reportJson))
          .toList();
    }
    return [];
  }

  /// Delete all stored analytics data for a user (profile + report history).
  Future<void> deleteUserData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_userProfileKey$email');
    await prefs.remove('$_reportHistoryKey$email');
  }

  /// Generate performance summary
  PerformanceSummary _generatePerformanceSummary(UserProfile userProfile) {
    final totalGamesPlayed = userProfile.totalGamesPlayed;
    final overallAccuracy = userProfile.overallAccuracy;
    final averageScore = userProfile.averageScore;
    final totalPlayTime = userProfile.totalPlayTimeMinutes;

    // Calculate strongest and weakest categories
    final sortedByAccuracy = userProfile.gameStats.entries.toList()
      ..sort((a, b) => b.value.accuracy.compareTo(a.value.accuracy));

    final strongestCategories =
        sortedByAccuracy.take(3).map((e) => e.key).toList();
    final improvementAreas =
        sortedByAccuracy.reversed.take(3).map((e) => e.key).toList();

    // Calculate progress to next level
    final progressToNextLevel =
        _calculateProgressToNextLevel(userProfile.skillLevel, overallAccuracy);

    return PerformanceSummary(
      totalGamesPlayed: totalGamesPlayed,
      overallAccuracy: overallAccuracy,
      averageScore: averageScore,
      totalPlayTime: totalPlayTime,
      currentSkillLevel: userProfile.skillLevel,
      progressToNextLevel: progressToNextLevel,
      strongestCategories: strongestCategories,
      improvementAreas: improvementAreas,
    );
  }

  /// Generate game-specific reports
  Map<GameCategoryType, GamePerformanceReport> _generateGameReports(
      UserProfile userProfile) {
    final gameReports = <GameCategoryType, GamePerformanceReport>{};

    userProfile.gameStats.forEach((gameType, statistics) {
      final performanceGrade = _calculatePerformanceGrade(statistics);
      final strengths = _identifyStrengths(gameType, statistics);
      final improvementAreas = _identifyImprovementAreas(gameType, statistics);
      final recommendedActivities =
          _generateRecommendedActivities(gameType, statistics);
      final goals = _generateImprovementGoals(gameType, statistics);

      gameReports[gameType] = GamePerformanceReport(
        gameType: gameType,
        statistics: statistics,
        performanceGrade: performanceGrade,
        trend: statistics.improvementTrend,
        strengths: strengths,
        improvementAreas: improvementAreas,
        recommendedActivities: recommendedActivities,
        goals: goals,
      );
    });

    return gameReports;
  }

  /// Generate skill assessment
  SkillAssessment _generateSkillAssessment(UserProfile userProfile) {
    final skillAreas = <MathSkillArea, SkillLevel>{};

    // Assess different math skill areas based on game performance
    skillAreas[MathSkillArea.arithmetic] = _assessArithmeticSkill(userProfile);
    skillAreas[MathSkillArea.memory] = _assessMemorySkill(userProfile);
    skillAreas[MathSkillArea.speed] = _assessSpeedSkill(userProfile);
    skillAreas[MathSkillArea.logic] = _assessLogicSkill(userProfile);
    skillAreas[MathSkillArea.patterns] = _assessPatternSkill(userProfile);

    // Assess cognitive abilities
    final cognitiveAbilities = _assessCognitiveAbilities(userProfile);

    // Determine learning style
    final learningStyle = _determineLearningStyle(userProfile);

    // Identify focus areas
    final focusAreas = _identifyFocusAreas(skillAreas);

    return SkillAssessment(
      skillAreas: skillAreas,
      cognitiveAbilities: cognitiveAbilities,
      learningStyle: learningStyle,
      focusAreas: focusAreas,
    );
  }

  /// Generate learning path
  LearningPath _generateLearningPath(
      UserProfile userProfile, SkillAssessment skillAssessment) {
    final currentPhase = _determineCurrentPhase(userProfile, skillAssessment);
    final nextSteps = _generateNextSteps(currentPhase, skillAssessment);
    final estimatedCompletionTime = _estimateCompletionTime(nextSteps);
    final phaseProgress = _calculatePhaseProgress(userProfile, currentPhase);

    return LearningPath(
      currentPhase: currentPhase,
      nextSteps: nextSteps,
      estimatedCompletionTime: estimatedCompletionTime,
      phaseProgress: phaseProgress,
    );
  }

  /// Generate achievements
  List<Achievement> _generateAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];

    // Check various achievement criteria
    achievements.addAll(_checkScoreAchievements(userProfile));
    achievements.addAll(_checkAccuracyAchievements(userProfile));
    achievements.addAll(_checkConsistencyAchievements(userProfile));
    achievements.addAll(_checkImprovementAchievements(userProfile));
    achievements.addAll(_checkMasteryAchievements(userProfile));

    return achievements;
  }

  /// Helper methods for calculations and assessments

  SkillLevel _calculateSkillLevel(
      Map<GameCategoryType, GameStatistics> gameStats) {
    if (gameStats.isEmpty) return SkillLevel.beginner;

    final avgAccuracy =
        gameStats.values.fold<double>(0, (sum, stats) => sum + stats.accuracy) /
            gameStats.length;
    final avgScore = gameStats.values
            .fold<double>(0, (sum, stats) => sum + stats.averageScore) /
        gameStats.length;
    final totalGames =
        gameStats.values.fold<int>(0, (sum, stats) => sum + stats.gamesPlayed);

    if (avgAccuracy >= 90 && avgScore >= 80 && totalGames >= 50)
      return SkillLevel.expert;
    if (avgAccuracy >= 80 && avgScore >= 60 && totalGames >= 30)
      return SkillLevel.advanced;
    if (avgAccuracy >= 70 && avgScore >= 40 && totalGames >= 15)
      return SkillLevel.intermediate;
    return SkillLevel.beginner;
  }

  double _calculateProgressToNextLevel(
      SkillLevel currentLevel, double accuracy) {
    switch (currentLevel) {
      case SkillLevel.beginner:
        return (accuracy / 70) * 100;
      case SkillLevel.intermediate:
        return ((accuracy - 70) / 10) * 100;
      case SkillLevel.advanced:
        return ((accuracy - 80) / 10) * 100;
      case SkillLevel.expert:
        return 100.0;
    }
  }

  String _calculatePerformanceGrade(GameStatistics statistics) {
    final accuracy = statistics.accuracy;
    if (accuracy >= 95) return 'A+';
    if (accuracy >= 90) return 'A';
    if (accuracy >= 85) return 'B+';
    if (accuracy >= 80) return 'B';
    if (accuracy >= 75) return 'C+';
    if (accuracy >= 70) return 'C';
    if (accuracy >= 60) return 'D';
    return 'F';
  }

  List<String> _generateSuggestions(GameCategoryType gameType,
      GameSession session, GameStatistics currentStats) {
    final suggestions = <String>[];

    // Accuracy-based suggestions
    if (session.accuracy < 70) {
      suggestions.add(
          'Focus on accuracy over speed - take your time to think through each problem');
      suggestions
          .add('Practice similar problems at lower levels to build confidence');
    }

    // Speed-based suggestions
    if (session.durationMinutes > 10) {
      suggestions.add(
          'Try to solve problems more quickly - practice mental math techniques');
    }

    // Game-specific suggestions
    switch (gameType) {
      case GameCategoryType.CALCULATOR:
        suggestions
            .add('Practice basic arithmetic operations without calculator');
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        suggestions.add('Work on memorizing multiplication tables');
        suggestions.add(
            'Practice breaking down complex calculations into simpler steps');
        break;
      case GameCategoryType.NUMERIC_MEMORY:
        suggestions
            .add('Try visualization techniques to remember number sequences');
        suggestions.add('Practice chunking numbers into smaller groups');
        break;
      default:
        suggestions.add('Keep practicing regularly to improve your skills');
    }

    return suggestions.take(3).toList();
  }

  // Assessment helper methods

  SkillLevel _assessArithmeticSkill(UserProfile userProfile) {
    final arithmeticGames = [
      GameCategoryType.CALCULATOR,
      GameCategoryType.MENTAL_ARITHMETIC,
      GameCategoryType.QUICK_CALCULATION,
    ];

    double avgAccuracy = 0;
    int gameCount = 0;

    for (final gameType in arithmeticGames) {
      final stats = userProfile.gameStats[gameType];
      if (stats != null && stats.gamesPlayed > 0) {
        avgAccuracy += stats.accuracy;
        gameCount++;
      }
    }

    if (gameCount == 0) return SkillLevel.beginner;
    avgAccuracy /= gameCount;

    if (avgAccuracy >= 85) return SkillLevel.expert;
    if (avgAccuracy >= 75) return SkillLevel.advanced;
    if (avgAccuracy >= 65) return SkillLevel.intermediate;
    return SkillLevel.beginner;
  }

  SkillLevel _assessMemorySkill(UserProfile userProfile) {
    final memoryGames = [
      GameCategoryType.NUMERIC_MEMORY,
      GameCategoryType.CONCENTRATION
    ];
    return _assessSkillByGameTypes(userProfile, memoryGames);
  }

  SkillLevel _assessSpeedSkill(UserProfile userProfile) {
    final speedGames = [GameCategoryType.QUICK_CALCULATION];
    return _assessSkillByGameTypes(userProfile, speedGames);
  }

  SkillLevel _assessLogicSkill(UserProfile userProfile) {
    final logicGames = [
      GameCategoryType.TRUE_FALSE,
      GameCategoryType.FIND_MISSING,
      GameCategoryType.PICTURE_PUZZLE,
    ];
    return _assessSkillByGameTypes(userProfile, logicGames);
  }

  SkillLevel _assessPatternSkill(UserProfile userProfile) {
    final patternGames = [
      GameCategoryType.MAGIC_TRIANGLE,
      GameCategoryType.NUMBER_PYRAMID,
      GameCategoryType.MATH_GRID,
    ];
    return _assessSkillByGameTypes(userProfile, patternGames);
  }

  SkillLevel _assessSkillByGameTypes(
      UserProfile userProfile, List<GameCategoryType> gameTypes) {
    double avgAccuracy = 0;
    int gameCount = 0;

    for (final gameType in gameTypes) {
      final stats = userProfile.gameStats[gameType];
      if (stats != null && stats.gamesPlayed > 0) {
        avgAccuracy += stats.accuracy;
        gameCount++;
      }
    }

    if (gameCount == 0) return SkillLevel.beginner;
    avgAccuracy /= gameCount;

    if (avgAccuracy >= 85) return SkillLevel.expert;
    if (avgAccuracy >= 75) return SkillLevel.advanced;
    if (avgAccuracy >= 65) return SkillLevel.intermediate;
    return SkillLevel.beginner;
  }

  CognitiveAbilities _assessCognitiveAbilities(UserProfile userProfile) {
    // Assess based on game performance
    final memoryScore = _calculateMemoryScore(userProfile);
    final processingSpeed = _calculateProcessingSpeed(userProfile);
    final attentionSpan = _calculateAttentionSpan(userProfile);
    final problemSolving = _calculateProblemSolvingScore(userProfile);
    final patternRecognition = _calculatePatternRecognitionScore(userProfile);

    return CognitiveAbilities(
      memoryScore: memoryScore,
      processingSpeed: processingSpeed,
      attentionSpan: attentionSpan,
      problemSolving: problemSolving,
      patternRecognition: patternRecognition,
    );
  }

  double _calculateMemoryScore(UserProfile userProfile) {
    final memoryStats = userProfile.gameStats[GameCategoryType.NUMERIC_MEMORY];
    if (memoryStats == null) return 50.0;
    return memoryStats.accuracy.clamp(0.0, 100.0);
  }

  double _calculateProcessingSpeed(UserProfile userProfile) {
    final quickCalcStats =
        userProfile.gameStats[GameCategoryType.QUICK_CALCULATION];
    if (quickCalcStats == null) return 50.0;
    // Higher accuracy with less time indicates better processing speed
    return (quickCalcStats.accuracy * 0.8 + 20).clamp(0.0, 100.0);
  }

  double _calculateAttentionSpan(UserProfile userProfile) {
    // Calculate based on consistency across different games
    if (userProfile.gameStats.isEmpty) return 50.0;

    final accuracyVariance = _calculateAccuracyVariance(userProfile);
    return (100 - accuracyVariance).clamp(0.0, 100.0);
  }

  double _calculateProblemSolvingScore(UserProfile userProfile) {
    final problemSolvingGames = [
      GameCategoryType.TRUE_FALSE,
      GameCategoryType.FIND_MISSING,
      GameCategoryType.PICTURE_PUZZLE,
    ];

    double avgAccuracy = 0;
    int gameCount = 0;

    for (final gameType in problemSolvingGames) {
      final stats = userProfile.gameStats[gameType];
      if (stats != null && stats.gamesPlayed > 0) {
        avgAccuracy += stats.accuracy;
        gameCount++;
      }
    }

    return gameCount > 0 ? (avgAccuracy / gameCount).clamp(0.0, 100.0) : 50.0;
  }

  double _calculatePatternRecognitionScore(UserProfile userProfile) {
    final patternGames = [
      GameCategoryType.MAGIC_TRIANGLE,
      GameCategoryType.NUMBER_PYRAMID,
    ];

    double avgAccuracy = 0;
    int gameCount = 0;

    for (final gameType in patternGames) {
      final stats = userProfile.gameStats[gameType];
      if (stats != null && stats.gamesPlayed > 0) {
        avgAccuracy += stats.accuracy;
        gameCount++;
      }
    }

    return gameCount > 0 ? (avgAccuracy / gameCount).clamp(0.0, 100.0) : 50.0;
  }

  double _calculateAccuracyVariance(UserProfile userProfile) {
    final accuracies = userProfile.gameStats.values
        .where((stats) => stats.gamesPlayed > 0)
        .map((stats) => stats.accuracy)
        .toList();

    if (accuracies.length < 2) return 0.0;

    final mean = accuracies.reduce((a, b) => a + b) / accuracies.length;
    final variance = accuracies
            .map((accuracy) => (accuracy - mean) * (accuracy - mean))
            .reduce((a, b) => a + b) /
        accuracies.length;

    return variance;
  }

  LearningStyle _determineLearningStyle(UserProfile userProfile) {
    // Analyze game preferences and performance patterns
    // This is a simplified implementation
    return LearningStyle.visual; // Default for math games
  }

  List<MathSkillArea> _identifyFocusAreas(
      Map<MathSkillArea, SkillLevel> skillAreas) {
    return skillAreas.entries
        .where((entry) =>
            entry.value == SkillLevel.beginner ||
            entry.value == SkillLevel.intermediate)
        .map((entry) => entry.key)
        .take(3)
        .toList();
  }

  // Additional helper methods for learning path generation

  LearningPhase _determineCurrentPhase(
      UserProfile userProfile, SkillAssessment skillAssessment) {
    final overallSkillLevel = userProfile.skillLevel;

    switch (overallSkillLevel) {
      case SkillLevel.beginner:
        return LearningPhase.foundation;
      case SkillLevel.intermediate:
        return LearningPhase.development;
      case SkillLevel.advanced:
        return LearningPhase.mastery;
      case SkillLevel.expert:
        return LearningPhase.expert;
    }
  }

  List<LearningStep> _generateNextSteps(
      LearningPhase currentPhase, SkillAssessment skillAssessment) {
    final steps = <LearningStep>[];

    switch (currentPhase) {
      case LearningPhase.foundation:
        steps.addAll(_getFoundationSteps(skillAssessment));
        break;
      case LearningPhase.development:
        steps.addAll(_getDevelopmentSteps(skillAssessment));
        break;
      case LearningPhase.mastery:
        steps.addAll(_getMasterySteps(skillAssessment));
        break;
      case LearningPhase.expert:
        steps.addAll(_getExpertSteps(skillAssessment));
        break;
    }

    return steps;
  }

  List<LearningStep> _getFoundationSteps(SkillAssessment skillAssessment) {
    return [
      const LearningStep(
        title: 'Master Basic Arithmetic',
        description:
            'Practice addition, subtraction, multiplication, and division',
        gameCategories: [
          GameCategoryType.CALCULATOR,
          GameCategoryType.MENTAL_ARITHMETIC
        ],
        estimatedMinutes: 30,
        priority: 5,
      ),
      const LearningStep(
        title: 'Improve Number Recognition',
        description: 'Work on quickly identifying and remembering numbers',
        gameCategories: [GameCategoryType.NUMERIC_MEMORY],
        estimatedMinutes: 20,
        priority: 4,
      ),
    ];
  }

  List<LearningStep> _getDevelopmentSteps(SkillAssessment skillAssessment) {
    return [
      const LearningStep(
        title: 'Speed Up Calculations',
        description:
            'Focus on solving problems quickly while maintaining accuracy',
        gameCategories: [GameCategoryType.QUICK_CALCULATION],
        estimatedMinutes: 25,
        priority: 5,
      ),
      const LearningStep(
        title: 'Pattern Recognition',
        description: 'Learn to identify mathematical patterns and sequences',
        gameCategories: [
          GameCategoryType.MAGIC_TRIANGLE,
          GameCategoryType.NUMBER_PYRAMID
        ],
        estimatedMinutes: 35,
        priority: 4,
      ),
    ];
  }

  List<LearningStep> _getMasterySteps(SkillAssessment skillAssessment) {
    return [
      const LearningStep(
        title: 'Complex Problem Solving',
        description: 'Tackle challenging multi-step problems',
        gameCategories: [GameCategoryType.COMPLEX_CALCULATION],
        estimatedMinutes: 40,
        priority: 5,
      ),
    ];
  }

  List<LearningStep> _getExpertSteps(SkillAssessment skillAssessment) {
    return [
      const LearningStep(
        title: 'Maintain Excellence',
        description: 'Continue practicing to maintain your expert level',
        gameCategories: GameCategoryType.values,
        estimatedMinutes: 60,
        priority: 3,
      ),
    ];
  }

  int _estimateCompletionTime(List<LearningStep> steps) {
    return steps.fold<int>(0, (total, step) => total + step.estimatedMinutes);
  }

  double _calculatePhaseProgress(UserProfile userProfile, LearningPhase phase) {
    // Calculate progress based on skill level and accuracy
    final accuracy = userProfile.overallAccuracy;

    switch (phase) {
      case LearningPhase.foundation:
        return (accuracy / 70) * 100;
      case LearningPhase.development:
        return ((accuracy - 70) / 15) * 100;
      case LearningPhase.mastery:
        return ((accuracy - 85) / 10) * 100;
      case LearningPhase.expert:
        return 100.0;
    }
  }

  // Achievement generation methods

  List<Achievement> _checkScoreAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];
    final now = DateTime.now();

    // High score achievements
    if (userProfile.gameStats.values
        .any((stats) => stats.highestScore >= 100)) {
      achievements.add(Achievement(
        id: 'score_100',
        name: 'Century Scorer',
        description: 'Achieved a score of 100 or higher',
        icon: 'trophy',
        achievedAt: now,
        category: AchievementCategory.general,
        rarity: AchievementRarity.uncommon,
      ));
    }

    return achievements;
  }

  List<Achievement> _checkAccuracyAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];
    final now = DateTime.now();

    if (userProfile.overallAccuracy >= 90) {
      achievements.add(Achievement(
        id: 'accuracy_90',
        name: 'Precision Master',
        description: 'Maintained 90% or higher accuracy',
        icon: 'target',
        achievedAt: now,
        category: AchievementCategory.accuracy,
        rarity: AchievementRarity.rare,
      ));
    }

    return achievements;
  }

  List<Achievement> _checkConsistencyAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];
    final now = DateTime.now();

    // Check for playing multiple days in a row
    if (userProfile.totalGamesPlayed >= 7) {
      achievements.add(Achievement(
        id: 'consistency_week',
        name: 'Dedicated Learner',
        description: 'Played for 7 or more sessions',
        icon: 'calendar',
        achievedAt: now,
        category: AchievementCategory.consistency,
        rarity: AchievementRarity.common,
      ));
    }

    return achievements;
  }

  List<Achievement> _checkImprovementAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];

    // Check for improvement trends in recent games
    userProfile.gameStats.forEach((gameType, stats) {
      if (stats.improvementTrend == ImprovementTrend.improving) {
        achievements.add(Achievement(
          id: 'improvement_${gameType.toString()}',
          name: 'Rising Star',
          description: 'Showing improvement in ${gameType.toString()}',
          icon: 'trending_up',
          achievedAt: DateTime.now(),
          category: AchievementCategory.improvement,
          rarity: AchievementRarity.common,
        ));
      }
    });

    return achievements;
  }

  List<Achievement> _checkMasteryAchievements(UserProfile userProfile) {
    final achievements = <Achievement>[];
    final now = DateTime.now();

    // Check for mastery in specific game types
    userProfile.gameStats.forEach((gameType, stats) {
      if (stats.accuracy >= 95 && stats.gamesPlayed >= 10) {
        achievements.add(Achievement(
          id: 'mastery_${gameType.toString()}',
          name: '${gameCategoryTypeToString(gameType)} Master',
          description:
              'Achieved mastery in ${gameCategoryTypeToString(gameType)}',
          icon: 'star',
          achievedAt: now,
          category: AchievementCategory.mastery,
          rarity: AchievementRarity.epic,
        ));
      }
    });

    return achievements;
  }

  // Additional helper methods for report generation

  List<String> _identifyStrengths(
      GameCategoryType gameType, GameStatistics statistics) {
    final strengths = <String>[];

    if (statistics.accuracy >= 85) {
      strengths.add('High accuracy - you rarely make mistakes');
    }

    if (statistics.improvementTrend == ImprovementTrend.improving) {
      strengths.add('Consistent improvement over time');
    }

    if (statistics.highestLevel >= 10) {
      strengths.add('Advanced problem-solving ability');
    }

    return strengths;
  }

  List<String> _identifyImprovementAreas(
      GameCategoryType gameType, GameStatistics statistics) {
    final areas = <String>[];

    if (statistics.accuracy < 70) {
      areas.add('Accuracy needs improvement - focus on careful calculation');
    }

    if (statistics.improvementTrend == ImprovementTrend.declining) {
      areas.add('Recent performance has declined - may need more practice');
    }

    if (statistics.gamesPlayed < 5) {
      areas.add('More practice needed to develop consistency');
    }

    return areas;
  }

  List<String> _generateRecommendedActivities(
      GameCategoryType gameType, GameStatistics statistics) {
    final activities = <String>[];

    switch (gameType) {
      case GameCategoryType.CALCULATOR:
        activities.add('Practice mental math without calculator');
        activities.add('Work on basic arithmetic drills');
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        activities.add('Memorize multiplication tables');
        activities.add('Practice estimation techniques');
        break;
      case GameCategoryType.NUMERIC_MEMORY:
        activities.add('Use memory palace technique');
        activities.add('Practice chunking numbers');
        break;
      default:
        activities.add('Regular practice sessions');
        activities.add('Focus on weak areas identified in analysis');
    }

    return activities;
  }

  List<ImprovementGoal> _generateImprovementGoals(
      GameCategoryType gameType, GameStatistics statistics) {
    final goals = <ImprovementGoal>[];
    final targetDate = DateTime.now().add(const Duration(days: 30));

    // Accuracy goal
    if (statistics.accuracy < 90) {
      goals.add(ImprovementGoal(
        description: 'Improve accuracy in ${gameType.toString()}',
        targetMetric: 'accuracy',
        currentValue: statistics.accuracy,
        targetValue: (statistics.accuracy + 10).clamp(0, 100),
        targetDate: targetDate,
        isAchieved: false,
      ));
    }

    // Level goal
    if (statistics.highestLevel < 15) {
      goals.add(ImprovementGoal(
        description: 'Reach higher level in ${gameType.toString()}',
        targetMetric: 'level',
        currentValue: statistics.highestLevel.toDouble(),
        targetValue: (statistics.highestLevel + 3).toDouble(),
        targetDate: targetDate,
        isAchieved: false,
      ));
    }

    return goals;
  }

  /// Save report to history
  Future<void> _saveReportToHistory(String email, UserReport report) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getReportHistory(email);

    // Keep only last 10 reports
    final updatedHistory = [report, ...history].take(10).toList();

    await prefs.setString(
      '$_reportHistoryKey$email',
      json.encode(updatedHistory.map((r) => r.toJson()).toList()),
    );
  }
}

/// Converts a [GameCategoryType] enum to a user-friendly string.
String gameCategoryTypeToString(GameCategoryType gameType) {
  switch (gameType) {
    case GameCategoryType.CALCULATOR:
      return 'Calculator';
    case GameCategoryType.GUESS_SIGN:
      return 'Guess The Sign';
    case GameCategoryType.SQUARE_ROOT:
      return 'Square Root';
    case GameCategoryType.MATH_PAIRS:
      return 'Math Pairs';
    case GameCategoryType.CORRECT_ANSWER:
      return 'Correct Answer';
    case GameCategoryType.MAGIC_TRIANGLE:
      return 'Magic Triangle';
    case GameCategoryType.MENTAL_ARITHMETIC:
      return 'Mental Arithmetic';
    case GameCategoryType.QUICK_CALCULATION:
      return 'Quick Calculation';
    case GameCategoryType.FIND_MISSING:
      return 'Find The Missing';
    case GameCategoryType.TRUE_FALSE:
      return 'True or False';
    case GameCategoryType.MATH_GRID:
      return 'Math Grid';
    case GameCategoryType.PICTURE_PUZZLE:
      return 'Picture Puzzle';
    case GameCategoryType.NUMBER_PYRAMID:
      return 'Number Pyramid';
    case GameCategoryType.DUAL_GAME:
      return 'Dual Game';
    case GameCategoryType.COMPLEX_CALCULATION:
      return 'Complex Calculation';
    case GameCategoryType.CUBE_ROOT:
      return 'Cube Root';
    case GameCategoryType.CONCENTRATION:
      return 'Concentration';
    case GameCategoryType.NUMERIC_MEMORY:
      return 'Numeric Memory';
    default:
      // Fallback for any unhandled cases
      return gameType.toString().split('.').last.replaceAll('_', ' ');
  }
}

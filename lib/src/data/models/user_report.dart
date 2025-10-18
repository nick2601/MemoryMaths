import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/user_profile.dart';

/// Model representing a comprehensive user performance report
class UserReport {
  /// User profile data
  final UserProfile userProfile;

  /// Date when the report was generated
  final DateTime generatedAt;

  /// Overall performance summary
  final PerformanceSummary overallSummary;

  /// Performance breakdown by game category
  final Map<GameCategoryType, GamePerformanceReport> gameReports;

  /// Skill assessment and recommendations
  final SkillAssessment skillAssessment;

  /// Learning path recommendations
  final LearningPath learningPath;

  /// Achievement badges earned
  final List<Achievement> achievements;

  const UserReport({
    required this.userProfile,
    required this.generatedAt,
    required this.overallSummary,
    required this.gameReports,
    required this.skillAssessment,
    required this.learningPath,
    required this.achievements,
  });

  /// Creates UserReport from JSON
  factory UserReport.fromJson(Map<String, dynamic> json) {
    final gameReportsMap = <GameCategoryType, GamePerformanceReport>{};
    if (json['gameReports'] != null) {
      (json['gameReports'] as Map<String, dynamic>).forEach((key, value) {
        final gameType = GameCategoryType.values.firstWhere(
          (e) => e.toString() == key,
          orElse: () => GameCategoryType.CALCULATOR,
        );
        gameReportsMap[gameType] = GamePerformanceReport.fromJson(value);
      });
    }

    final achievementsList = <Achievement>[];
    if (json['achievements'] != null) {
      (json['achievements'] as List).forEach((achievementJson) {
        achievementsList.add(Achievement.fromJson(achievementJson));
      });
    }

    return UserReport(
      userProfile: UserProfile.fromJson(json['userProfile']),
      generatedAt: DateTime.parse(json['generatedAt']),
      overallSummary: PerformanceSummary.fromJson(json['overallSummary']),
      gameReports: gameReportsMap,
      skillAssessment: SkillAssessment.fromJson(json['skillAssessment']),
      learningPath: LearningPath.fromJson(json['learningPath']),
      achievements: achievementsList,
    );
  }

  /// Converts UserReport to JSON
  Map<String, dynamic> toJson() {
    final gameReportsJson = <String, dynamic>{};
    gameReports.forEach((key, value) {
      gameReportsJson[key.toString()] = value.toJson();
    });

    return {
      'userProfile': userProfile.toJson(),
      'generatedAt': generatedAt.toIso8601String(),
      'overallSummary': overallSummary.toJson(),
      'gameReports': gameReportsJson,
      'skillAssessment': skillAssessment.toJson(),
      'learningPath': learningPath.toJson(),
      'achievements': achievements.map((a) => a.toJson()).toList(),
    };
  }
}

/// Model representing overall performance summary
class PerformanceSummary {
  /// Total games played across all categories
  final int totalGamesPlayed;

  /// Overall accuracy percentage
  final double overallAccuracy;

  /// Average score across all games
  final double averageScore;

  /// Total time spent playing (in minutes)
  final int totalPlayTime;

  /// Current skill level
  final SkillLevel currentSkillLevel;

  /// Progress towards next skill level (0-100)
  final double progressToNextLevel;

  /// Strongest game categories
  final List<GameCategoryType> strongestCategories;

  /// Weakest game categories that need improvement
  final List<GameCategoryType> improvementAreas;

  const PerformanceSummary({
    required this.totalGamesPlayed,
    required this.overallAccuracy,
    required this.averageScore,
    required this.totalPlayTime,
    required this.currentSkillLevel,
    required this.progressToNextLevel,
    required this.strongestCategories,
    required this.improvementAreas,
  });

  /// Creates PerformanceSummary from JSON
  factory PerformanceSummary.fromJson(Map<String, dynamic> json) {
    final strongestList = <GameCategoryType>[];
    if (json['strongestCategories'] != null) {
      (json['strongestCategories'] as List).forEach((item) {
        strongestList.add(GameCategoryType.values.firstWhere(
          (e) => e.toString() == item,
          orElse: () => GameCategoryType.CALCULATOR,
        ));
      });
    }

    final improvementList = <GameCategoryType>[];
    if (json['improvementAreas'] != null) {
      (json['improvementAreas'] as List).forEach((item) {
        improvementList.add(GameCategoryType.values.firstWhere(
          (e) => e.toString() == item,
          orElse: () => GameCategoryType.CALCULATOR,
        ));
      });
    }

    return PerformanceSummary(
      totalGamesPlayed: json['totalGamesPlayed'] ?? 0,
      overallAccuracy: (json['overallAccuracy'] ?? 0.0).toDouble(),
      averageScore: (json['averageScore'] ?? 0.0).toDouble(),
      totalPlayTime: json['totalPlayTime'] ?? 0,
      currentSkillLevel: SkillLevel.values.firstWhere(
        (e) => e.toString() == json['currentSkillLevel'],
        orElse: () => SkillLevel.beginner,
      ),
      progressToNextLevel: (json['progressToNextLevel'] ?? 0.0).toDouble(),
      strongestCategories: strongestList,
      improvementAreas: improvementList,
    );
  }

  /// Converts PerformanceSummary to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalGamesPlayed': totalGamesPlayed,
      'overallAccuracy': overallAccuracy,
      'averageScore': averageScore,
      'totalPlayTime': totalPlayTime,
      'currentSkillLevel': currentSkillLevel.toString(),
      'progressToNextLevel': progressToNextLevel,
      'strongestCategories':
          strongestCategories.map((c) => c.toString()).toList(),
      'improvementAreas': improvementAreas.map((c) => c.toString()).toList(),
    };
  }
}

/// Model representing performance report for a specific game category
class GamePerformanceReport {
  /// Game category type
  final GameCategoryType gameType;

  /// Current statistics for this game
  final GameStatistics statistics;

  /// Performance grade (A+, A, B+, B, C+, C, D, F)
  final String performanceGrade;

  /// Performance trend over time
  final ImprovementTrend trend;

  /// Specific strengths in this game
  final List<String> strengths;

  /// Areas that need improvement
  final List<String> improvementAreas;

  /// Recommended practice activities
  final List<String> recommendedActivities;

  /// Target goals for improvement
  final List<ImprovementGoal> goals;

  const GamePerformanceReport({
    required this.gameType,
    required this.statistics,
    required this.performanceGrade,
    required this.trend,
    required this.strengths,
    required this.improvementAreas,
    required this.recommendedActivities,
    required this.goals,
  });

  /// Creates GamePerformanceReport from JSON
  factory GamePerformanceReport.fromJson(Map<String, dynamic> json) {
    final goalsList = <ImprovementGoal>[];
    if (json['goals'] != null) {
      (json['goals'] as List).forEach((goalJson) {
        goalsList.add(ImprovementGoal.fromJson(goalJson));
      });
    }

    return GamePerformanceReport(
      gameType: GameCategoryType.values.firstWhere(
        (e) => e.toString() == json['gameType'],
        orElse: () => GameCategoryType.CALCULATOR,
      ),
      statistics: GameStatistics.fromJson(json['statistics']),
      performanceGrade: json['performanceGrade'] ?? 'C',
      trend: ImprovementTrend.values.firstWhere(
        (e) => e.toString() == json['trend'],
        orElse: () => ImprovementTrend.noData,
      ),
      strengths: List<String>.from(json['strengths'] ?? []),
      improvementAreas: List<String>.from(json['improvementAreas'] ?? []),
      recommendedActivities:
          List<String>.from(json['recommendedActivities'] ?? []),
      goals: goalsList,
    );
  }

  /// Converts GamePerformanceReport to JSON
  Map<String, dynamic> toJson() {
    return {
      'gameType': gameType.toString(),
      'statistics': statistics.toJson(),
      'performanceGrade': performanceGrade,
      'trend': trend.toString(),
      'strengths': strengths,
      'improvementAreas': improvementAreas,
      'recommendedActivities': recommendedActivities,
      'goals': goals.map((g) => g.toJson()).toList(),
    };
  }
}

/// Model representing skill assessment
class SkillAssessment {
  /// Mathematical skill areas assessment
  final Map<MathSkillArea, SkillLevel> skillAreas;

  /// Overall cognitive abilities assessment
  final CognitiveAbilities cognitiveAbilities;

  /// Learning style preferences
  final LearningStyle learningStyle;

  /// Recommended focus areas for improvement
  final List<MathSkillArea> focusAreas;

  const SkillAssessment({
    required this.skillAreas,
    required this.cognitiveAbilities,
    required this.learningStyle,
    required this.focusAreas,
  });

  /// Creates SkillAssessment from JSON
  factory SkillAssessment.fromJson(Map<String, dynamic> json) {
    final skillAreasMap = <MathSkillArea, SkillLevel>{};
    if (json['skillAreas'] != null) {
      (json['skillAreas'] as Map<String, dynamic>).forEach((key, value) {
        final skillArea = MathSkillArea.values.firstWhere(
          (e) => e.toString() == key,
          orElse: () => MathSkillArea.arithmetic,
        );
        final skillLevel = SkillLevel.values.firstWhere(
          (e) => e.toString() == value,
          orElse: () => SkillLevel.beginner,
        );
        skillAreasMap[skillArea] = skillLevel;
      });
    }

    final focusAreasList = <MathSkillArea>[];
    if (json['focusAreas'] != null) {
      (json['focusAreas'] as List).forEach((item) {
        focusAreasList.add(MathSkillArea.values.firstWhere(
          (e) => e.toString() == item,
          orElse: () => MathSkillArea.arithmetic,
        ));
      });
    }

    return SkillAssessment(
      skillAreas: skillAreasMap,
      cognitiveAbilities:
          CognitiveAbilities.fromJson(json['cognitiveAbilities']),
      learningStyle: LearningStyle.values.firstWhere(
        (e) => e.toString() == json['learningStyle'],
        orElse: () => LearningStyle.visual,
      ),
      focusAreas: focusAreasList,
    );
  }

  /// Converts SkillAssessment to JSON
  Map<String, dynamic> toJson() {
    final skillAreasJson = <String, dynamic>{};
    skillAreas.forEach((key, value) {
      skillAreasJson[key.toString()] = value.toString();
    });

    return {
      'skillAreas': skillAreasJson,
      'cognitiveAbilities': cognitiveAbilities.toJson(),
      'learningStyle': learningStyle.toString(),
      'focusAreas': focusAreas.map((f) => f.toString()).toList(),
    };
  }
}

/// Model representing cognitive abilities assessment
class CognitiveAbilities {
  /// Memory performance score (0-100)
  final double memoryScore;

  /// Processing speed score (0-100)
  final double processingSpeed;

  /// Attention span score (0-100)
  final double attentionSpan;

  /// Problem-solving ability score (0-100)
  final double problemSolving;

  /// Pattern recognition score (0-100)
  final double patternRecognition;

  const CognitiveAbilities({
    required this.memoryScore,
    required this.processingSpeed,
    required this.attentionSpan,
    required this.problemSolving,
    required this.patternRecognition,
  });

  /// Overall cognitive score
  double get overallScore {
    return (memoryScore +
            processingSpeed +
            attentionSpan +
            problemSolving +
            patternRecognition) /
        5;
  }

  /// Creates CognitiveAbilities from JSON
  factory CognitiveAbilities.fromJson(Map<String, dynamic> json) {
    return CognitiveAbilities(
      memoryScore: (json['memoryScore'] ?? 0.0).toDouble(),
      processingSpeed: (json['processingSpeed'] ?? 0.0).toDouble(),
      attentionSpan: (json['attentionSpan'] ?? 0.0).toDouble(),
      problemSolving: (json['problemSolving'] ?? 0.0).toDouble(),
      patternRecognition: (json['patternRecognition'] ?? 0.0).toDouble(),
    );
  }

  /// Converts CognitiveAbilities to JSON
  Map<String, dynamic> toJson() {
    return {
      'memoryScore': memoryScore,
      'processingSpeed': processingSpeed,
      'attentionSpan': attentionSpan,
      'problemSolving': problemSolving,
      'patternRecognition': patternRecognition,
    };
  }
}

/// Model representing learning path recommendations
class LearningPath {
  /// Current learning phase
  final LearningPhase currentPhase;

  /// Recommended next steps
  final List<LearningStep> nextSteps;

  /// Estimated time to complete current phase (in hours)
  final int estimatedCompletionTime;

  /// Progress in current phase (0-100)
  final double phaseProgress;

  const LearningPath({
    required this.currentPhase,
    required this.nextSteps,
    required this.estimatedCompletionTime,
    required this.phaseProgress,
  });

  /// Creates LearningPath from JSON
  factory LearningPath.fromJson(Map<String, dynamic> json) {
    final stepsList = <LearningStep>[];
    if (json['nextSteps'] != null) {
      (json['nextSteps'] as List).forEach((stepJson) {
        stepsList.add(LearningStep.fromJson(stepJson));
      });
    }

    return LearningPath(
      currentPhase: LearningPhase.values.firstWhere(
        (e) => e.toString() == json['currentPhase'],
        orElse: () => LearningPhase.foundation,
      ),
      nextSteps: stepsList,
      estimatedCompletionTime: json['estimatedCompletionTime'] ?? 0,
      phaseProgress: (json['phaseProgress'] ?? 0.0).toDouble(),
    );
  }

  /// Converts LearningPath to JSON
  Map<String, dynamic> toJson() {
    return {
      'currentPhase': currentPhase.toString(),
      'nextSteps': nextSteps.map((s) => s.toJson()).toList(),
      'estimatedCompletionTime': estimatedCompletionTime,
      'phaseProgress': phaseProgress,
    };
  }
}

/// Model representing a learning step
class LearningStep {
  /// Step title
  final String title;

  /// Step description
  final String description;

  /// Game categories to focus on
  final List<GameCategoryType> gameCategories;

  /// Estimated time to complete (in minutes)
  final int estimatedMinutes;

  /// Priority level (1-5, 5 being highest)
  final int priority;

  const LearningStep({
    required this.title,
    required this.description,
    required this.gameCategories,
    required this.estimatedMinutes,
    required this.priority,
  });

  /// Creates LearningStep from JSON
  factory LearningStep.fromJson(Map<String, dynamic> json) {
    final categoriesList = <GameCategoryType>[];
    if (json['gameCategories'] != null) {
      (json['gameCategories'] as List).forEach((item) {
        categoriesList.add(GameCategoryType.values.firstWhere(
          (e) => e.toString() == item,
          orElse: () => GameCategoryType.CALCULATOR,
        ));
      });
    }

    return LearningStep(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      gameCategories: categoriesList,
      estimatedMinutes: json['estimatedMinutes'] ?? 0,
      priority: json['priority'] ?? 1,
    );
  }

  /// Converts LearningStep to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'gameCategories': gameCategories.map((c) => c.toString()).toList(),
      'estimatedMinutes': estimatedMinutes,
      'priority': priority,
    };
  }
}

/// Model representing an improvement goal
class ImprovementGoal {
  /// Goal description
  final String description;

  /// Target metric (accuracy, speed, level, etc.)
  final String targetMetric;

  /// Current value
  final double currentValue;

  /// Target value
  final double targetValue;

  /// Target date to achieve this goal
  final DateTime targetDate;

  /// Whether the goal has been achieved
  final bool isAchieved;

  const ImprovementGoal({
    required this.description,
    required this.targetMetric,
    required this.currentValue,
    required this.targetValue,
    required this.targetDate,
    required this.isAchieved,
  });

  /// Progress towards goal (0-100)
  double get progress {
    if (targetValue == currentValue) return 100.0;
    if (targetValue > currentValue) {
      return (currentValue / targetValue) * 100;
    } else {
      return ((currentValue - targetValue) / currentValue) * 100;
    }
  }

  /// Creates ImprovementGoal from JSON
  factory ImprovementGoal.fromJson(Map<String, dynamic> json) {
    return ImprovementGoal(
      description: json['description'] ?? '',
      targetMetric: json['targetMetric'] ?? '',
      currentValue: (json['currentValue'] ?? 0.0).toDouble(),
      targetValue: (json['targetValue'] ?? 0.0).toDouble(),
      targetDate: DateTime.parse(
          json['targetDate'] ?? DateTime.now().toIso8601String()),
      isAchieved: json['isAchieved'] ?? false,
    );
  }

  /// Converts ImprovementGoal to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'targetMetric': targetMetric,
      'currentValue': currentValue,
      'targetValue': targetValue,
      'targetDate': targetDate.toIso8601String(),
      'isAchieved': isAchieved,
    };
  }
}

/// Model representing an achievement/badge
class Achievement {
  /// Achievement ID
  final String id;

  /// Achievement name
  final String name;

  /// Achievement description
  final String description;

  /// Icon name or path
  final String icon;

  /// Date when achieved
  final DateTime? achievedAt;

  /// Achievement category
  final AchievementCategory category;

  /// Achievement rarity
  final AchievementRarity rarity;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.achievedAt,
    required this.category,
    required this.rarity,
  });

  /// Whether this achievement has been earned
  bool get isEarned => achievedAt != null;

  /// Creates Achievement from JSON
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      achievedAt: json['achievedAt'] != null
          ? DateTime.parse(json['achievedAt'])
          : null,
      category: AchievementCategory.values.firstWhere(
        (e) => e.toString() == json['category'],
        orElse: () => AchievementCategory.general,
      ),
      rarity: AchievementRarity.values.firstWhere(
        (e) => e.toString() == json['rarity'],
        orElse: () => AchievementRarity.common,
      ),
    );
  }

  /// Converts Achievement to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'achievedAt': achievedAt?.toIso8601String(),
      'category': category.toString(),
      'rarity': rarity.toString(),
    };
  }
}

/// Enums for categorization
enum MathSkillArea {
  arithmetic,
  algebra,
  geometry,
  logic,
  memory,
  speed,
  patterns,
}

enum LearningStyle {
  visual,
  auditory,
  kinesthetic,
  mixed,
}

enum LearningPhase {
  foundation,
  development,
  mastery,
  expert,
}

enum AchievementCategory {
  general,
  speed,
  accuracy,
  consistency,
  improvement,
  mastery,
}

enum AchievementRarity {
  common,
  uncommon,
  rare,
  epic,
  legendary,
}

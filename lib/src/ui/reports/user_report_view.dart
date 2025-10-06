import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_provider.dart';
import 'package:mathsgames/src/data/models/user_report.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';

import '../../data/models/user_profile.dart';

/// Comprehensive user report view showing performance analytics and improvement suggestions
/// Enhanced with Material 3 design and dyslexic-friendly UI
class UserReportView extends StatefulWidget {
  final String userEmail;
  final int initialTabIndex;

  const UserReportView({
    Key? key,
    required this.userEmail,
    this.initialTabIndex = 0,
  }) : super(key: key);

  @override
  State<UserReportView> createState() => _UserReportViewState();
}

class _UserReportViewState extends State<UserReportView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: widget.initialTabIndex);

    // Generate report when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserReportProvider>().generateReport(widget.userEmail);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Performance Report',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: DyslexicTheme.dyslexicFont,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 4,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Game Reports'),
            Tab(text: 'Skills'),
            Tab(text: 'Learning Path'),
            Tab(text: 'Achievements'),
          ],
          // Material 3 tab styling
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: DyslexicTheme.dyslexicFont,
          ),
          unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
            fontFamily: DyslexicTheme.dyslexicFont,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
        ),
      ),
      body: Consumer<UserReportProvider>(
        builder: (context, reportProvider, child) {
          if (reportProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (reportProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  SizedBox(height: 16),
                  Text(
                    reportProvider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontFamily: DyslexicTheme.dyslexicFont,
                    ),
                  ),
                  SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      reportProvider.clearError();
                      reportProvider.generateReport(widget.userEmail);
                    },
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        fontFamily: DyslexicTheme.dyslexicFont,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (reportProvider.currentReport == null) {
            return Center(
              child: Text(
                'No report data available',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: DyslexicTheme.dyslexicFont,
                ),
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(reportProvider.currentReport!),
              _buildGameReportsTab(reportProvider.currentReport!),
              _buildSkillsTab(reportProvider.currentReport!),
              _buildLearningPathTab(reportProvider.currentReport!),
              _buildAchievementsTab(reportProvider.currentReport!),
            ],
          );
        },
      ),
    );
  }

  /// Overview tab showing general performance summary
  Widget _buildOverviewTab(UserReport report) {
    final theme = Theme.of(context);
    final summary = report.overallSummary;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Card
          _buildUserProfileCard(report.userProfile),

          SizedBox(height: 16),

          // Performance Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Games Played',
                  summary.totalGamesPlayed.toString(),
                  Icons.gamepad,
                  theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Overall Accuracy',
                  '${summary.overallAccuracy.toStringAsFixed(1)}%',
                  Icons.check_circle,
                  theme.colorScheme.secondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Average Score',
                  summary.averageScore.toStringAsFixed(1),
                  Icons.score,
                  theme.colorScheme.tertiary,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Play Time',
                  '${summary.totalPlayTime} min',
                  Icons.timer,
                  theme.colorScheme.secondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Skill Level Progress
          _buildSkillLevelCard(summary),

          SizedBox(height: 16),

          // Strengths and Improvement Areas
          _buildStrengthsAndImprovementsCard(summary),
        ],
      ),
    );
  }

  /// Game Reports tab showing performance by game category
  Widget _buildGameReportsTab(UserReport report) {
    return ListView.builder(
      padding: EdgeInsets.all(getHorizontalSpace(context)),
      itemCount: report.gameReports.length,
      itemBuilder: (context, index) {
        final entry = report.gameReports.entries.elementAt(index);
        final gameType = entry.key;
        final gameReport = entry.value;

        return _buildGameReportCard(gameType, gameReport);
      },
    );
  }

  /// Skills tab showing detailed skill assessment
  Widget _buildSkillsTab(UserReport report) {
    final skillAssessment = report.skillAssessment;

    return SingleChildScrollView(
      padding: EdgeInsets.all(getHorizontalSpace(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Math Skills Assessment
          _buildSectionHeader('Mathematical Skills'),
          _buildMathSkillsCard(skillAssessment.skillAreas),

          SizedBox(height: getVerticalSpace(context)),

          // Cognitive Abilities
          _buildSectionHeader('Cognitive Abilities'),
          _buildCognitiveAbilitiesCard(skillAssessment.cognitiveAbilities),

          SizedBox(height: getVerticalSpace(context)),

          // Focus Areas
          _buildSectionHeader('Areas for Improvement'),
          _buildFocusAreasCard(skillAssessment.focusAreas),
        ],
      ),
    );
  }

  /// Learning Path tab showing recommended learning steps
  Widget _buildLearningPathTab(UserReport report) {
    final learningPath = report.learningPath;

    return SingleChildScrollView(
      padding: EdgeInsets.all(getHorizontalSpace(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Phase
          _buildCurrentPhaseCard(learningPath),

          SizedBox(height: getVerticalSpace(context)),

          // Next Steps
          _buildSectionHeader('Recommended Next Steps'),
          ...learningPath.nextSteps.map((step) => _buildLearningStepCard(step)),
        ],
      ),
    );
  }

  /// Achievements tab showing earned badges and milestones
  Widget _buildAchievementsTab(UserReport report) {
    return GridView.builder(
      padding: EdgeInsets.all(getHorizontalSpace(context)),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: report.achievements.length,
      itemBuilder: (context, index) {
        final achievement = report.achievements[index];
        return _buildAchievementCard(achievement);
      },
    );
  }

  /// Build user profile card with Material 3 styling
  Widget _buildUserProfileCard(UserProfile profile) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'U',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: DyslexicTheme.dyslexicFont,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontFamily: DyslexicTheme.dyslexicFont,
                        ),
                      ),
                      Text(
                        profile.email,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          fontFamily: DyslexicTheme.dyslexicFont,
                        ),
                      ),
                      Text(
                        'Member since: ${_formatDate(profile.createdAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: DyslexicTheme.dyslexicFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build stat card with Material 3 styling
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build skill level card with Material 3 styling
  Widget _buildSkillLevelCard(PerformanceSummary summary) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Skill Level',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: DyslexicTheme.dyslexicFont,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.read<UserReportProvider>().getSkillLevelColor(summary.currentSkillLevel),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    summary.currentSkillLevel.displayName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: DyslexicTheme.dyslexicFont,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Progress to Next Level',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: summary.progressToNextLevel,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
            SizedBox(height: 8),
            Text(
              '${(summary.progressToNextLevel * 100).toInt()}% Complete',
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build strengths and improvements card with Material 3 styling
  Widget _buildStrengthsAndImprovementsCard(PerformanceSummary summary) {
    final theme = Theme.of(context);
    final reportProvider = Provider.of<UserReportProvider>(context, listen: false);

    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Strengths & Areas for Improvement',
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
            SizedBox(height: 16),

            // Strengths
            Text(
              'Strengths',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
            SizedBox(height: 8),
            // Use strongestCategories instead of strengths
            ...summary.strongestCategories.map((category) => _buildBulletPoint(
              reportProvider.getGameCategoryDisplayName(category),
              true
            )),

            SizedBox(height: 16),

            // Areas for Improvement
            Text(
              'Areas for Improvement',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
            SizedBox(height: 8),
            // Use improvementAreas instead of areasForImprovement
            ...summary.improvementAreas.map((category) => _buildBulletPoint(
              reportProvider.getGameCategoryDisplayName(category),
              false
            )),
          ],
        ),
      ),
    );
  }

  /// Build bullet point for strengths/improvement areas with Material 3 styling
  Widget _buildBulletPoint(String text, bool isStrength) {
    final theme = Theme.of(context);
    final color = isStrength ? theme.colorScheme.primary : theme.colorScheme.error;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isStrength ? Icons.check_circle : Icons.info_outline,
            color: color,
            size: 18,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: DyslexicTheme.dyslexicFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build game report card
  Widget _buildGameReportCard(GameCategoryType gameType, GamePerformanceReport report) {
    final provider = context.read<UserReportProvider>();

    return Card(
      margin: EdgeInsets.only(bottom: getVerticalSpace(context)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: provider.getPerformanceGradeColor(report.performanceGrade),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            report.performanceGrade,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(provider.getGameCategoryDisplayName(gameType)),
        subtitle: Text('Accuracy: ${report.statistics.accuracy.toStringAsFixed(1)}%'),
        trailing: Icon(provider.getImprovementTrendIcon(report.trend)),
        children: [
          Padding(
            padding: EdgeInsets.all(getHorizontalSpace(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics
                Row(
                  children: [
                    Expanded(
                      child: _buildMiniStatCard('Games', '${report.statistics.gamesPlayed}'),
                    ),
                    Expanded(
                      child: _buildMiniStatCard('High Score', '${report.statistics.highestScore}'),
                    ),
                    Expanded(
                      child: _buildMiniStatCard('Level', '${report.statistics.highestLevel}'),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Strengths
                if (report.strengths.isNotEmpty) ...[
                  Text(
                    'Strengths:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.green,
                    ),
                  ),
                  ...report.strengths.map((strength) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        SizedBox(width: 8),
                        Expanded(child: Text(strength)),
                      ],
                    ),
                  )),
                  SizedBox(height: 8),
                ],

                // Improvement Areas
                if (report.improvementAreas.isNotEmpty) ...[
                  Text(
                    'Areas to Improve:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.orange,
                    ),
                  ),
                  ...report.improvementAreas.map((area) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.info, color: Colors.orange, size: 16),
                        SizedBox(width: 8),
                        Expanded(child: Text(area)),
                      ],
                    ),
                  )),
                  SizedBox(height: 8),
                ],

                // Recommended Activities
                if (report.recommendedActivities.isNotEmpty) ...[
                  Text(
                    'Recommended Practice:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                  ...report.recommendedActivities.map((activity) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb, color: Colors.blue, size: 16),
                        SizedBox(width: 8),
                        Expanded(child: Text(activity)),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build mini stat card for game details
  Widget _buildMiniStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Build math skills card
  Widget _buildMathSkillsCard(Map<MathSkillArea, SkillLevel> skillAreas) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getHorizontalSpace(context)),
        child: Column(
          children: skillAreas.entries.map((entry) {
            final skillArea = entry.key;
            final skillLevel = entry.value;
            final provider = context.read<UserReportProvider>();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_getSkillAreaDisplayName(skillArea)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: provider.getSkillLevelColor(skillLevel),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skillLevel.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Build cognitive abilities card
  Widget _buildCognitiveAbilitiesCard(CognitiveAbilities abilities) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getHorizontalSpace(context)),
        child: Column(
          children: [
            _buildAbilityBar('Memory', abilities.memoryScore),
            _buildAbilityBar('Processing Speed', abilities.processingSpeed),
            _buildAbilityBar('Attention Span', abilities.attentionSpan),
            _buildAbilityBar('Problem Solving', abilities.problemSolving),
            _buildAbilityBar('Pattern Recognition', abilities.patternRecognition),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${abilities.overallScore.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(abilities.overallScore),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build ability progress bar
  Widget _buildAbilityBar(String label, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('${score.toStringAsFixed(1)}%'),
            ],
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: score / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_getScoreColor(score)),
          ),
        ],
      ),
    );
  }

  /// Build focus areas card
  Widget _buildFocusAreasCard(List<MathSkillArea> focusAreas) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getHorizontalSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Focus Areas:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            ...focusAreas.map((area) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.center_focus_strong_sharp, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(_getSkillAreaDisplayName(area)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  /// Build current phase card
  Widget _buildCurrentPhaseCard(LearningPath learningPath) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getHorizontalSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Learning Phase',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getLearningPhaseDisplayName(learningPath.currentPhase),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Estimated completion: ${learningPath.estimatedCompletionTime} hours'),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: learningPath.phaseProgress / 100,
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build learning step card
  Widget _buildLearningStepCard(LearningStep step) {
    return Card(
      margin: EdgeInsets.only(bottom: getVerticalSpace(context)),
      child: Padding(
        padding: EdgeInsets.all(getHorizontalSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(step.priority),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      step.priority.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    step.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  '${step.estimatedMinutes} min',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(step.description),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: step.gameCategories.map((category) => Chip(
                label: Text(
                  context.read<UserReportProvider>().getGameCategoryDisplayName(category),
                  style: const TextStyle(fontSize: 12),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build achievement card
  Widget _buildAchievementCard(Achievement achievement) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getAchievementIcon(achievement.icon),
              size: 48,
              color: _getRarityColor(achievement.rarity),
            ),
            SizedBox(height: 8),
            Text(
              achievement.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              achievement.description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (achievement.achievedAt != null) ...[
              SizedBox(height: 8),
              Text(
                'Earned: ${_formatDate(achievement.achievedAt!)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper methods

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getSkillAreaDisplayName(MathSkillArea area) {
    switch (area) {
      case MathSkillArea.arithmetic:
        return 'Arithmetic';
      case MathSkillArea.algebra:
        return 'Algebra';
      case MathSkillArea.geometry:
        return 'Geometry';
      case MathSkillArea.logic:
        return 'Logic';
      case MathSkillArea.memory:
        return 'Memory';
      case MathSkillArea.speed:
        return 'Speed';
      case MathSkillArea.patterns:
        return 'Patterns';
    }
  }

  String _getLearningPhaseDisplayName(LearningPhase phase) {
    switch (phase) {
      case LearningPhase.foundation:
        return 'Foundation Building';
      case LearningPhase.development:
        return 'Skill Development';
      case LearningPhase.mastery:
        return 'Mastery Phase';
      case LearningPhase.expert:
        return 'Expert Level';
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 5:
        return Colors.red;
      case 4:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 2:
        return Colors.blue;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getAchievementIcon(String iconName) {
    switch (iconName) {
      case 'trophy':
        return Icons.emoji_events;
      case 'target':
        return Icons.gps_fixed;
      case 'calendar':
        return Icons.calendar_today;
      case 'trending_up':
        return Icons.trending_up;
      case 'star':
        return Icons.star;
      default:
        return Icons.military_tech;
    }
  }

  Color _getRarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return Colors.grey;
      case AchievementRarity.uncommon:
        return Colors.green;
      case AchievementRarity.rare:
        return Colors.blue;
      case AchievementRarity.epic:
        return Colors.purple;
      case AchievementRarity.legendary:
        return Colors.orange;
    }
  }
}

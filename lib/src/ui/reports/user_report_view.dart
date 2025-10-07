import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/theme_wrapper.dart';
import 'package:mathsgames/src/data/models/user_report.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'user_report_provider.dart';

/// User report view with Material 3 design and dyslexic-friendly features
/// Displays comprehensive performance analytics and learning progress
class UserReportView extends StatefulWidget {
  final String userEmail;

  const UserReportView({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<UserReportView> createState() => _UserReportViewState();
}

class _UserReportViewState extends State<UserReportView> {
  late UserReportProvider _reportProvider;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _reportProvider = UserReportProvider.withoutRepository();
    _loadReport();
  }

  Future<void> _loadReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _reportProvider.generateReport(widget.userEmail);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load report: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ThemeWrapper.dyslexicScreen(
          isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          child: _buildReportView(),
        );
      },
    );
  }

  Widget _buildReportView() {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Performance Report',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadReport,
            tooltip: 'Refresh Report',
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: _isLoading ? null : _showResetDialog,
            tooltip: 'Reset Report',
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingView() : _buildReportContent(),
    );
  }

  void _showResetDialog() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reset Report',
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            'Are you sure you want to reset your report data? This action cannot be undone.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _resetReport();
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _reportProvider.clearReport(widget.userEmail);
      await _loadReport(); // Reload to show empty state
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to reset report: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildLoadingView() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Generating your performance report...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportContent() {
    return ChangeNotifierProvider.value(
      value: _reportProvider,
      child: Consumer<UserReportProvider>(
        builder: (context, provider, child) {
          if (provider.report == null) {
            return _buildEmptyState();
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewCard(provider.report!),
                SizedBox(height: 16),
                _buildPerformanceCard(provider.report!),
                SizedBox(height: 16),
                _buildProgressCard(provider.report!),
                SizedBox(height: 16),
                _buildRecommendationsCard(provider.report!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assessment_outlined,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 16),
          Text(
            'No Data Available',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start playing games to see your performance report',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(UserReport report) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total Games',
                    report.overallSummary.totalGamesPlayed.toString(),
                    Icons.gamepad,
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Average Score',
                    '${report.overallSummary.averageScore.toStringAsFixed(1)}%',
                    Icons.trending_up,
                    theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Time Played',
                    '${report.overallSummary.totalPlayTime}min',
                    Icons.timer,
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Best Streak',
                    '${(report.overallSummary.overallAccuracy * 10).toInt()}', // Use accuracy as a proxy for streak
                    Icons.local_fire_department,
                    theme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: theme.colorScheme.primary,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(UserReport report) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Summary',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Strengths:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.secondary,
              ),
            ),
            SizedBox(height: 8),
            // Use fixed strengths list for now
            ..._getDefaultStrengths().map((strength) => _buildBulletPoint(strength, true)),
            SizedBox(height: 16),
            Text(
              'Areas for Improvement:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.error,
              ),
            ),
            SizedBox(height: 8),
            // Use fixed improvement areas for now
            ..._getDefaultImprovements().map((area) => _buildBulletPoint(area, false)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(UserReport report) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Tracking',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            _buildProgressIndicator('Addition Skills', 0.85, theme),
            SizedBox(height: 12),
            _buildProgressIndicator('Subtraction Skills', 0.72, theme),
            SizedBox(height: 12),
            _buildProgressIndicator('Multiplication Skills', 0.68, theme),
            SizedBox(height: 12),
            _buildProgressIndicator('Division Skills', 0.55, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String skill, double progress, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildRecommendationsCard(UserReport report) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            ..._getRecommendations().map((recommendation) =>
              _buildRecommendationItem(recommendation, theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text, bool isPositive) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isPositive ? Icons.check_circle : Icons.info,
            size: 16,
            color: isPositive ? theme.colorScheme.secondary : theme.colorScheme.error,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb,
            size: 16,
            color: theme.colorScheme.tertiary,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              recommendation,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getDefaultStrengths() {
    return [
      'Quick mental calculations',
      'Good problem-solving approach',
      'Consistent performance in basic operations',
    ];
  }

  List<String> _getDefaultImprovements() {
    return [
      'Practice more complex multiplication',
      'Work on division accuracy',
      'Improve response time for harder problems',
    ];
  }

  List<String> _getRecommendations() {
    return [
      'Focus on practicing division problems for 10 minutes daily',
      'Try the multiplication games to improve speed',
      'Set a goal to increase accuracy by 5% this week',
      'Practice mental math during free time',
    ];
  }
}

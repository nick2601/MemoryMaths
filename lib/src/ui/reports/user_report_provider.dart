import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/user_report.dart';
import 'package:mathsgames/src/data/repositories/user_report_repository.dart';
import 'package:mathsgames/src/core/app_constant.dart';

import '../../data/models/user_profile.dart';

/// Provider class for managing user report state and operations
class UserReportProvider extends ChangeNotifier {
  final UserReportRepository _repository;

  UserReport? _currentReport;
  List<UserReport> _reportHistory = [];
  bool _isLoading = false;
  String? _errorMessage;

  UserReportProvider(this._repository);

  // Getters
  UserReport? get currentReport => _currentReport;
  List<UserReport> get reportHistory => _reportHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Generate a new report for the specified user
  Future<void> generateReport(String email) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _currentReport = await _repository.generateUserReport(email);
      await _loadReportHistory(email);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to generate report: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  /// Load report history for the specified user
  Future<void> _loadReportHistory(String email) async {
    try {
      _reportHistory = await _repository.getReportHistory(email);
    } catch (e) {
      _errorMessage = 'Failed to load report history: ${e.toString()}';
    }
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
    try {
      await _repository.updateUserStatistics(
        email: email,
        gameType: gameType,
        score: score,
        level: level,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        durationMinutes: durationMinutes,
      );
    } catch (e) {
      _errorMessage = 'Failed to update statistics: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Get user profile
  Future<void> loadUserProfile(String email) async {
    _setLoading(true);
    try {
      final profile = await _repository.getUserProfile(email);
      if (profile != null) {
        // You can store the profile if needed
      }
    } catch (e) {
      _errorMessage = 'Failed to load user profile: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Helper method to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Get performance grade color
  Color getPerformanceGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return Colors.green;
      case 'B+':
      case 'B':
        return Colors.lightGreen;
      case 'C+':
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.red;
      case 'F':
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  /// Get skill level color
  Color getSkillLevelColor(SkillLevel skillLevel) {
    switch (skillLevel) {
      case SkillLevel.expert:
        return Colors.purple;
      case SkillLevel.advanced:
        return Colors.blue;
      case SkillLevel.intermediate:
        return Colors.green;
      case SkillLevel.beginner:
        return Colors.orange;
    }
  }

  /// Get improvement trend icon
  IconData getImprovementTrendIcon(ImprovementTrend trend) {
    switch (trend) {
      case ImprovementTrend.improving:
        return Icons.trending_up;
      case ImprovementTrend.declining:
        return Icons.trending_down;
      case ImprovementTrend.stable:
        return Icons.trending_flat;
      case ImprovementTrend.noData:
        return Icons.help_outline;
    }
  }

  /// Get game category display name
  String getGameCategoryDisplayName(GameCategoryType gameType) {
    switch (gameType) {
      case GameCategoryType.CALCULATOR:
        return 'Calculator';
      case GameCategoryType.MENTAL_ARITHMETIC:
        return 'Mental Arithmetic';
      case GameCategoryType.QUICK_CALCULATION:
        return 'Quick Calculation';
      case GameCategoryType.NUMERIC_MEMORY:
        return 'Numeric Memory';
      case GameCategoryType.GUESS_SIGN:
        return 'Guess the Sign';
      case GameCategoryType.TRUE_FALSE:
        return 'True/False';
      case GameCategoryType.FIND_MISSING:
        return 'Find Missing';
      case GameCategoryType.CORRECT_ANSWER:
        return 'Correct Answer';
      case GameCategoryType.MATH_PAIRS:
        return 'Math Pairs';
      case GameCategoryType.CONCENTRATION:
        return 'Concentration';
      case GameCategoryType.SQUARE_ROOT:
        return 'Square Root';
      case GameCategoryType.CUBE_ROOT:
        return 'Cube Root';
      case GameCategoryType.MAGIC_TRIANGLE:
        return 'Magic Triangle';
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
    }
  }
}

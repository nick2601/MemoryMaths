import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathsgames/src/data/models/user_profile.dart';
import 'package:mathsgames/src/data/repositories/user_report_repository.dart';

import '../../core/app_constant.dart';

/// Provider for managing user authentication state.
/// Handles signup, login, logout, and authentication status checks.
class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  String? _userEmail;
  UserProfile? _userProfile;

  /// Returns whether the user is authenticated.
  bool get isAuthenticated => _isAuthenticated;
  /// Returns the current username.
  String? get username => _username;
  /// Returns the current user email.
  String? get userEmail => _userEmail;
  /// Returns the current user profile.
  UserProfile? get userProfile => _userProfile;

  /// Signs up a new user with the given username, email, and password.
  /// Creates a user profile for analytics and reporting.
  /// Throws an exception if the username or email already exists.
  Future<void> signup(String username, String email, String password, String fullName) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the username already exists
    if (prefs.containsKey(username)) {
      throw Exception("Username already exists.");
    }

    // Check if the email already exists
    if (prefs.containsKey('email_$email')) {
      throw Exception("Email already exists.");
    }

    // Save the new user credentials
    await prefs.setString(username, password);
    await prefs.setString('email_$email', username);
    await prefs.setString('loggedInUser', username);
    await prefs.setString('loggedInUserEmail', email);
    await prefs.setString('${username}_email', email);
    await prefs.setString('${username}_fullName', fullName);

    // Create user profile for analytics
    await _createUserProfile(email, fullName);

    _isAuthenticated = true;
    _username = username;
    _userEmail = email;
    notifyListeners();
  }

  /// Signs up a new user with existing method signature (backward compatibility)
  /// Now includes email collection
  Future<void> signupWithUsernamePassword(String username, String password) async {
    // For backward compatibility, generate an email from username
    String email = '$username@memorymath.local';
    await signup(username, email, password, username);
  }

  /// Logs in a user with the given username and password.
  /// Throws an exception if credentials are invalid.
  Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(username) == password) {
      await prefs.setString('loggedInUser', username);

      // Get user email and profile
      final userEmail = prefs.getString('${username}_email');
      if (userEmail != null) {
        await prefs.setString('loggedInUserEmail', userEmail);
        _userEmail = userEmail;

        // Load user profile for analytics
        await _loadUserProfile(userEmail);
      }

      _isAuthenticated = true;
      _username = username;
      notifyListeners();
    } else {
      throw Exception("Invalid username or password.");
    }
  }

  /// Logs out the current user.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
    await prefs.remove('loggedInUserEmail');

    _isAuthenticated = false;
    _username = null;
    _userEmail = null;
    _userProfile = null;
    notifyListeners();
  }

  /// Checks the current authentication status.
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString('loggedInUser');
    final loggedInUserEmail = prefs.getString('loggedInUserEmail');

    if (loggedInUser != null) {
      _isAuthenticated = true;
      _username = loggedInUser;
      _userEmail = loggedInUserEmail;

      // Load user profile if email exists
      if (_userEmail != null) {
        await _loadUserProfile(_userEmail!);
      }
    } else {
      _isAuthenticated = false;
      _username = null;
      _userEmail = null;
      _userProfile = null;
    }

    notifyListeners();
  }

  /// Creates a new user profile for analytics and reporting
  Future<void> _createUserProfile(String email, String fullName) async {
    final userReportRepository = UserReportRepository();

    // Check if profile already exists
    final existingProfile = await userReportRepository.getUserProfile(email);

    if (existingProfile == null) {
      // Create new profile
      final newProfile = UserProfile(
        email: email,
        name: fullName,
        createdAt: DateTime.now(),
        lastPlayedAt: DateTime.now(),
        totalCoins: 0,
        totalGamesPlayed: 0,
        gameStats: {},
        skillLevel: SkillLevel.beginner,
      );

      await userReportRepository.saveUserProfile(newProfile);
      _userProfile = newProfile;
    } else {
      _userProfile = existingProfile;
    }
  }

  /// Loads existing user profile for analytics
  Future<void> _loadUserProfile(String email) async {
    final userReportRepository = UserReportRepository();
    _userProfile = await userReportRepository.getUserProfile(email);
  }

  /// Updates user profile after game completion
  Future<void> updateUserStats({
    required String gameType,
    required double score,
    required int level,
    required int correctAnswers,
    required int wrongAnswers,
    required int durationMinutes,
  }) async {
    if (_userEmail != null) {
      final userReportRepository = UserReportRepository();

      // Parse game type from string to enum
      GameCategoryType? parsedGameType;
      try {
        parsedGameType = GameCategoryType.values.firstWhere(
          (e) => e.toString().split('.').last == gameType,
        );
      } catch (e) {
        print('Could not parse game type: $gameType');
        return;
      }

      await userReportRepository.updateUserStatistics(
        email: _userEmail!,
        gameType: parsedGameType,
        score: score,
        level: level,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        durationMinutes: durationMinutes,
      );

      // Reload user profile to get updated stats
      await _loadUserProfile(_userEmail!);
      notifyListeners();
    }
  }
}

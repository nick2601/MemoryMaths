import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathsgames/src/data/models/user_profile.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'dart:convert';

/// Provider for managing user authentication state.
/// Handles signup, login, logout, and authentication status checks.
class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  String? _userEmail;
  UserProfile? _userProfile;
  CoinProvider? _coinProvider;

  /// Returns whether the user is authenticated.
  bool get isAuthenticated => _isAuthenticated;
  /// Returns the current username.
  String? get username => _username;
  /// Returns the current user email.
  String? get userEmail => _userEmail;
  /// Returns the current user profile.
  UserProfile? get userProfile => _userProfile;
  /// Returns the current user (for compatibility)
  UserProfile? get currentUser => _userProfile;

  /// Sets the coin provider reference for user-specific coin management
  void setCoinProvider(CoinProvider coinProvider) {
    _coinProvider = coinProvider;
  }

  /// Registers a new user with the given details
  Future<void> register(String fullName, String email, String username, String password) async {
    await signup(username, email, password, fullName);
  }

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

    // Create user profile with correct parameters
    _userProfile = UserProfile(
      email: email,
      name: fullName,
      createdAt: DateTime.now(),
      lastPlayedAt: DateTime.now(),
      totalCoins: 0,
      totalGamesPlayed: 0,
      gameStats: {},
      skillLevel: SkillLevel.beginner,
    );

    // Save user profile
    await _saveUserProfile(_userProfile!);

    // Set authentication state
    _isAuthenticated = true;
    _username = username;
    _userEmail = email;

    // Initialize coins for new user
    if (_coinProvider != null) {
      _coinProvider!.setUserId(username);
    }

    notifyListeners();
  }

  /// Logs in a user with the given username and password.
  /// Throws an exception if the credentials are invalid.
  Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString(username);

    if (storedPassword == null || storedPassword != password) {
      throw Exception("Invalid username or password.");
    }

    // Load user profile
    _userProfile = await _loadUserProfile(username);

    // Set authentication state
    _isAuthenticated = true;
    _username = username;
    _userEmail = _userProfile?.email;

    // Set logged in user
    await prefs.setString('loggedInUser', username);

    // Initialize coins for existing user
    if (_coinProvider != null) {
      _coinProvider!.setUserId(username);
    }

    notifyListeners();
  }

  /// Logs out the current user.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');

    _isAuthenticated = false;
    _username = null;
    _userEmail = null;
    _userProfile = null;

    // Clear user from coin provider
    if (_coinProvider != null) {
      _coinProvider!.setUserId(null);
    }

    notifyListeners();
  }

  /// Checks if there's a logged-in user and restores the authentication state.
  Future<void> checkAuthenticationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString('loggedInUser');

    if (loggedInUser != null) {
      // Load user profile
      _userProfile = await _loadUserProfile(loggedInUser);

      _isAuthenticated = true;
      _username = loggedInUser;
      _userEmail = _userProfile?.email;

      // Initialize coins for authenticated user
      if (_coinProvider != null) {
        _coinProvider!.setUserId(loggedInUser);
      }

      notifyListeners();
    }
  }

  /// Alias for checkAuthenticationStatus for backward compatibility
  Future<void> checkAuthStatus() async {
    await checkAuthenticationStatus();
  }

  /// Saves user profile to SharedPreferences
  Future<void> _saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_${profile.email}', jsonEncode(profile.toJson()));
  }

  /// Loads user profile from SharedPreferences
  Future<UserProfile?> _loadUserProfile(String username) async {
    final prefs = await SharedPreferences.getInstance();

    // Try to find profile by username first (for backward compatibility)
    final profileJson = prefs.getString('profile_$username');

    if (profileJson != null) {
      return UserProfile.fromJson(jsonDecode(profileJson));
    }

    // Create default profile if not exists
    final email = prefs.getString('email_${username}@example.com') != null
        ? '${username}@example.com'
        : '${username}@memorymath.local';

    final defaultProfile = UserProfile(
      email: email,
      name: username,
      createdAt: DateTime.now(),
      lastPlayedAt: DateTime.now(),
      totalCoins: 0,
      totalGamesPlayed: 0,
      gameStats: {},
      skillLevel: SkillLevel.beginner,
    );

    await _saveUserProfile(defaultProfile);
    return defaultProfile;
  }
}

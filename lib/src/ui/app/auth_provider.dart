import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing user authentication state.
/// Handles signup, login, logout, and authentication status checks.
class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;

  /// Returns whether the user is authenticated.
  bool get isAuthenticated => _isAuthenticated;
  /// Returns the current username.
  String? get username => _username;

  /// Signs up a new user with the given username and password.
  /// Throws an exception if the username already exists.
  Future<void> signup(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the username already exists
    if (prefs.containsKey(username)) {
      throw Exception("Username already exists.");
    }

    // Save the new user credentials
    await prefs.setString(username, password);
    await prefs.setString('loggedInUser', username);

    _isAuthenticated = true;
    _username = username;
    notifyListeners();
  }

  /// Logs in a user with the given username and password.
  /// Throws an exception if credentials are invalid.
  Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(username) == password) {
      await prefs.setString('loggedInUser', username);
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

    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }

  /// Checks the current authentication status.
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString('loggedInUser');

    if (loggedInUser != null) {
      _isAuthenticated = true;
      _username = loggedInUser;
    } else {
      _isAuthenticated = false;
      _username = null;
    }

    notifyListeners();
  }
}

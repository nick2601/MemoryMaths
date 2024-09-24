import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;

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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');

    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }

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

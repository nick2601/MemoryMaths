import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Coin constants
const int rightCoin = 10;
const int wrongCoin = 5;
const int hintCoin = 10;

/// Provider for managing the user's coin balance.
/// Handles retrieving, adding, and subtracting coins per user profile.
class CoinProvider with ChangeNotifier {
  final SharedPreferences preferences;
  int coin = 0;
  String? _currentUserId; // Track current user

  // Legacy key for backward compatibility
  static const String LEGACY_KEY_COIN = 'KeyCoin';

  String get keyCoin =>
      _currentUserId != null ? 'KeyCoin_$_currentUserId' : LEGACY_KEY_COIN;

  /// Constructor that accepts SharedPreferences for dependency injection
  CoinProvider({required this.preferences}) {
    _loadCoin();
  }

  /// Sets the current user ID for user-specific coin storage
  void setUserId(String? userId) {
    if (_currentUserId != userId) {
      _currentUserId = userId;
      _loadCoin(); // Reload coins for the new user
    }
  }

  /// Gets the current user ID
  String? get currentUserId => _currentUserId;

  /// Loads the coin balance from shared preferences for current user
  void _loadCoin() {
    // First try user-specific key
    if (_currentUserId != null) {
      coin = preferences.getInt(keyCoin) ?? 0;
    } else {
      // Fallback to legacy key
      coin = preferences.getInt(LEGACY_KEY_COIN) ?? 0;
    }
    print("coin===$coin for user: $_currentUserId");
    notifyListeners();
  }

  /// Retrieves the current coin balance from persistent storage.
  Future<void> getCoin() async {
    _loadCoin();
  }

  /// Adds coins for a correct answer and updates the balance.
  Future<void> addCoin() async {
    print("coin===12 $coin");
    await preferences.setInt(keyCoin, (coin + rightCoin));
    _loadCoin();
  }

  /// Subtracts coins for a wrong answer or usage, and updates the balance.
  /// [useCoin] - Optional custom amount to subtract.
  Future<void> minusCoin({int? useCoin}) async {
    int i = (useCoin == null) ? wrongCoin : useCoin;
    await preferences.setInt(keyCoin, ((coin - i) >= 0) ? (coin - i) : 0);
    _loadCoin();
  }

  /// Resets coins for the current user to 0
  Future<void> resetCoins() async {
    // Clear both legacy and user-specific keys
    await preferences.remove(LEGACY_KEY_COIN);

    if (_currentUserId != null) {
      final userKey = 'KeyCoin_$_currentUserId';
      await preferences.remove(userKey);
    }

    // Set new value to 0
    await preferences.setInt(keyCoin, 0);
    coin = 0;

    // Force UI update
    notifyListeners();
  }

  /// Gets coin count for a specific user (for settings screen verification)
  Future<int> getUserCoins(String userId) async {
    final userKey = 'KeyCoin_$userId';
    return preferences.getInt(userKey) ?? 0;
  }

  /// Deletes all coin data for a specific user
  Future<void> deleteUserCoinData(String userId) async {
    final userKey = 'KeyCoin_$userId';
    await preferences.remove(userKey);

    // If this is the current user, reset the local coin value
    if (_currentUserId == userId) {
      coin = 0;
      notifyListeners();
    }
  }
}

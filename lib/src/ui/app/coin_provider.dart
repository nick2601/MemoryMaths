import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing the user's coin balance.
/// Handles retrieving, adding, and subtracting coins per user profile.
class CoinProvider with ChangeNotifier {
  final SharedPreferences preferences;
  int coin = 0;
  String? _currentUserId; // Track current user

  // Legacy key for backward compatibility
  static const String LEGACY_KEY_COIN = 'KeyCoin';

  String get keyCoin => _currentUserId != null ? 'KeyCoin_$_currentUserId' : LEGACY_KEY_COIN;

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
  getCoin() async {
    _loadCoin();
  }

  /// Adds coins for a correct answer and updates the balance.
  addCoin() async {
    print("coin===12 $coin");
    await preferences.setInt(keyCoin, (coin + rightCoin));
    _loadCoin();
  }

  /// Subtracts coins for a wrong answer or usage, and updates the balance.
  /// [useCoin] - Optional custom amount to subtract.
  minusCoin({int? useCoin}) async {
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

    print("Coins reset to 0 for user: $_currentUserId");
  }

  /// Resets coins for a specific user
  Future<void> resetUserCoins(String userId) async {
    // Remove both legacy and user-specific keys
    await preferences.remove(LEGACY_KEY_COIN);
    await preferences.remove('KeyCoin_$userId');

    // Set new value to 0
    await preferences.setInt('KeyCoin_$userId', 0);

    // Update current value if this is the current user
    if (userId == _currentUserId) {
      coin = 0;
      notifyListeners();
    }

    print("Coins reset to 0 for user: $userId");
  }

  /// Gets coins for a specific user
  Future<int> getUserCoins(String userId) async {
    final userKey = 'KeyCoin_$userId';
    return preferences.getInt(userKey) ?? 0;
  }

  /// Sets coins for a specific user
  Future<void> setUserCoins(String userId, int coins) async {
    final userKey = 'KeyCoin_$userId';
    await preferences.setInt(userKey, coins);

    if (userId == _currentUserId) {
      coin = coins;
      notifyListeners();
    }
  }

  /// Deletes all coin data for a specific user
  Future<void> deleteUserCoinData(String userId) async {
    // Remove both legacy and user-specific keys
    await preferences.remove(LEGACY_KEY_COIN);
    await preferences.remove('KeyCoin_$userId');

    if (userId == _currentUserId) {
      coin = 0;
      notifyListeners();
    }

    print("All coin data deleted for user: $userId");
  }

  /// Comprehensive reset that clears ALL possible coin keys
  Future<void> resetAllCoinData() async {
    final allKeys = preferences.getKeys();

    // Find all coin-related keys
    final coinKeys = allKeys.where((key) =>
      key == 'KeyCoin' ||  // Legacy key
      key.startsWith('KeyCoin_') ||  // User-specific keys
      key.contains('coin') ||  // Any key containing 'coin'
      key.contains('Coin')     // Any key containing 'Coin'
    ).toList();

    print("Found ${coinKeys.length} coin-related keys to delete:");
    for (final key in coinKeys) {
      print("Deleting coin key: $key");
      await preferences.remove(key);
    }

    // Set current user's coins to 0
    coin = 0;
    await preferences.setInt(keyCoin, 0);

    notifyListeners();
    print("All coin data cleared. Current coins: $coin");
  }
}

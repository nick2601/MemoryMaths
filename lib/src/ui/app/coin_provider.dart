import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing the user's coin balance.
/// Handles retrieving, adding, and subtracting coins.
class CoinProvider with ChangeNotifier {
  final SharedPreferences preferences;
  int coin = 0;
  String keyCoin = 'KeyCoin';

  /// Constructor that accepts SharedPreferences for dependency injection
  CoinProvider({required this.preferences}) {
    _loadCoin();
  }

  /// Loads the coin balance from shared preferences
  void _loadCoin() {
    coin = preferences.getInt(keyCoin) ?? 0;
    print("coin===$coin");
    notifyListeners();
  }

  /// Retrieves the current coin balance from persistent storage.
  getCoin() async {
    coin = preferences.getInt(keyCoin) ?? 0;
    print("coin===$coin");
    notifyListeners();
  }

  /// Adds coins for a correct answer and updates the balance.
  addCoin() async {
    print("coin===12 $coin");
    await preferences.setInt(keyCoin, (coin + rightCoin));
    getCoin();
  }

  /// Subtracts coins for a wrong answer or usage, and updates the balance.
  /// [useCoin] - Optional custom amount to subtract.
  minusCoin({int? useCoin}) async {
    int i = (useCoin == null) ? wrongCoin : useCoin;
    await preferences.setInt(keyCoin, ((coin - i) >= 0) ? (coin - i) : 0);
    getCoin();
  }
}

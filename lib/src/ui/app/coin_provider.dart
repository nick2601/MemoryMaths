import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// Global provider for coins
final coinProvider = StateNotifierProvider<CoinNotifier, int>((ref) {
  return CoinNotifier();
});

class CoinNotifier extends StateNotifier<int> {
  CoinNotifier() : super(0) {
    _loadCoins();
  }

  /// Load coins from Hive storage
  void _loadCoins() {
    final box = Hive.box('coins');
    state = box.get('value', defaultValue: 0);
  }

  /// Add coins
  void addCoins(int value) {
    state += value;
    Hive.box('coins').put('value', state);
  }

  /// Deduct coins (safe, won’t go below 0)
  void minusCoins(int value) {
    if (state >= value) {
      state -= value;
      Hive.box('coins').put('value', state);
    }
  }

  /// Reset coins to 0
  void resetCoins() {
    state = 0;
    Hive.box('coins').put('value', state);
  }
}
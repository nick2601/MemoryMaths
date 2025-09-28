import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final coinProvider = StateNotifierProvider<CoinNotifier, int>((ref) {
  return CoinNotifier();
});

class CoinNotifier extends StateNotifier<int> {
  CoinNotifier() : super(0) {
    _loadCoins();
  }

  void _loadCoins() {
    final box = Hive.box('coins');
    state = box.get('value', defaultValue: 0);
  }

  void addCoins(int value) {
    state += value;
    Hive.box('coins').put('value', state);
  }

  void spendCoins(int value) {
    if (state >= value) {
      state -= value;
      Hive.box('coins').put('value', state);
    }
  }
}
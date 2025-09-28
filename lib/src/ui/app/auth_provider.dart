import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    _loadAuth();
  }

  void _loadAuth() {
    final box = Hive.box('settings');
    final loggedIn = box.get('loggedIn', defaultValue: false);
    state = loggedIn;
  }

  void login() {
    state = true;
    Hive.box('settings').put('loggedIn', true);
  }

  void logout() {
    state = false;
    Hive.box('settings').put('loggedIn', false);
  }
}
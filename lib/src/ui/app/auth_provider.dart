import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// AuthState holds current login state and credentials.
class AuthState {
  final bool isLoggedIn;
  final String email;
  final String password;

  const AuthState({
    this.isLoggedIn = false,
    this.email = "",
    this.password = "",
  });

  AuthState copyWith({
    bool? isLoggedIn,
    String? email,
    String? password,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

/// Notifier manages authentication logic (Hive-based for now).
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _loadAuth();
  }

  void _loadAuth() {
    final box = Hive.box('settings');
    final loggedIn = box.get('loggedIn', defaultValue: false) as bool;
    final savedEmail = box.get('email', defaultValue: "") as String;
    final savedPassword = box.get('password', defaultValue: "") as String;

    state = state.copyWith(
      isLoggedIn: loggedIn,
      email: savedEmail,
      password: savedPassword,
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
    Hive.box('settings').put('email', email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
    Hive.box('settings').put('password', password);
  }

  /// Fake login (replace with Firebase later if needed)
  Future<void> login(String email, String password) async {
    // ✅ For now, allow login if email & password are non-empty
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty.");
    }

    state = state.copyWith(isLoggedIn: true, email: email, password: password);

    final box = Hive.box('settings');
    box.put('loggedIn', true);
    box.put('email', email);
    box.put('password', password);
  }
  Future<void> signup(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty.");
    }

    final box = Hive.box('settings');
    box.put('email', email);
    box.put('password', password);

    // 👇 Only sets credentials; user still needs to login separately
    state = state.copyWith(email: email, password: password);
  }
  void logout() {
    state = state.copyWith(isLoggedIn: false, email: "", password: "");
    final box = Hive.box('settings');
    box.put('loggedIn', false);
    box.delete('email');
    box.delete('password');
  }
}

/// Riverpod provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
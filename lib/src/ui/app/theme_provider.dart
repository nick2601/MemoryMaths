import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  bool get isDarkMode => state == ThemeMode.dark;

  void _loadTheme() {
    final box = Hive.box('settings');
    final isDark = box.get('isDarkMode', defaultValue: false);
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final newTheme =
    state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;
    Hive.box('settings').put('isDarkMode', newTheme == ThemeMode.dark);
  }
}

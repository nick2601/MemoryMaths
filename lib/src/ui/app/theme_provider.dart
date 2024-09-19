import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

String lightFolder = 'assets/light/';
String darkFolder = 'assets/dark/';
ThemeMode themeMode = ThemeMode.light;

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  ThemeProvider({required this.sharedPreferences}) {
    themeMode =
        ThemeMode.values[sharedPreferences.getInt(KeyUtil.IS_DARK_MODE) ?? 1];
  }

  void changeTheme() async {
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;

    notifyListeners();
    await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, themeMode.index);
  }
}

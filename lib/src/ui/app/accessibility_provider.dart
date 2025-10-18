import 'package:flutter/foundation.dart';

/// Holds user accessibility & assistive gameplay preferences.
/// These flags can be queried throughout the UI and gameplay logic.
class AccessibilityProvider extends ChangeNotifier {
  bool _adaptiveDifficultyEnabled = true;
  bool _dyslexicModeEnabled = false;
  bool _highContrastEnabled = false;
  bool _largeTextEnabled = false;

  bool get adaptiveDifficultyEnabled => _adaptiveDifficultyEnabled;

  bool get dyslexicModeEnabled => _dyslexicModeEnabled;

  bool get highContrastEnabled => _highContrastEnabled;

  bool get largeTextEnabled => _largeTextEnabled;

  void toggleAdaptiveDifficulty(bool v) {
    if (_adaptiveDifficultyEnabled != v) {
      _adaptiveDifficultyEnabled = v;
      notifyListeners();
    }
  }

  void toggleDyslexicMode(bool v) {
    if (_dyslexicModeEnabled != v) {
      _dyslexicModeEnabled = v;
      notifyListeners();
    }
  }

  void toggleHighContrast(bool v) {
    if (_highContrastEnabled != v) {
      _highContrastEnabled = v;
      notifyListeners();
    }
  }

  void toggleLargeText(bool v) {
    if (_largeTextEnabled != v) {
      _largeTextEnabled = v;
      notifyListeners();
    }
  }

  Map<String, dynamic> snapshot() => {
        'adaptiveDifficulty': _adaptiveDifficultyEnabled,
        'dyslexicMode': _dyslexicModeEnabled,
        'highContrast': _highContrastEnabled,
        'largeText': _largeTextEnabled,
      };
}

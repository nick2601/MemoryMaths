import 'dart:math';

/// AdaptiveDifficultyManager analyzes recent player performance and suggests
/// adjusted difficulty parameters (e.g., level scaling, time, number ranges).
/// It is intentionally lightweight and stateless except for a rolling history
/// so it can be easily injected or recreated.
class AdaptiveDifficultyManager {
  /// Rolling window size for performance samples.
  final int windowSize;

  /// Minimum and maximum allowed level adjustments.
  final int minLevel;
  final int maxLevel;

  /// Internal history of performances (0.0 - 1.0 accuracy values per item).
  final List<double> _accuracyHistory = [];

  /// Average response time (ms) history for smoothing.
  final List<int> _responseTimeHistory = [];

  AdaptiveDifficultyManager({
    this.windowSize = 20,
    this.minLevel = 1,
    this.maxLevel = 100,
  });

  /// Records the outcome of a single question.
  /// [isCorrect] -> whether the answer was correct.
  /// [responseMillis] -> how long the user took.
  void recordSample({required bool isCorrect, required int responseMillis}) {
    _accuracyHistory.add(isCorrect ? 1.0 : 0.0);
    _responseTimeHistory.add(responseMillis);
    if (_accuracyHistory.length > windowSize) {
      _accuracyHistory.removeAt(0);
    }
    if (_responseTimeHistory.length > windowSize) {
      _responseTimeHistory.removeAt(0);
    }
  }

  /// Returns a smoothed accuracy (0.0 - 1.0) over the window.
  double get smoothedAccuracy {
    if (_accuracyHistory.isEmpty) return 0.0;
    return _accuracyHistory.reduce((a, b) => a + b) / _accuracyHistory.length;
  }

  /// Returns median response time to reduce outlier influence.
  int get medianResponseTimeMs {
    if (_responseTimeHistory.isEmpty) return 0;
    final sorted = [..._responseTimeHistory]..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length % 2 == 1) {
      return sorted[mid];
    }
    return ((sorted[mid - 1] + sorted[mid]) / 2).round();
  }

  /// Suggests a difficulty adjustment delta based on accuracy & speed.
  /// Positive -> increase difficulty, Negative -> decrease.
  int suggestLevelDelta() {
    final acc = smoothedAccuracy; // target maybe ~0.75
    final median = medianResponseTimeMs; // quicker responses -> harder

    int delta = 0;

    if (acc > 0.85) {
      delta += 1;
    } else if (acc < 0.55) {
      delta -= 1;
    }

    // Response speed thresholds (tunable):
    if (median > 0 && median < 2500 && acc >= 0.70) {
      delta += 1; // fast and decent accuracy
    } else if (median > 6000 && acc < 0.65) {
      delta -= 1; // slow and low accuracy
    }

    // Clamp between -2 and +2 for stability
    return delta.clamp(-2, 2);
  }

  /// Produces an adjusted next level from a current [level].
  int adjustedLevel(int level) {
    final delta = suggestLevelDelta();
    return max(minLevel, min(maxLevel, level + delta));
  }

  /// Returns a diagnostic snapshot for debugging or reporting.
  Map<String, dynamic> snapshot({int? currentLevel}) => {
        'windowSize': windowSize,
        'samples': _accuracyHistory.length,
        'smoothedAccuracy': smoothedAccuracy,
        'medianResponseTimeMs': medianResponseTimeMs,
        'suggestedDelta': suggestLevelDelta(),
        if (currentLevel != null)
          'adjustedLevel': adjustedLevel(currentLevel),
      };
}


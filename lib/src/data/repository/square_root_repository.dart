import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating square root math problems
/// with multiple choice answers based on different difficulty levels.
class SquareRootRepository {
  /// Tracks unique problem keys to avoid duplicates
  static final Set<String> _uniqueQuestions = <String>{};

  /// Generates a list of square root problems for a given difficulty level
  ///
  /// [level] determines the range of numbers used:
  /// - Level 1: Numbers between 1–10
  /// - Level n: Numbers between (5n–5) to (5n+5)
  ///
  /// Returns a list of [SquareRoot] objects containing questions and answers
  static List<SquareRoot> getSquareDataList(int level) {
    if (level == 1) {
      _uniqueQuestions.clear(); // reset for new game session
    }

    final List<SquareRoot> list = <SquareRoot>[];

    final int min = (level == 1) ? 1 : (5 * level) - 5;
    final int max = (level == 1) ? 10 : (5 * level) + 5;

    int attempts = 0;
    const int maxAttempts = 200;

    // Generate 5 unique problems
    while (list.length < 5 && attempts < maxAttempts) {
      attempts++;

      MathUtil.generateRandomNumbers(min, max, 5 - list.length)
          .map(int.parse)
          .forEach((int x1) {
        final question = (x1 * x1).toString();
        final key = "$question:$x1";

        if (_uniqueQuestions.contains(key)) return;

        final options = _generateOptions(x1);

        final squareRootQandS = SquareRoot(
          question, // Question is the square
          options[0],
          options[1],
          options[2],
          options[3],
          x1, // Correct answer
        );

        _uniqueQuestions.add(key);
        list.add(squareRootQandS);
      });
    }

    return list;
  }

  /// Generates 4 options (1 correct + 3 distractors) for a square root problem
  static List<String> _generateOptions(int correct) {
    final List<int> options = [correct];

    while (options.length < 4) {
      final int distractor =
      MathUtil.generateRandomAnswer((correct - 5).clamp(1, correct), correct + 5);

      if (!options.contains(distractor)) {
        options.add(distractor);
      }
    }

    options.shuffle();
    return options.map((e) => e.toString()).toList();
  }
}

// Test function to generate problems for levels 1–4
void main() {
  for (int i = 1; i < 5; i++) {
    final problems = SquareRootRepository.getSquareDataList(i);
    print("Level $i:");
    for (final p in problems) {
      print("√${p.question} = ?  Options: [${p.firstAns}, ${p.secondAns}, ${p.thirdAns}, ${p.fourthAns}]  Answer: ${p.answer}");
    }
  }
}
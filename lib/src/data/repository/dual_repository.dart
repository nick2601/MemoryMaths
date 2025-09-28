import 'package:mathsgames/src/data/RandomDualData.dart';
import 'package:mathsgames/src/data/models/quiz_model.dart';

/// Repository class that generates quiz questions for dual operations
/// (addition, subtraction, multiplication, division).
class DualRepository {
  /// Stores hash codes of generated quiz models to avoid duplicates
  static final Set<int> _generatedHashes = <int>{};

  /// Generates a list of 5 unique quiz questions for the given [level].
  ///
  /// Parameters:
  /// - [level]: Difficulty level (starting from 1).
  ///
  /// Returns:
  /// A [List] of [QuizModel] containing 5 randomly generated questions.
  static List<QuizModel> getDualData(int level) {
    // Reset hash set for a new game session at level 1
    if (level == 1) {
      _generatedHashes.clear();
    }

    final List<QuizModel> questions = [];
    final RandomDualData generator = RandomDualData(level);

    // Generate until we have 5 unique quiz questions
    while (questions.length < 5) {
      final quiz = generator.getRandomQuestion();

      // Only add if not seen before
      if (_generatedHashes.add(quiz.hashCode)) {
        questions.add(quiz);
      }
    }

    return questions;
  }
}

/// Test function to generate and display quiz data for levels 1–4
void main() {
  for (int i = 1; i <= 4; i++) {
    final data = DualRepository.getDualData(i);
    print("Level $i generated ${data.length} questions:");
    data.forEach(print);
  }
}

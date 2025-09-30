import 'package:mathsgames/src/data/models/random_duel_data.dart';

import 'package:mathsgames/src/data/models/quiz_model.dart';

/// Repository class that handles the generation and management of dual quiz data.
/// This class provides methods to generate quiz questions based on different levels.
class DualRepository {
  /// Stores previously generated hashcodes to avoid duplicate questions
  static List<int> listHasCode = <int>[];

  /// Generates a list of quiz questions for a specific level
  ///
  /// Parameters:
  ///   - level: The difficulty level of the questions (starting from 1)
  ///
  /// Returns:
  ///   A list of [QuizModel] containing 5 randomly generated questions
  static getDualData(int level) {
    // Reset hashcode list when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Initialize empty list to store quiz questions
    List<QuizModel> list = <QuizModel>[];

    // Create random data generator for the specified level
    RandomDualData learnData = RandomDualData(level);

    // Generate 5 unique questions
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    return list;
  }
}

/// Test function to generate quiz data for levels 1-4
void main() {
  for (int i = 1; i < 5; i++) {
    DualRepository.getDualData(i);
  }
}

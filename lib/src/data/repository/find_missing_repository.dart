import 'package:mathsgames/src/data/models/find_missing_model.dart';
import '../RandomFindMissingData.dart';

/// Repository class that generates "Find the Missing Number" quiz questions
/// for different difficulty levels.
class FindMissingRepository {
  /// Stores hash codes of generated quiz models to avoid duplicates
  static final Set<int> _generatedHashes = <int>{};

  /// Generates a list of 5 unique "Find the Missing Number" quiz questions
  /// for the given [level].
  ///
  /// Parameters:
  /// - [level]: Difficulty level of the questions (1–5).
  ///
  /// Returns:
  /// A [List] of [FindMissingQuizModel] containing 5 unique questions.
  static List<FindMissingQuizModel> getFindMissingDataList(int level) {
    // Reset tracking set at level 1
    if (level == 1) {
      _generatedHashes.clear();
    }

    final List<FindMissingQuizModel> list = [];
    final RandomFindMissingData generator = RandomFindMissingData(level);

    // Generate until 5 unique questions are added
    while (list.length < 5) {
      final quiz = generator.getMethods();

      // Only add if unique
      if (_generatedHashes.add(quiz.hashCode)) {
        list.add(quiz);
      }
    }

    return list;
  }
}

/// Test function to generate and display quiz questions for levels 1–4
void main() {
  for (int i = 1; i <= 4; i++) {
    final data = FindMissingRepository.getFindMissingDataList(i);
    print("Level $i generated ${data.length} questions:");
    data.forEach(print);
  }
}
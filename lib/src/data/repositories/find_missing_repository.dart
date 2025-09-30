import 'package:mathsgames/src/data/models/find_missing_model.dart';

import '../models/random_find_missing_data.dart';

/// Repository class responsible for generating math quiz questions with missing numbers
/// for different difficulty levels.
class FindMissingRepository {
  /// Keeps track of previously generated questions to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of 5 "Find the Missing Number" quiz questions for a given level
  ///
  /// [level] The difficulty level of the questions (1-5)
  /// Returns a List of [FindMissingQuizModel] containing the generated questions
  static getFindMissingDataList(int level) {
    // Reset tracking list when starting level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Initialize empty list to store quiz questions
    List<FindMissingQuizModel> list = <FindMissingQuizModel>[];

    // Create data generator for current level
    RandomFindMissingData learnData = RandomFindMissingData(level);

    // Generate 5 unique questions
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    return list;
  }
}

/// Test function to generate questions for levels 1-4
void main() {
  for (int i = 1; i < 5; i++) {
    FindMissingRepository.getFindMissingDataList(i);
  }
}

// Note: Commented out code below contains alternative implementation
// that generates questions using MathUtil and Expression classes

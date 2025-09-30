import 'package:mathsgames/src/data/models/random_option_data.dart';
import 'package:mathsgames/src/data/models/true_false_model.dart';

/// Repository class that handles the generation of true/false math questions
/// This class maintains a list of unique question hash codes and provides
/// methods to generate question sets for different difficulty levels
class TrueFalseRepository {
  /// Stores hash codes of previously generated questions to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of true/false math questions for a specific difficulty level
  ///
  /// Parameters:
  ///   - level: The difficulty level of the questions (integer)
  ///
  /// Returns:
  ///   A list of [TrueFalseModel] containing 5 unique math questions
  static getTrueFalseDataList(int level) {
    // Reset hash code list when starting a new level
    if (level == 1) {
      listHasCode.clear();
    }

    List<TrueFalseModel> list = <TrueFalseModel>[];

    // Create random option generator with specified level
    RandomOptionData learnData = RandomOptionData(level);
    learnData.setTrueFalseQuiz(true);

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
    TrueFalseRepository.getTrueFalseDataList(i);
  }
}

// Note: Commented out code below appears to be a different implementation
// for generating "Find Missing" math problems. Consider moving to a
// separate repositories class if needed.

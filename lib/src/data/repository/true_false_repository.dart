import 'package:mathsgames/src/data/RandomOptionData.dart';
import 'package:mathsgames/src/data/models/true_false_model.dart';

/// Repository class that handles the generation of true/false math questions.
/// This class ensures uniqueness of generated questions per level.
class TrueFalseRepository {
  /// Tracks unique questions to avoid duplicates
  static final Set<String> _uniqueQuestions = <String>{};

  /// Generates a list of true/false math questions for a specific difficulty level.
  ///
  /// Parameters:
  ///   - [level]: The difficulty level of the questions (1–n).
  ///
  /// Returns:
  ///   A list of [TrueFalseModel] containing 5 unique math questions.
  static List<TrueFalseModel> getTrueFalseDataList(int level) {
    if (level == 1) {
      _uniqueQuestions.clear(); // reset for new game session
    }

    final List<TrueFalseModel> list = <TrueFalseModel>[];

    final RandomOptionData generator = RandomOptionData(level)..setTrueFalseQuiz(true);

    int attempts = 0;
    const int maxAttempts = 200;

    while (list.length < 5 && attempts < maxAttempts) {
      attempts++;

      final questionModel = generator.getMethods();
      final key = "${questionModel.question}:${questionModel.answer}";

      if (_uniqueQuestions.contains(key)) continue;

      _uniqueQuestions.add(key);
      list.add(questionModel);
    }

    return list;
  }
}

/// Test function to generate questions for levels 1–4
void main() {
  for (int i = 1; i < 5; i++) {
    final questions = TrueFalseRepository.getTrueFalseDataList(i);
    print("Level $i:");
    for (final q in questions) {
      print("Q: ${q.question} | Ans: ${q.answer} | Options: ${q.optionList}");
    }
  }
}
import 'package:mathsgames/src/data/models/numeric_memory_answer_pair.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class that handles the generation of numeric memory pairs
/// for the memory game.
class NumericMemoryRepository {
  /// Keeps track of previously generated math pairs to avoid duplicates
  static final List<int> _listHasCode = <int>[];

  /// Generates a list of numeric memory pairs for a given difficulty level.
  ///
  /// [level] - The difficulty level of the game (1-5).
  /// Returns a list of [NumericMemoryPair] objects containing questions
  /// and possible answers.
  static List<NumericMemoryPair> getNumericMemoryDataList(int level) {
    if (level == 1) {
      _listHasCode.clear();
    }

    final int totalPairs = level <= 2 ? 12 : 18;
    final List<NumericMemoryPair> memoryList = <NumericMemoryPair>[];

    // Generate until we fill required pairs
    while (memoryList.length < totalPairs) {
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (memoryList.length ~/ 2))
          .forEach((expression) {
        if (expression.answer > 0) {
          // Create answer options
          final List<NumericMemoryAnswerPair> options = [
            getModel("${expression.firstOperand} + ${expression.secondOperand}"),
            getModel("${expression.firstOperand} - ${expression.secondOperand}"),
            getModel("${expression.firstOperand} / ${expression.secondOperand}"),
            getModel("${expression.firstOperand} * ${expression.secondOperand}"),
          ];

          // Add empty options for difficulty
          for (int i = 0; i < 8; i++) {
            options.add(getModel(""));
          }

          options.shuffle();

          final numericMemoryPair = NumericMemoryPair(
            question: expression.answer,
            answer:
            "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            options: options,
          );

          // Prevent duplicates
          if (!_listHasCode.contains(numericMemoryPair.hashCode)) {
            _listHasCode.add(numericMemoryPair.hashCode);
            memoryList.add(numericMemoryPair);
          }
        }
      });
    }

    return memoryList;
  }

  /// Creates a [NumericMemoryAnswerPair] with the given string as key.
  static NumericMemoryAnswerPair getModel(String s) {
    return NumericMemoryAnswerPair(key: s);
  }
}

/// Test function to generate memory pairs for levels 1-5
void main() {
  for (int i = 1; i < 6; i++) {
    final data = NumericMemoryRepository.getNumericMemoryDataList(i);
    print("Level $i generated ${data.length} memory pairs");
  }
}

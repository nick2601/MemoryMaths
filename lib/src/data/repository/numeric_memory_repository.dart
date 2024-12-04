import 'package:mathsgames/src/data/RandomFindMissingData.dart';
import 'package:mathsgames/src/data/models/numeric_memory_answer_pair.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class that handles the generation of numeric memory pairs for the memory game
class NumericMemoryRepository {
  /// Keeps track of previously generated math pairs to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of numeric memory pairs for a given difficulty level
  ///
  /// [level] - The difficulty level of the game (1-5)
  /// Returns a list of [NumericMemoryPair] objects containing questions and possible answers
  static getNumericMemoryDataList(int level) {
    // Reset hash codes when starting a new game at level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Set number of total pairs based on level
    int totalPairs = level <= 2 ? 12 : 18;

    List<NumericMemoryPair> memoryList = <NumericMemoryPair>[];

    // Generate pairs until we have at least one valid pair
    while (memoryList.length < 1) {
      // Get math expressions for current level
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (memoryList.length ~/ 2))
          .forEach((Expression expression) {
        // Only use expressions with positive answers
        if (expression.answer > 0) {
          NumericMemoryPair numericMemoryPair = new NumericMemoryPair();
          // The question is the answer to the expression
          numericMemoryPair.question = expression.answer;
          // The answer is the expression itself
          numericMemoryPair.answer =
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}";

          // Generate list of possible answers including all operations
          List<NumericMemoryAnswerPair> list = [];

          // Add all possible operations between the operands
          list.add(getModel(
              "${expression.firstOperand} + ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} - ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} / ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} * ${expression.secondOperand}"));

          // Add empty options to increase difficulty
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));

          // Shuffle the list twice to ensure randomness
          shuffle(list);
          shuffle(list);

          numericMemoryPair.list = list;
          memoryList.add(numericMemoryPair);
        }
      });
    }

    return memoryList;
  }

  /// Creates a new [NumericMemoryAnswerPair] with the given string as key
  ///
  /// [s] - The string to use as the key for the answer pair
  static NumericMemoryAnswerPair getModel(String s) {
    NumericMemoryAnswerPair model = new NumericMemoryAnswerPair();
    model.key = s;
    return model;
  }
}

/// Test function to generate memory pairs for levels 1-5
void main() {
  for (int i = 1; i < 6; i++) {
    NumericMemoryRepository.getNumericMemoryDataList(i);
  }
}

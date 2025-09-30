import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating math pairs for the matching game.
/// Each pair consists of a mathematical expression and its corresponding answer.
class MathPairsRepository {
  /// Keeps track of previously generated math pairs to avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of math pairs for a given difficulty level
  ///
  /// [level] - Difficulty level of the math problems (1-5)
  /// Returns a list containing a single [MathPairs] object with the generated pairs
  static getMathPairsDataList(int level) {
    // Reset hash codes when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    int i = 0;
    // Set number of pairs based on level
    // Levels 1-2: 12 pairs (24 cards)
    // Levels 3+: 18 pairs (36 cards)
    int totalPairs = level <= 2 ? 12 : 18;

    List<Pair> list = <Pair>[];

    // Generate pairs until we reach the required total
    while (list.length < totalPairs) {
      // Generate math expressions using MathUtil
      // Calculate how many more pairs we need: (totalPairs / 2) - (current pairs / 2)
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (list.length ~/ 2))
          .forEach((Expression expression) {
        // Create two matching pairs:
        // First pair contains the expression (e.g., "2 + 3")
        Pair mathPair1 = Pair(
            i,
            "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            false,
            true);
        // Second pair contains the answer (e.g., "5")
        Pair mathPair2 = Pair(i, "${expression.answer}", false, true);

        // Only add the pairs if they're unique
        if (!list.contains(mathPair2) &&
            !listHasCode.contains(mathPair1.hashCode)) {
          list.add(mathPair1);
          list.add(mathPair2);
          listHasCode.add(mathPair1.hashCode);
          i++;
        }
      });
    }

    // Randomize the order of pairs
    list.shuffle();
    return <MathPairs>[MathPairs(list, totalPairs)];
  }
}

/// Test function to generate math pairs for levels 1-5
void main() {
  for (int i = 1; i < 6; i++) {
    MathPairsRepository.getMathPairsDataList(i);
  }
}

import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/utility/math_util.dart';

/// Repository class responsible for generating math pairs for the matching game.
/// Each pair consists of a mathematical expression and its corresponding answer.
class MathPairsRepository {
  /// Keeps track of previously generated math pairs to avoid duplicates
  static final List<int> _usedHashCodes = <int>[];

  /// Generates a list of math pairs for a given difficulty level.
  ///
  /// [level] - Difficulty level of the math problems (1-5)
  /// Returns a list containing a single [MathPairs] object with the generated pairs.
  static List<MathPairs> getMathPairsDataList(int level) {
    // Reset hash codes when starting from level 1
    if (level == 1) {
      _usedHashCodes.clear();
    }

    // Levels 1-2: 12 pairs (24 cards), Levels 3+: 18 pairs (36 cards)
    final int totalPairs = (level <= 2) ? 12 : 18;
    final List<Pair> pairs = <Pair>[];

    int uidCounter = 0;

    // Generate until required total pairs are reached
    while (pairs.length < totalPairs) {
      // Number of expressions needed = half the pairs still missing
      final int expressionsNeeded = (totalPairs ~/ 2) - (pairs.length ~/ 2);

      MathUtil.getMathPair(level, expressionsNeeded).forEach((expression) {
        final Pair expressionPair = Pair(
          uid: uidCounter,
          text: "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
        );

        final Pair answerPair = Pair(
          uid: uidCounter,
          text: expression.answer.toString(),
        );

        // Add only if unique
        if (!_usedHashCodes.contains(expressionPair.hashCode)) {
          pairs.add(expressionPair);
          pairs.add(answerPair);
          _usedHashCodes.add(expressionPair.hashCode);
          uidCounter++;
        }
      });
    }

    // Shuffle for randomness
    pairs.shuffle();
    return <MathPairs>[MathPairs(list: pairs)];
  }
}

/// Test function to generate math pairs for levels 1-5
void main() {
  for (int i = 1; i <= 5; i++) {
    final pairs = MathPairsRepository.getMathPairsDataList(i);
    print("Level $i generated ${pairs.first.list.length} items.");
  }
}

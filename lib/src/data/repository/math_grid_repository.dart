import 'dart:math';
import 'package:mathsgames/src/data/models/math_grid.dart';

/// Repository class that handles the generation and management of math grid data.
/// Used for creating number grids for math puzzle games.
class MathGridRepository {
  /// Generates repeated lists of numbers from 1 to 9 (each repeated 9 times).
  static final List<int> _allNumbers = List<int>.generate(9, (i) => i + 1)
      .expand((n) => List.filled(9, n))
      .toList();

  /// Generates a single math grid with randomly shuffled numbers.
  /// Returns a [MathGrid] object containing a 9x9 grid of numbers.
  static MathGrid listForSquare() {
    final List<int> shuffled = List<int>.from(_allNumbers)..shuffle();

    final List<MathGridCellModel> listGrid = List.generate(
      shuffled.length,
          (i) => MathGridCellModel(index: i, value: shuffled[i], isActive: false, isRemoved: false),
    );

    return MathGrid(listForSquare: listGrid);
  }

  /// Generates a random number between 5 and 40 (inclusive).
  /// Used for creating target answers in the math puzzle.
  static int generateRandomAnswer() {
    const int min = 5;
    const int max = 40;
    return min + Random().nextInt(max - min + 1); // inclusive upper bound
  }

  /// Creates a list of math grids based on the given level.
  /// Currently generates 5 math grids regardless of level.
  static List<MathGrid> getMathGridData(int level) {
    return List.generate(5, (_) => listForSquare());
  }
}

void main() {
  final grids = MathGridRepository.getMathGridData(1);
  print("Generated ${grids.length} math grids.");
}
import 'package:mathsgames/src/data/models/math_grid.dart';
import 'dart:math';

/// Repository class that handles the generation and management of math grid data
/// Used for creating number grids for math puzzle games
class MathGridRepository {
  // Pre-generated lists of repeated numbers 1-9
  static List<int> listOf9 = List<int>.generate(9, (i) => 9);
  static List<int> listOf8 = List<int>.generate(9, (i) => 8);
  static List<int> listOf7 = List<int>.generate(9, (i) => 7);
  static List<int> listOf6 = List<int>.generate(9, (i) => 6);
  static List<int> listOf5 = List<int>.generate(9, (i) => 5);
  static List<int> listOf4 = List<int>.generate(9, (i) => 4);
  static List<int> listOf3 = List<int>.generate(9, (i) => 3);
  static List<int> listOf2 = List<int>.generate(9, (i) => 2);
  static List<int> listOf1 = List<int>.generate(9, (i) => 1);

  /// Generates a single math grid with randomly shuffled numbers
  /// Returns a [MathGrid] object containing a 9x9 grid of numbers
  static MathGrid listForSquare() {
    int sum = 0;
    List<int> list = <int>[];
    List<MathGridCellModel> listGrid = <MathGridCellModel>[];

    // Combine all number lists into one
    list = listOf9 +
        listOf8 +
        listOf7 +
        listOf6 +
        listOf5 +
        listOf4 +
        listOf3 +
        listOf2 +
        listOf1;

    // Randomly shuffle the combined list
    list.shuffle();

    // Create grid cells with position, value, and initial states
    for (int i = 0; i < list.length; i++) {
      listGrid.add(MathGridCellModel(i, list[i], false, false));
      sum = sum + list[i];
    }

    return MathGrid(listForSquare: listGrid);
  }

  /// Generates a random number between 5 and 39 (inclusive)
  /// Used for creating target answers in the math puzzle
  static int generateRandomAnswer() {
    final _random = new Random();
    int min = 5;
    int max = 40;
    int result = min + _random.nextInt(max - min);
    return result;
  }

  /// Creates a list of math grids based on the given level
  /// [level] determines the difficulty or configuration of the grids
  /// Returns a List of [MathGrid] objects
  static getMathGridData(int level) {
    List<MathGrid> list = <MathGrid>[];
    // Generate 5 different math grids
    list.add(listForSquare());
    list.add(listForSquare());
    list.add(listForSquare());
    list.add(listForSquare());
    list.add(listForSquare());
    return list;
  }
}

void main() {}

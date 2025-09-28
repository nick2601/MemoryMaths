import 'package:mathsgames/src/data/models/magic_triangle.dart';

/// Repository class that manages Magic Triangle puzzle data and configurations.
/// Provides puzzle generation for different difficulty levels and helper methods
/// to create triangle grids and input fields.
class MagicTriangleRepository {
  /// Predefined sets of numbers for different target sums in magic triangle puzzles.
  static const Map<String, List<int>> correctMagicTriangle = {
    // Basic level configurations (6 numbers)
    "9": [1, 2, 3, 4, 5, 6],
    "10": [1, 2, 3, 4, 5, 6],
    "11": [1, 2, 3, 4, 5, 6],
    "12": [1, 2, 3, 4, 5, 6],
    "18": [4, 5, 6, 7, 8, 9],

    // Advanced level configurations (9 numbers)
    "17": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "19": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "20": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "21": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "23": [1, 2, 3, 4, 5, 6, 7, 8, 9],

    // Special level with square numbers
    "126": [1, 4, 9, 16, 25, 36, 49, 64, 81],
  };

  /// Generates a list of basic-level triangle puzzles (6 numbers).
  static List<MagicTriangle> getTriangleDataProviderList() {
    final List<MagicTriangle> list = [
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['9']!),
        listTriangle: getMagicTriangleInput(6),
        answer: 9,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['10']!),
        listTriangle: getMagicTriangleInput(6),
        answer: 10,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['11']!),
        listTriangle: getMagicTriangleInput(6),
        answer: 11,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['12']!),
        listTriangle: getMagicTriangleInput(6),
        answer: 12,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['18']!),
        listTriangle: getMagicTriangleInput(6),
        answer: 18,
      ),
    ];

    list.shuffle();
    return list;
  }

  /// Generates a list of advanced-level triangle puzzles (9 numbers).
  static List<MagicTriangle> getNextLevelTriangleDataProviderList() {
    final List<MagicTriangle> list = [
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['20']!),
        listTriangle: getMagicTriangleInput(9),
        answer: 20,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['21']!),
        listTriangle: getMagicTriangleInput(9),
        answer: 21,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['23']!),
        listTriangle: getMagicTriangleInput(9),
        answer: 23,
      ),
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['126']!),
        listTriangle: getMagicTriangleInput(9),
        answer: 126,
      ),
    ];

    list.shuffle();
    return list;
  }

  /// Converts a list of numbers into [MagicTriangleGrid] objects and shuffles them.
  static List<MagicTriangleGrid> getMagicTriangleGrid(List<int> numbers) {
    final List<MagicTriangleGrid> gridList =
    numbers.map((e) => MagicTriangleGrid(e, true)).toList();
    gridList.shuffle();
    return gridList;
  }

  /// Creates a list of empty input fields for the triangle puzzle.
  /// By default, all fields are inactive.
  static List<MagicTriangleInput> getMagicTriangleInput(int length) {
    return List.generate(length, (_) => MagicTriangleInput(false, null));
  }
}

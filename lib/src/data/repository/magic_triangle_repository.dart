import 'package:mathsgames/src/data/models/magic_triangle.dart';

/// Repository class that manages Magic Triangle puzzle data and configurations.
/// This class provides methods to generate puzzle data for different difficulty levels
/// and handles the creation of triangle grids and input fields.
class MagicTriangleRepository {
  /// Map of correct solutions for different magic triangle sums.
  /// The key represents the target sum, and the value is a list of numbers
  /// that can be arranged to achieve that sum.
  static Map correctMagicTriangle = {
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
    "126": [
      1,
      4,
      9,
      16,
      25,
      36,
      49,
      64,
      81,
    ]
  };

  /// Returns a shuffled list of basic-level triangle puzzles.
  /// Each puzzle uses 6 numbers and has different target sums.
  static getTriangleDataProviderList() {
    List<MagicTriangle> list = <MagicTriangle>[];

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['9']),
        listTriangle: getMagicTriangleInput(6),
        answer: 9,
      ),
    );

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['10']),
        listTriangle: getMagicTriangleInput(6),
        answer: 10,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['11']),
        listTriangle: getMagicTriangleInput(6),
        answer: 11,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['12']),
        listTriangle: getMagicTriangleInput(6),
        answer: 12,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['18']),
        listTriangle: getMagicTriangleInput(6),
        answer: 18,
      ),
    );

    list.shuffle();
    return list;
  }

  /// Returns a shuffled list of advanced-level triangle puzzles.
  /// Each puzzle uses 9 numbers and has higher target sums.
  static getNextLevelTriangleDataProviderList() {
    List<MagicTriangle> list = <MagicTriangle>[];

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['20']),
        listTriangle: getMagicTriangleInput(9),
        answer: 20,
      ),
    );

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['21']),
        listTriangle: getMagicTriangleInput(9),
        answer: 21,
      ),
    );

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['23']),
        listTriangle: getMagicTriangleInput(9),
        answer: 23,
      ),
    );

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['126']),
        listTriangle: getMagicTriangleInput(9),
        answer: 126,
      ),
    );

    list.shuffle();
    return list;
  }

  /// Converts a list of numbers into MagicTriangleGrid objects and shuffles them.
  /// @param list The list of numbers to convert
  /// @return A shuffled list of MagicTriangleGrid objects
  static List<MagicTriangleGrid> getMagicTriangleGrid(List<int> list) {
    List<MagicTriangleGrid> gridList = <MagicTriangleGrid>[];
    for (int i = 0; i < list.length; i++) {
      gridList.add(MagicTriangleGrid(list[i].toString(), true));
    }
    gridList.shuffle();
    return gridList;
  }

  /// Creates a list of empty input fields for the triangle.
  /// The first position is set as inactive by default.
  /// @param length The number of input fields needed
  /// @return A list of MagicTriangleInput objects
  static List<MagicTriangleInput> getMagicTriangleInput(int length) {
    List<MagicTriangleInput> inputList = <MagicTriangleInput>[];
    for (int i = 0; i < length; i++) {
      inputList.add(MagicTriangleInput(false, ""));
    }
    inputList[0].isActive = false;
    return inputList;
  }
}

/* Solution Reference:
 * This section contains various valid solutions for different target sums.
 * Each line shows different ways to arrange numbers to achieve the target sum.
 * For example:
 * 17 = 1 + 5 + 9 + 2 = 2 + 4+ 8+ 3 = 3 + 6 + 7 + 1
 * ... existing solutions ...
 */

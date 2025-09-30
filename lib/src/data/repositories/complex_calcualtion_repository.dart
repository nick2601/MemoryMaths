import 'package:mathsgames/src/data/models/complex_data.dart';
import 'package:mathsgames/src/data/models/complex_model.dart';

/// Repository class that handles complex calculation data generation
/// and management for different game levels.
class ComplexCalculationRepository {
  /// Static list to store hash codes of previously generated values
  /// to potentially avoid duplicates
  static List<int> listHasCode = <int>[];

  /// Generates a list of complex calculation data based on the game level
  ///
  /// Parameters:
  ///   - level: Current game level (integer)
  ///
  /// Returns:
  ///   List of [ComplexModel] containing calculation data
  static getComplexData(int level) {
    // Reset hash codes when starting from level 1
    if (level == 1) {
      listHasCode.clear();
    }

    // Determine calculation type based on level difficulty
    int type = 1;

    // Level-based calculation type assignment:
    // Type 1: Levels 1-6 (Basic)
    // Type 2: Levels 7-13 (Intermediate)
    // Type 3: Levels 14+ (Advanced)
    if (level < 7) {
      type = 1;
    } else if (level <= 13) {
      type = 2;
    } else {
      // level > 13
      type = 3;
    }

    // Generate list of 5 complex calculations
    List<ComplexModel> list = <ComplexModel>[];

    while (list.length < 5) {
      list.add(ComplexData.getComplexValues(type));
    }

    return list;
  }
}

/// Test function to demonstrate repositories usage
void main() {
  for (int i = 1; i < 5; i++) {
    ComplexCalculationRepository.getComplexData(i);
  }
}

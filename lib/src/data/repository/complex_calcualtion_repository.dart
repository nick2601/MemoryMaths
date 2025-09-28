import 'package:mathsgames/src/data/ComplexData.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';

/// Repository class that handles complex calculation data generation
/// and management for different game levels.
class ComplexCalculationRepository {
  /// Stores hash codes of generated values to avoid duplicates
  static final Set<int> _generatedHashes = <int>{};

  /// Generates a list of unique complex calculation data based on the game level.
  ///
  /// Parameters:
  /// - [level]: Current game level
  ///
  /// Returns:
  /// A list of [ComplexModel] objects
  static List<ComplexModel> getComplexData(int level) {
    // Reset for a fresh start at level 1
    if (level == 1) {
      _generatedHashes.clear();
    }

    // Determine difficulty type based on level
    final int type = level < 7
        ? 1 // Basic
        : level <= 13
        ? 2 // Intermediate
        : 3; // Advanced

    final List<ComplexModel> models = [];

    // Generate until we have 5 unique problems
    while (models.length < 5) {
      final model = ComplexData.getComplexValues(type);

      // Only add if unique
      if (_generatedHashes.add(model.hashCode)) {
        models.add(model);
      }
    }

    return models;
  }
}

/// Test function to demonstrate repository usage
void main() {
  for (int i = 1; i <= 5; i++) {
    final problems = ComplexCalculationRepository.getComplexData(i);
    print("Level $i => ${problems.length} problems");
    problems.forEach(print);
  }
}
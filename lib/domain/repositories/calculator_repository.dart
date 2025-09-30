import 'package:mathsgames/domain/entities/calculator_entity.dart';

/// Repository interface for Calculator game
/// Clean Architecture: Domain Layer - Repository contracts
/// This defines what operations are available without knowing how they're implemented
abstract class CalculatorRepository {
  /// Gets a list of calculator problems for a given level
  /// Returns a Future of List<CalculatorEntity>
  Future<List<CalculatorEntity>> getCalculatorDataList(int level);

  /// Clears the cache of previously generated problems
  void clearCache();
}

import 'package:mathsgames/domain/entities/calculator_entity.dart';
import 'package:mathsgames/domain/repositories/calculator_repository.dart';

/// Use case for getting calculator problems
/// Clean Architecture: Domain Layer - Use Cases contain application-specific business rules
class GetCalculatorProblemsUseCase {
  final CalculatorRepository repository;

  GetCalculatorProblemsUseCase(this.repository);

  /// Executes the use case to get calculator problems for a level
  /// Parameters:
  ///   - level: The difficulty level
  /// Returns: Future<List<CalculatorEntity>>
  Future<List<CalculatorEntity>> execute(int level) async {
    if (level < 1) {
      throw ArgumentError('Level must be greater than 0');
    }
    return await repository.getCalculatorDataList(level);
  }
}

/// Use case for clearing calculator cache
class ClearCalculatorCacheUseCase {
  final CalculatorRepository repository;

  ClearCalculatorCacheUseCase(this.repository);

  /// Executes the use case to clear the cache
  void execute() {
    repository.clearCache();
  }
}

import 'package:mathsgames/domain/entities/calculator_entity.dart';
import 'package:mathsgames/domain/repositories/calculator_repository.dart';
import 'package:mathsgames/data/datasources/calculator_datasource.dart';
import 'package:mathsgames/src/data/models/calculator.dart';

/// Repository implementation that bridges domain and data layers
/// Clean Architecture: Data Layer - Repository Implementations
class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorDataSource dataSource;

  CalculatorRepositoryImpl({required this.dataSource});

  @override
  Future<List<CalculatorEntity>> getCalculatorDataList(int level) async {
    try {
      // Get data from datasource (which uses existing code)
      final calculatorModels = dataSource.getCalculatorDataList(level);
      
      // Convert models to entities
      return calculatorModels.map((model) => _mapToEntity(model)).toList();
    } catch (e) {
      throw Exception('Failed to get calculator data: $e');
    }
  }

  @override
  void clearCache() {
    dataSource.clearCache();
  }

  /// Maps data model to domain entity
  /// This is the mapping layer between data and domain
  CalculatorEntity _mapToEntity(Calculator model) {
    return CalculatorEntity(
      question: model.question,
      answer: model.answer,
    );
  }

  /// Maps domain entity to data model
  Calculator _mapToModel(CalculatorEntity entity) {
    return Calculator(
      question: entity.question,
      answer: entity.answer,
    );
  }
}

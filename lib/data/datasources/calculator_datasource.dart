import 'package:mathsgames/src/data/models/calculator.dart';

/// Data source interface for calculator data
/// Clean Architecture: Data Layer - Data Sources define how to get data
abstract class CalculatorDataSource {
  /// Gets calculator data from the existing implementation
  List<Calculator> getCalculatorDataList(int level);

  /// Clears the cache
  void clearCache();
}

/// Implementation of calculator data source that uses existing repository
/// This acts as an adapter to the existing code
class CalculatorDataSourceImpl implements CalculatorDataSource {
  @override
  List<Calculator> getCalculatorDataList(int level) {
    // Import and use the existing repository
    // This is where we bridge to the old code without modifying it
    return _getFromExistingRepository(level);
  }

  @override
  void clearCache() {
    // Clear cache from existing repository
    _clearExistingCache();
  }

  /// Private method that calls the existing repository
  /// This keeps the existing code untouched
  List<Calculator> _getFromExistingRepository(int level) {
    // The actual implementation will import from:
    // import 'package:mathsgames/src/data/repository/calculator_repository.dart' as old;
    // return old.CalculatorRepository.getCalculatorDataList(level);
    
    // For now, we'll leave this as a bridge point
    throw UnimplementedError('Bridge to existing repository needed');
  }

  void _clearExistingCache() {
    // The actual implementation will import from:
    // import 'package:mathsgames/src/data/repository/calculator_repository.dart' as old;
    // old.CalculatorRepository.listHasCode.clear();
    
    throw UnimplementedError('Bridge to existing repository needed');
  }
}

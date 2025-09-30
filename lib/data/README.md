# Data Layer

This layer implements the repository interfaces defined in the Domain layer and handles all data operations.

## Structure

```
data/
├── datasources/       # Data source implementations
├── repositories_impl/ # Repository implementations
└── models/           # Data transfer objects (DTOs)
```

## Principles

1. **Implements Domain contracts**: Implements repository interfaces from Domain layer
2. **Data mapping**: Converts between data models and domain entities
3. **Data sources**: Abstracts data source details (API, database, cache, existing code)
4. **Bridge**: Acts as a bridge to existing code without modifying it

## What Goes Here?

### Data Sources (`datasources/`)
- Abstracts where data comes from
- Can be: API, database, cache, existing repositories
- Acts as adapter to existing code
- Example: `CalculatorDataSourceImpl` wraps existing `CalculatorRepository`

### Repository Implementations (`repositories_impl/`)
- Implements domain repository interfaces
- Uses data sources to get data
- Maps between models and entities
- Handles errors and exceptions
- Example: `CalculatorRepositoryImpl`

### Models (`models/`)
- Data transfer objects
- Can be different from domain entities
- Used for serialization/deserialization
- Example: Not needed if using existing models from `lib/src/data/models/`

## Rules

✅ **DO**:
- Implement all methods from repository interface
- Map data models to domain entities
- Handle exceptions gracefully
- Use dependency injection
- Bridge to existing code without modifying it

❌ **DON'T**:
- Put business logic here (belongs in domain)
- Import presentation layer
- Modify existing code in `lib/src/`
- Expose data models to domain layer

## Examples

### Data Source (Bridging to Existing Code)
```dart
import 'package:mathsgames/src/data/repository/calculator_repository.dart' as old;

class CalculatorDataSourceImpl implements CalculatorDataSource {
  @override
  List<Calculator> getCalculatorDataList(int level) {
    // Bridge to existing code without modifying it
    return old.CalculatorRepository.getCalculatorDataList(level);
  }

  @override
  void clearCache() {
    old.CalculatorRepository.listHasCode.clear();
  }
}
```

### Repository Implementation
```dart
class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorDataSource dataSource;

  CalculatorRepositoryImpl({required this.dataSource});

  @override
  Future<List<CalculatorEntity>> getCalculatorDataList(int level) async {
    try {
      // Get data from datasource
      final models = dataSource.getCalculatorDataList(level);
      
      // Map to entities
      return models.map((model) => CalculatorEntity(
        question: model.question,
        answer: model.answer,
      )).toList();
    } catch (e) {
      throw RepositoryException(message: 'Failed to get data: $e');
    }
  }

  @override
  void clearCache() {
    dataSource.clearCache();
  }
}
```

## Bridge Pattern

The data layer acts as a bridge between the new Clean Architecture and existing code:

```
New Architecture          Bridge              Existing Code
-----------------        --------             --------------
Domain Layer      →      Data Layer     →     lib/src/data/repository/
Use Cases         →      Repository Impl →    Old Repositories
Domain Entities   ←      Mapping        ←     Old Models
```

This allows:
- Using new architecture without modifying existing code
- Gradual migration
- Easy rollback if needed
- Both architectures working side by side

## Integration with Existing Code

The existing code in `lib/src/data/repository/` is **not modified**. Instead:

1. Data sources **wrap** existing repositories
2. Data layer **calls** existing code
3. Data layer **maps** results to domain entities
4. Existing functionality continues to work as before

Example integration:
```dart
// Existing code (unchanged):
// lib/src/data/repository/calculator_repository.dart
class CalculatorRepository {
  static getCalculatorDataList(int level) { /* ... */ }
}

// New bridge (in data layer):
class CalculatorDataSourceImpl {
  List<Calculator> getCalculatorDataList(int level) {
    // Call existing code
    return CalculatorRepository.getCalculatorDataList(level);
  }
}
```

## Testing

Test data layer with mocked data sources:

```dart
test('CalculatorRepositoryImpl maps data correctly', () async {
  when(mockDataSource.getCalculatorDataList(1))
    .thenReturn([Calculator(question: '2+2', answer: 4)]);
  
  final repository = CalculatorRepositoryImpl(dataSource: mockDataSource);
  final result = await repository.getCalculatorDataList(1);
  
  expect(result.length, 1);
  expect(result.first.question, '2+2');
  expect(result.first.answer, 4);
});
```

## Documentation

See [CLEAN_ARCHITECTURE.md](../../CLEAN_ARCHITECTURE.md) for complete architecture documentation.

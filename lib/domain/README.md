# Domain Layer

This is the **innermost layer** of the Clean Architecture. It contains the business logic and has **no dependencies** on other layers.

## Structure

```
domain/
├── entities/       # Business objects (pure Dart classes)
├── repositories/   # Repository interfaces (contracts)
└── usecases/      # Application-specific business rules
```

## Principles

1. **Pure Dart**: No Flutter or external framework dependencies
2. **Independence**: Does not depend on Data or Presentation layers
3. **Business Logic**: Contains core business rules
4. **Contracts**: Defines interfaces that other layers must implement

## What Goes Here?

### Entities (`entities/`)
- Pure business objects
- Simple data classes with business logic
- No framework dependencies
- Example: `CalculatorEntity`, `GameEntity`

### Repository Interfaces (`repositories/`)
- Define what data operations are available
- No implementation details
- Used by use cases
- Implemented by data layer
- Example: `CalculatorRepository`, `GameConfigRepository`

### Use Cases (`usecases/`)
- Application-specific business rules
- One use case per business operation
- Uses repository interfaces
- Example: `GetCalculatorProblemsUseCase`, `SaveGameScoreUseCase`

## Rules

✅ **DO**:
- Keep entities simple and focused
- Define clear repository interfaces
- Write one use case per business operation
- Use descriptive names
- Add business validation in use cases

❌ **DON'T**:
- Import Flutter packages
- Import data layer packages
- Import presentation layer packages
- Add UI logic
- Add database/API logic

## Examples

### Entity
```dart
class CalculatorEntity {
  final String question;
  final int answer;

  CalculatorEntity({
    required this.question,
    required this.answer,
  });
}
```

### Repository Interface
```dart
abstract class CalculatorRepository {
  Future<List<CalculatorEntity>> getCalculatorDataList(int level);
  void clearCache();
}
```

### Use Case
```dart
class GetCalculatorProblemsUseCase {
  final CalculatorRepository repository;

  GetCalculatorProblemsUseCase(this.repository);

  Future<List<CalculatorEntity>> execute(int level) async {
    if (level < 1) {
      throw ArgumentError('Level must be greater than 0');
    }
    return await repository.getCalculatorDataList(level);
  }
}
```

## Testing

Domain layer is the easiest to test because it has no dependencies:

```dart
test('GetCalculatorProblemsUseCase validates level', () {
  final useCase = GetCalculatorProblemsUseCase(mockRepository);
  expect(
    () => useCase.execute(-1),
    throwsA(isA<ArgumentError>()),
  );
});
```

## Documentation

See [CLEAN_ARCHITECTURE.md](../../CLEAN_ARCHITECTURE.md) for complete architecture documentation.

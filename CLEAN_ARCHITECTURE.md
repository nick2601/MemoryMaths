# Clean Architecture Implementation Guide

## Overview

This document describes the Clean Architecture implementation for the MemoryMaths Flutter application. The architecture has been implemented **without modifying any existing code**, ensuring backward compatibility and smooth migration.

## Architecture Layers

### 1. Domain Layer (`lib/domain/`)

The Domain layer is the innermost layer and contains the business logic. It has **no dependencies** on other layers.

#### Structure:
```
lib/domain/
├── entities/          # Business objects (pure Dart classes)
├── repositories/      # Repository interfaces (contracts)
└── usecases/         # Application-specific business rules
```

#### Key Principles:
- **Pure Dart**: No Flutter or external dependencies
- **Business Logic**: Contains core business rules
- **Independence**: Does not depend on Data or Presentation layers
- **Contracts**: Defines interfaces that other layers must implement

#### Example Files:
- `entities/calculator_entity.dart` - Domain model for calculator problems
- `entities/game_entity.dart` - Common game entities
- `repositories/calculator_repository.dart` - Interface defining calculator operations
- `usecases/get_calculator_problems_usecase.dart` - Business logic for getting problems

### 2. Data Layer (`lib/data/`)

The Data layer implements the repository interfaces defined in the Domain layer.

#### Structure:
```
lib/data/
├── datasources/       # Data source implementations (API, local storage, etc.)
├── repositories_impl/ # Repository implementations
└── models/           # Data transfer objects (DTOs)
```

#### Key Principles:
- **Implements Domain contracts**: Implements repository interfaces from Domain
- **Data mapping**: Converts between data models and domain entities
- **Data sources**: Abstracts data source details (API, database, cache)
- **Bridge to existing code**: Wraps existing repository implementations

#### Example Files:
- `datasources/calculator_datasource.dart` - Data source for calculator data
- `datasources/game_config_datasource.dart` - Data source for game configuration
- `repositories_impl/calculator_repository_impl.dart` - Implementation of calculator repository

### 3. Presentation Layer (`lib/presentation/`)

The Presentation layer contains UI-related code and state management.

#### Structure:
```
lib/presentation/
├── viewmodels/       # ViewModels for state management
├── screens/          # Screen widgets
└── widgets/          # Reusable UI components
```

#### Key Principles:
- **Depends on Domain**: Uses domain entities and use cases
- **State Management**: ViewModels manage UI state using ChangeNotifier
- **Separation of Concerns**: UI logic separated from UI rendering
- **Testable**: ViewModels can be tested independently of UI

#### Example Files:
- `viewmodels/calculator_viewmodel.dart` - State management for calculator game
- `viewmodels/game_config_viewmodel.dart` - State management for game configuration
- `viewmodels/game_score_viewmodel.dart` - State management for game scores

### 4. Core Layer (`lib/core/`)

The Core layer contains shared utilities, constants, and configurations.

#### Structure:
```
lib/core/
├── constants/        # App-wide constants
├── themes/          # Theme configurations
├── utils/           # Helper functions
├── error/           # Error handling (exceptions, failures)
└── di/              # Dependency injection setup
```

#### Key Principles:
- **Shared code**: Code used across multiple layers
- **No business logic**: Only utilities and configurations
- **Error handling**: Centralized exception and failure handling

#### Example Files:
- `error/exceptions.dart` - Exception classes
- `error/failures.dart` - Failure classes for error handling
- `di/injection_container.dart` - Dependency injection setup

## Dependency Rule

The fundamental rule of Clean Architecture is the **Dependency Rule**:

```
Presentation → Domain ← Data
     ↓           ↑
   Core ←────────┘
```

- **Domain** is independent and has no dependencies
- **Data** depends on Domain (implements its interfaces)
- **Presentation** depends on Domain (uses its entities and use cases)
- **Core** is used by all layers but doesn't depend on them

## Data Flow

### Reading Data (Inward Flow):
```
UI Widget → ViewModel → Use Case → Repository Interface → Repository Implementation → Data Source → Existing Code
```

### Writing Data (Outward Flow):
```
Existing Code → Data Source → Repository Implementation → Use Case → ViewModel → UI Widget
```

## Integration with Existing Code

The new architecture **does not modify existing code**. Instead, it creates adapters and wrappers:

### Bridge Pattern:
1. **Data Sources** act as adapters to existing repositories
2. **Repository Implementations** wrap data sources
3. **ViewModels** provide a clean interface to UI

### Example Integration:
```dart
// Existing code (untouched):
// lib/src/data/repository/calculator_repository.dart

// New adapter:
// lib/data/datasources/calculator_datasource.dart
class CalculatorDataSourceImpl {
  List<Calculator> getCalculatorDataList(int level) {
    // Calls existing repository
    return old.CalculatorRepository.getCalculatorDataList(level);
  }
}
```

## Dependency Injection

Dependencies are managed using GetIt service locator in `lib/core/di/injection_container.dart`.

### Setup:
```dart
// In main.dart (future integration):
await initDependencies(sharedPreferences);

// Use in widgets:
final viewModel = sl<CalculatorViewModel>();
```

### Lifecycle:
- **Singleton**: Repositories, Data Sources (single instance)
- **Factory**: ViewModels (new instance each time)

## Usage Examples

### Using Calculator ViewModel:

```dart
import 'package:provider/provider.dart';
import 'package:mathsgames/presentation/viewmodels/calculator_viewmodel.dart';
import 'package:mathsgames/core/di/injection_container.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<CalculatorViewModel>()..loadProblems(1),
      child: Consumer<CalculatorViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return CircularProgressIndicator();
          }
          
          final problem = viewModel.currentProblem;
          if (problem == null) return Text('No problem');
          
          return Column(
            children: [
              Text(problem.question),
              TextField(
                onChanged: (value) => viewModel.updateAnswer(value),
              ),
              ElevatedButton(
                onPressed: () {
                  if (viewModel.checkAnswer()) {
                    viewModel.nextProblem();
                  }
                },
                child: Text('Check Answer'),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

### Using Game Config ViewModel:

```dart
import 'package:provider/provider.dart';
import 'package:mathsgames/presentation/viewmodels/game_config_viewmodel.dart';
import 'package:mathsgames/core/di/injection_container.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<GameConfigViewModel>()..loadConfig(),
      child: Consumer<GameConfigViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SwitchListTile(
                title: Text('Sound'),
                value: viewModel.isSoundEnabled,
                onChanged: (_) => viewModel.toggleSound(),
              ),
              SwitchListTile(
                title: Text('Vibration'),
                value: viewModel.isVibrationEnabled,
                onChanged: (_) => viewModel.toggleVibration(),
              ),
              SwitchListTile(
                title: Text('Dark Mode'),
                value: viewModel.isDarkModeEnabled,
                onChanged: (_) => viewModel.toggleDarkMode(),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

## Benefits

### 1. **Testability**
- Domain logic can be tested without UI or data layer
- Use cases can be tested independently
- ViewModels can be unit tested

### 2. **Maintainability**
- Clear separation of concerns
- Easy to locate and modify code
- Changes in one layer don't affect others

### 3. **Scalability**
- Easy to add new features
- Can replace data sources without changing business logic
- Can change UI without affecting business rules

### 4. **Flexibility**
- Can switch state management solutions
- Can change data sources (API, database, cache)
- Can support multiple platforms with shared business logic

### 5. **Team Collaboration**
- Different teams can work on different layers
- Clear interfaces and contracts
- Reduced merge conflicts

## Migration Path

The existing code continues to work as before. To migrate gradually:

1. **Phase 1**: Use new ViewModels in new screens
2. **Phase 2**: Gradually refactor existing screens to use ViewModels
3. **Phase 3**: Add more use cases as needed
4. **Phase 4**: Optimize data sources and repositories

## Testing

### Unit Tests:
```dart
// Test domain entities
test('CalculatorEntity equality', () {
  final entity1 = CalculatorEntity(question: '2 + 2', answer: 4);
  final entity2 = CalculatorEntity(question: '2 + 2', answer: 4);
  expect(entity1, equals(entity2));
});

// Test use cases
test('GetCalculatorProblemsUseCase with invalid level', () {
  final useCase = GetCalculatorProblemsUseCase(mockRepository);
  expect(
    () => useCase.execute(-1),
    throwsA(isA<ArgumentError>()),
  );
});

// Test ViewModels
test('CalculatorViewModel loads problems', () async {
  final viewModel = CalculatorViewModel(
    getCalculatorProblemsUseCase: mockGetProblemsUseCase,
    clearCalculatorCacheUseCase: mockClearCacheUseCase,
  );
  
  await viewModel.loadProblems(1);
  
  expect(viewModel.problems.length, greaterThan(0));
  expect(viewModel.isLoading, false);
});
```

## Best Practices

1. **Keep entities simple**: Domain entities should contain only business data
2. **Single Responsibility**: Each use case should do one thing
3. **Immutability**: Prefer immutable entities
4. **Error Handling**: Use Result/Either pattern for operations that can fail
5. **Dependency Injection**: Use DI for all dependencies
6. **Testing**: Write tests for each layer independently

## Future Enhancements

1. **Add Result type**: Implement Either<Failure, Success> for better error handling
2. **Add more entities**: Create domain entities for all game types
3. **Implement caching**: Add cache layer in data sources
4. **Add analytics**: Track usage through domain events
5. **API integration**: Add remote data sources when needed

## Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Dependency Injection in Flutter](https://medium.com/flutter-community/dependency-injection-in-flutter-using-get-it-b8f2f38f5f7e)

## Support

For questions or issues with the Clean Architecture implementation, please refer to this document or create an issue in the repository.

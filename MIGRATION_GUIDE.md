# Migration Guide: Integrating Clean Architecture

This guide explains how to integrate the new Clean Architecture with the existing codebase without breaking any functionality.

## Current vs New Architecture

### Current Structure (Preserved):
```
lib/src/
├── core/          # Constants, themes, routes
├── data/          # Models and repositories
├── ui/            # UI screens and providers
└── utility/       # Helper functions
```

### New Structure (Added):
```
lib/
├── domain/        # Business logic (entities, repositories, use cases)
├── data/          # Data layer (datasources, repository implementations)
├── presentation/  # Presentation layer (viewmodels)
└── core/          # Core utilities (DI, error handling)
```

## Integration Steps

### Step 1: Initialize Dependencies

Add dependency initialization to `main.dart`:

```dart
import 'package:mathsgames/core/di/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Initialize existing dependencies
  setupServiceLocator(sharedPreferences);
  
  // Initialize Clean Architecture dependencies
  await di.initDependencies(sharedPreferences);
  
  // ... rest of main
}
```

### Step 2: Bridge Existing Repositories

Complete the bridge in `calculator_datasource.dart`:

```dart
import 'package:mathsgames/src/data/repository/calculator_repository.dart' as old;

class CalculatorDataSourceImpl implements CalculatorDataSource {
  @override
  List<Calculator> getCalculatorDataList(int level) {
    return old.CalculatorRepository.getCalculatorDataList(level);
  }

  @override
  void clearCache() {
    old.CalculatorRepository.listHasCode.clear();
  }
}
```

### Step 3: Using ViewModels in Existing Screens

You can use new ViewModels alongside existing providers:

#### Option A: Replace Provider Gradually

```dart
// Old way (keep working):
import 'package:mathsgames/src/ui/calculator/calculator_provider.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(
        vsync: this,
        level: 1,
      ),
      child: CalculatorContent(),
    );
  }
}

// New way (introduce gradually):
import 'package:mathsgames/presentation/viewmodels/calculator_viewmodel.dart';
import 'package:mathsgames/core/di/injection_container.dart';

class NewCalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<CalculatorViewModel>()..loadProblems(1),
      child: NewCalculatorContent(),
    );
  }
}
```

#### Option B: Use Both (Parallel Run)

```dart
class HybridCalculatorView extends StatelessWidget {
  final bool useNewArchitecture;
  
  HybridCalculatorView({this.useNewArchitecture = false});
  
  @override
  Widget build(BuildContext context) {
    if (useNewArchitecture) {
      return _buildWithViewModel();
    } else {
      return _buildWithProvider();
    }
  }
  
  Widget _buildWithViewModel() {
    return ChangeNotifierProvider(
      create: (_) => sl<CalculatorViewModel>()..loadProblems(1),
      child: Consumer<CalculatorViewModel>(
        builder: (context, vm, _) => CalculatorContent(
          problems: vm.problems,
          onAnswer: (answer) => vm.updateAnswer(answer),
        ),
      ),
    );
  }
  
  Widget _buildWithProvider() {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(/* ... */),
      child: CalculatorContent(),
    );
  }
}
```

### Step 4: Feature Toggle

Add a feature flag to control architecture usage:

```dart
// lib/core/constants/feature_flags.dart
class FeatureFlags {
  static const bool useCleanArchitecture = false; // Toggle this
  
  static const bool useNewCalculator = false;
  static const bool useNewSettings = false;
  static const bool useNewScoring = false;
}
```

Usage:

```dart
import 'package:mathsgames/core/constants/feature_flags.dart';

class AppRouter {
  static Widget getCalculatorScreen() {
    if (FeatureFlags.useNewCalculator) {
      return NewCalculatorView();
    } else {
      return CalculatorView(); // Existing
    }
  }
}
```

## Migration Strategies

### Strategy 1: Big Bang (Not Recommended)
Replace all screens at once. High risk, not recommended.

### Strategy 2: Strangler Fig Pattern (Recommended)
Gradually replace old code with new architecture:

1. **Week 1-2**: Add new architecture alongside existing
2. **Week 3-4**: Migrate one feature (e.g., Settings)
3. **Week 5-6**: Migrate another feature (e.g., Calculator)
4. **Week 7-8**: Continue migration feature by feature
5. **Week 9+**: Remove old code once all features migrated

### Strategy 3: Hybrid Approach
Keep both architectures and use each where appropriate:
- New features: Use Clean Architecture
- Existing features: Keep as is, refactor as needed
- Critical features: Migrate with thorough testing

## Testing During Migration

### 1. Parallel Testing
Run both implementations and compare results:

```dart
void testBothImplementations() {
  // Old implementation
  final oldResult = CalculatorRepository.getCalculatorDataList(1);
  
  // New implementation
  final newDataSource = CalculatorDataSourceImpl();
  final newRepository = CalculatorRepositoryImpl(dataSource: newDataSource);
  final newResult = await newRepository.getCalculatorDataList(1);
  
  // Compare
  expect(newResult.length, oldResult.length);
}
```

### 2. A/B Testing
Use feature flags to test with real users:

```dart
class ABTestConfig {
  static bool shouldUseNewArchitecture() {
    // 50% of users get new architecture
    return Random().nextBool();
  }
}
```

### 3. Canary Release
Release to small percentage of users first:

```dart
class CanaryRelease {
  static bool isCanaryUser(String userId) {
    // First 10% of users by hash
    return userId.hashCode % 10 == 0;
  }
}
```

## Common Patterns

### Pattern 1: Adapter for Existing Provider

```dart
/// Adapter to use existing provider with new architecture
class CalculatorProviderAdapter extends CalculatorViewModel {
  final CalculatorProvider _oldProvider;
  
  CalculatorProviderAdapter(this._oldProvider) : super(
    getCalculatorProblemsUseCase: sl(),
    clearCalculatorCacheUseCase: sl(),
  );
  
  @override
  Future<void> loadProblems(int level) async {
    // Delegate to old provider but also update new architecture
    await super.loadProblems(level);
    _oldProvider.startGame(level: level);
  }
}
```

### Pattern 2: Facade for Backward Compatibility

```dart
/// Facade to make new architecture look like old code
class CalculatorFacade {
  static Future<List<Calculator>> getCalculatorDataList(int level) async {
    final viewModel = sl<CalculatorViewModel>();
    await viewModel.loadProblems(level);
    
    // Convert entities back to models
    return viewModel.problems.map((entity) => Calculator(
      question: entity.question,
      answer: entity.answer,
    )).toList();
  }
}
```

### Pattern 3: Bridge Pattern

```dart
/// Bridge between old and new implementations
abstract class GameDataProvider {
  Future<List<dynamic>> getData(int level);
}

class OldGameDataProvider implements GameDataProvider {
  @override
  Future<List<dynamic>> getData(int level) async {
    return CalculatorRepository.getCalculatorDataList(level);
  }
}

class NewGameDataProvider implements GameDataProvider {
  final CalculatorViewModel viewModel;
  
  NewGameDataProvider(this.viewModel);
  
  @override
  Future<List<dynamic>> getData(int level) async {
    await viewModel.loadProblems(level);
    return viewModel.problems;
  }
}
```

## Rollback Plan

If issues arise, rollback is simple because old code is untouched:

1. **Set feature flags to false**:
   ```dart
   class FeatureFlags {
     static const bool useCleanArchitecture = false;
   }
   ```

2. **Remove new providers**:
   ```dart
   // Comment out or remove
   // await di.initDependencies(sharedPreferences);
   ```

3. **Revert routing**:
   ```dart
   // Use old screens
   return CalculatorView(); // instead of NewCalculatorView()
   ```

## Monitoring

Add monitoring to track migration progress:

```dart
class MigrationMetrics {
  static void logArchitectureUsage(String feature, bool isNewArch) {
    // Log to analytics
    print('Feature: $feature, New Architecture: $isNewArch');
  }
}

// Usage
MigrationMetrics.logArchitectureUsage('calculator', FeatureFlags.useNewCalculator);
```

## Troubleshooting

### Issue 1: Dependency Injection Conflicts

**Problem**: GetIt throws "Object already registered"

**Solution**:
```dart
// Check if already registered
if (!GetIt.I.isRegistered<CalculatorViewModel>()) {
  sl.registerFactory(() => CalculatorViewModel(/*...*/));
}
```

### Issue 2: State Not Syncing

**Problem**: Old and new architecture have different state

**Solution**: Use event bus or shared state:
```dart
class StateSync {
  static final StreamController<GameState> _controller = 
    StreamController.broadcast();
  
  static Stream<GameState> get stream => _controller.stream;
  
  static void updateState(GameState state) {
    _controller.add(state);
  }
}
```

### Issue 3: Performance Issues

**Problem**: Both architectures running causes slowdown

**Solution**: Use lazy loading and cleanup:
```dart
@override
void dispose() {
  // Clean up new architecture resources
  if (FeatureFlags.useCleanArchitecture) {
    viewModel.dispose();
  }
  // Clean up old resources
  oldProvider.dispose();
  super.dispose();
}
```

## Best Practices

1. **Keep both working**: Never break existing functionality
2. **Migrate incrementally**: One feature at a time
3. **Test thoroughly**: Test both old and new implementations
4. **Document changes**: Update docs as you migrate
5. **Get feedback**: Collect user feedback during migration
6. **Monitor metrics**: Track performance and errors
7. **Plan rollback**: Always have a way to revert

## Next Steps

1. Review this guide with the team
2. Choose migration strategy
3. Set up feature flags
4. Complete data source bridges
5. Migrate first feature (recommended: Settings)
6. Test thoroughly
7. Roll out gradually
8. Monitor and iterate

## Resources

- Clean Architecture Guide: `CLEAN_ARCHITECTURE.md`
- Example implementations: `lib/presentation/viewmodels/`
- Dependency injection: `lib/core/di/injection_container.dart`

## Support

For help with migration, refer to this guide or contact the development team.

# Quick Start Guide: Clean Architecture

This guide helps you get started with the new Clean Architecture implementation in MemoryMaths.

## Table of Contents
1. [What Changed?](#what-changed)
2. [Quick Start](#quick-start)
3. [Using the New Architecture](#using-the-new-architecture)
4. [Example: Building a New Feature](#example-building-a-new-feature)
5. [FAQ](#faq)

## What Changed?

### ✅ Added (NEW)
- **Domain Layer**: `lib/domain/` - Business logic (entities, repositories, use cases)
- **Data Layer**: `lib/data/` - Data implementations (datasources, repository implementations)
- **Presentation Layer**: `lib/presentation/` - ViewModels for state management
- **Core Layer**: `lib/core/` - Shared utilities (DI, error handling)
- **Documentation**: Complete guides and examples

### ✅ Unchanged (EXISTING)
- **Everything in `lib/src/`**: All existing code remains untouched
- **All existing screens**: Continue to work as before
- **All existing providers**: Continue to function normally
- **All existing models**: No modifications

## Quick Start

### 1. Understanding the Structure

```
lib/
├── domain/              # ⭐ NEW - Business logic
│   ├── entities/        # Business objects
│   ├── repositories/    # Contracts (interfaces)
│   └── usecases/       # Business rules
│
├── data/               # ⭐ NEW - Data implementations
│   ├── datasources/     # Data source adapters
│   └── repositories_impl/ # Repository implementations
│
├── presentation/        # ⭐ NEW - UI state management
│   ├── viewmodels/      # State management
│   ├── screens/         # Screen implementations
│   └── widgets/         # Reusable components
│
├── core/               # ⭐ NEW - Shared utilities
│   ├── di/             # Dependency injection
│   └── error/          # Error handling
│
└── src/                # ✓ EXISTING - Unchanged
    ├── core/           # Original constants, themes
    ├── data/           # Original models, repositories
    ├── ui/             # Original screens, providers
    └── utility/        # Original utilities
```

### 2. Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌──────────────┐    ┌──────────────┐    ┌───────────┐ │
│  │   Screens    │ ←→ │  ViewModels  │ ←→ │  Widgets  │ │
│  └──────────────┘    └──────────────┘    └───────────┘ │
└────────────────────────────┬────────────────────────────┘
                             │ Uses
                             ↓
┌─────────────────────────────────────────────────────────┐
│                      Domain Layer                        │
│  ┌──────────────┐    ┌──────────────┐    ┌───────────┐ │
│  │  Entities    │    │  Use Cases   │    │Repository │ │
│  │              │ ←→ │              │ ←→ │Interfaces │ │
│  └──────────────┘    └──────────────┘    └───────────┘ │
└────────────────────────────┬────────────────────────────┘
                             │ Implements
                             ↓
┌─────────────────────────────────────────────────────────┐
│                       Data Layer                         │
│  ┌──────────────┐    ┌──────────────┐    ┌───────────┐ │
│  │ Data Sources │ ←→ │ Repository   │ ←→ │  Models   │ │
│  │  (Adapters)  │    │     Impl     │    │           │ │
│  └──────────────┘    └──────────────┘    └───────────┘ │
└────────────────────────────┬────────────────────────────┘
                             │ Bridges to
                             ↓
┌─────────────────────────────────────────────────────────┐
│                    Existing Code (lib/src/)              │
│       Old Repositories, Providers, Models, UI            │
│                  (UNCHANGED & WORKING)                   │
└─────────────────────────────────────────────────────────┘
```

### 3. Data Flow

#### Getting Data (Read Operation):
```
UI Widget
   ↓ user action
ViewModel
   ↓ calls
Use Case
   ↓ calls
Repository Interface
   ↓ implements
Repository Implementation
   ↓ uses
Data Source
   ↓ bridges to
Existing Repository (lib/src/)
   ↓ returns data
[Flow back up through layers]
```

#### Saving Data (Write Operation):
```
UI Widget
   ↓ user input
ViewModel
   ↓ calls
Use Case
   ↓ validates & calls
Repository Implementation
   ↓ maps & saves
Data Source
   ↓ bridges to
Existing Storage (SharedPreferences, etc.)
```

## Using the New Architecture

### Option 1: For New Features (Recommended)

```dart
// 1. Create your screen with ViewModel
class MyNewFeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<MyFeatureViewModel>()..loadData(),
      child: Scaffold(
        appBar: AppBar(title: Text('My Feature')),
        body: Consumer<MyFeatureViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return CircularProgressIndicator();
            }
            return YourUI(data: viewModel.data);
          },
        ),
      ),
    );
  }
}
```

### Option 2: Alongside Existing Code

```dart
// Keep existing providers working
class SettingsView extends StatelessWidget {
  final bool useNewArchitecture;
  
  SettingsView({this.useNewArchitecture = false});
  
  @override
  Widget build(BuildContext context) {
    if (useNewArchitecture) {
      // Use new ViewModel
      return ChangeNotifierProvider(
        create: (_) => sl<GameConfigViewModel>()..loadConfig(),
        child: NewSettingsContent(),
      );
    } else {
      // Use existing provider
      return ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
        child: OldSettingsContent(),
      );
    }
  }
}
```

## Example: Building a New Feature

Let's build a simple "Daily Challenge" feature using Clean Architecture:

### Step 1: Create Domain Entity

```dart
// lib/domain/entities/daily_challenge_entity.dart
class DailyChallengeEntity {
  final String id;
  final String title;
  final String description;
  final int difficulty;
  final DateTime date;

  DailyChallengeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.date,
  });
}
```

### Step 2: Create Repository Interface

```dart
// lib/domain/repositories/daily_challenge_repository.dart
abstract class DailyChallengeRepository {
  Future<DailyChallengeEntity> getTodaysChallenge();
  Future<List<DailyChallengeEntity>> getPastChallenges();
  Future<void> markChallengeCompleted(String challengeId);
}
```

### Step 3: Create Use Case

```dart
// lib/domain/usecases/get_daily_challenge_usecase.dart
class GetDailyChallengeUseCase {
  final DailyChallengeRepository repository;

  GetDailyChallengeUseCase(this.repository);

  Future<DailyChallengeEntity> execute() async {
    final challenge = await repository.getTodaysChallenge();
    
    // Business validation
    if (challenge.date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      throw Exception('Challenge is expired');
    }
    
    return challenge;
  }
}
```

### Step 4: Create Data Source (Bridge to existing code)

```dart
// lib/data/datasources/daily_challenge_datasource.dart
class DailyChallengeDataSourceImpl {
  final SharedPreferences prefs;
  
  DailyChallengeDataSourceImpl(this.prefs);
  
  Future<Map<String, dynamic>> getTodaysChallenge() async {
    // Could call existing code or implement new logic
    final today = DateTime.now().toIso8601String().split('T')[0];
    return {
      'id': today,
      'title': 'Daily Math Challenge',
      'description': 'Solve 10 problems in 2 minutes',
      'difficulty': 3,
      'date': today,
    };
  }
}
```

### Step 5: Implement Repository

```dart
// lib/data/repositories_impl/daily_challenge_repository_impl.dart
class DailyChallengeRepositoryImpl implements DailyChallengeRepository {
  final DailyChallengeDataSourceImpl dataSource;

  DailyChallengeRepositoryImpl(this.dataSource);

  @override
  Future<DailyChallengeEntity> getTodaysChallenge() async {
    final data = await dataSource.getTodaysChallenge();
    
    return DailyChallengeEntity(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      difficulty: data['difficulty'],
      date: DateTime.parse(data['date']),
    );
  }

  // Implement other methods...
}
```

### Step 6: Create ViewModel

```dart
// lib/presentation/viewmodels/daily_challenge_viewmodel.dart
class DailyChallengeViewModel extends ChangeNotifier {
  final GetDailyChallengeUseCase getDailyChallengeUseCase;

  DailyChallengeViewModel({required this.getDailyChallengeUseCase});

  DailyChallengeEntity? _challenge;
  bool _isLoading = false;
  String? _error;

  DailyChallengeEntity? get challenge => _challenge;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadChallenge() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _challenge = await getDailyChallengeUseCase.execute();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### Step 7: Register Dependencies

```dart
// Add to lib/core/di/injection_container.dart

// Data source
sl.registerLazySingleton(
  () => DailyChallengeDataSourceImpl(sl()),
);

// Repository
sl.registerLazySingleton<DailyChallengeRepository>(
  () => DailyChallengeRepositoryImpl(sl()),
);

// Use case
sl.registerLazySingleton(
  () => GetDailyChallengeUseCase(sl()),
);

// ViewModel
sl.registerFactory(
  () => DailyChallengeViewModel(
    getDailyChallengeUseCase: sl(),
  ),
);
```

### Step 8: Create UI Screen

```dart
// lib/presentation/screens/daily_challenge_screen.dart
class DailyChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<DailyChallengeViewModel>()..loadChallenge(),
      child: Scaffold(
        appBar: AppBar(title: Text('Daily Challenge')),
        body: Consumer<DailyChallengeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            final challenge = viewModel.challenge;
            if (challenge == null) {
              return Center(child: Text('No challenge available'));
            }

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(challenge.description),
                  SizedBox(height: 8),
                  Text('Difficulty: ${challenge.difficulty}/5'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Start challenge
                    },
                    child: Text('Start Challenge'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### Step 9: Use in Your App

```dart
// Navigate to the screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DailyChallengeScreen(),
  ),
);
```

## FAQ

### Q: Do I need to modify existing code?
**A:** No! All existing code in `lib/src/` remains completely untouched. The new architecture works alongside it.

### Q: Will this break my app?
**A:** No. The existing functionality continues to work exactly as before. The new architecture is additive only.

### Q: How do I start using it?
**A:** You can:
1. Use it for new features only
2. Gradually migrate existing features
3. Use both architectures side by side

### Q: What if I want to go back?
**A:** Simply don't use the new architecture. Your existing code is unchanged, so rollback is instant.

### Q: Do I need to learn everything at once?
**A:** No. Start with the provided examples and gradually understand each layer as you use it.

### Q: Where do I put my business logic?
**A:** In use cases (`lib/domain/usecases/`). Keep it independent of UI and data sources.

### Q: How do I test the new architecture?
**A:** Each layer can be tested independently:
- Domain: Test entities and use cases with mock repositories
- Data: Test repository implementations with mock data sources
- Presentation: Test ViewModels with mock use cases

### Q: Can I use this with existing providers?
**A:** Yes! You can use ViewModels alongside existing providers. They don't conflict.

### Q: What about GetIt conflicts?
**A:** The new DI setup uses the same GetIt instance but registers different types, so there are no conflicts.

### Q: How do I bridge to existing repositories?
**A:** Data sources act as adapters. See `lib/data/datasources/calculator_datasource.dart` for an example.

## Next Steps

1. ✅ Read [CLEAN_ARCHITECTURE.md](./CLEAN_ARCHITECTURE.md) for detailed architecture info
2. ✅ Read [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) for migration strategies
3. ✅ Check example implementation in `lib/presentation/screens/example_calculator_screen.dart`
4. ✅ Try building a simple feature using the example above
5. ✅ Gradually adopt for new features

## Resources

- **Architecture Guide**: `CLEAN_ARCHITECTURE.md`
- **Migration Guide**: `MIGRATION_GUIDE.md`
- **Domain Layer**: `lib/domain/README.md`
- **Data Layer**: `lib/data/README.md`
- **Presentation Layer**: `lib/presentation/README.md`
- **Example Screen**: `lib/presentation/screens/example_calculator_screen.dart`

## Support

Questions? Issues? Check the documentation files or create an issue in the repository.

---

**Remember**: The new architecture is here to help, not complicate. Use it at your own pace and comfort level. Your existing code continues to work perfectly! 🚀

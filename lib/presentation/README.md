# Presentation Layer

This layer contains UI-related code and state management using ViewModels.

## Structure

```
presentation/
├── viewmodels/   # ViewModels for state management
├── screens/      # Screen widgets (UI)
└── widgets/      # Reusable UI components
```

## Principles

1. **Depends on Domain**: Uses domain entities and use cases
2. **State Management**: ViewModels manage UI state
3. **Separation of Concerns**: UI logic separated from UI rendering
4. **Testable**: ViewModels can be tested independently of UI

## What Goes Here?

### ViewModels (`viewmodels/`)
- Manage UI state using `ChangeNotifier`
- Call use cases from domain layer
- Transform domain entities for UI display
- Handle user interactions
- Example: `CalculatorViewModel`, `GameConfigViewModel`

### Screens (`screens/`)
- Full-page UI widgets
- Use `Consumer` or `Provider.of` to access ViewModels
- Render UI based on ViewModel state
- Example: `ExampleCalculatorScreen`

### Widgets (`widgets/`)
- Reusable UI components
- Can be stateless or stateful
- Should be presentation-agnostic when possible
- Example: Custom buttons, cards, etc.

## Rules

✅ **DO**:
- Use ViewModels for state management
- Call use cases through ViewModels
- Keep widgets simple and focused
- Use `ChangeNotifier` for reactive state
- Handle loading, error, and success states

❌ **DON'T**:
- Put business logic in ViewModels (belongs in use cases)
- Call repositories directly from widgets
- Access data sources from ViewModels
- Mix UI rendering with business logic

## ViewModel Pattern

ViewModels follow this structure:

```dart
class ExampleViewModel extends ChangeNotifier {
  final UseCaseX useCaseX;
  final UseCaseY useCaseY;

  // Constructor with dependency injection
  ExampleViewModel({
    required this.useCaseX,
    required this.useCaseY,
  });

  // Private state
  bool _isLoading = false;
  String? _error;
  DataType? _data;

  // Public getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  DataType? get data => _data;

  // Public methods that call use cases
  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await useCaseX.execute();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void performAction() {
    useCaseY.execute();
    notifyListeners();
  }
}
```

## Using ViewModels in Widgets

### Setup with Provider:
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Get from dependency injection
      create: (_) => sl<MyViewModel>()..loadData(),
      child: MyScreenContent(),
    );
  }
}
```

### Consume in Widget:
```dart
class MyScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return CircularProgressIndicator();
        }

        if (viewModel.error != null) {
          return Text('Error: ${viewModel.error}');
        }

        return Text('Data: ${viewModel.data}');
      },
    );
  }
}
```

### Call Methods:
```dart
ElevatedButton(
  onPressed: () {
    context.read<MyViewModel>().performAction();
  },
  child: Text('Action'),
)
```

## State Management

ViewModels manage three types of state:

1. **Loading State**: `_isLoading`
2. **Error State**: `_error`
3. **Data State**: `_data`

Always handle all three in your UI:

```dart
if (viewModel.isLoading) {
  return LoadingWidget();
}

if (viewModel.error != null) {
  return ErrorWidget(error: viewModel.error);
}

return DataWidget(data: viewModel.data);
```

## Integration with Existing Code

ViewModels work **alongside** existing providers:

```dart
// Existing provider (unchanged):
class CalculatorProvider extends GameProvider<Calculator> {
  // ... existing code ...
}

// New ViewModel (added):
class CalculatorViewModel extends ChangeNotifier {
  // ... new code ...
}

// Use either based on feature flag:
Widget buildScreen() {
  if (FeatureFlags.useNewArchitecture) {
    return ChangeNotifierProvider(
      create: (_) => sl<CalculatorViewModel>(),
      child: NewCalculatorScreen(),
    );
  } else {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: OldCalculatorScreen(),
    );
  }
}
```

## Examples

See `screens/example_calculator_screen.dart` for a complete example of:
- Setting up ViewModel with Provider
- Handling loading/error/success states
- Calling ViewModel methods from UI
- Navigation and dialogs

## Testing

ViewModels are easy to test:

```dart
test('ViewModel loads data successfully', () async {
  // Arrange
  when(mockUseCase.execute()).thenAnswer((_) async => testData);
  final viewModel = MyViewModel(useCase: mockUseCase);

  // Act
  await viewModel.loadData();

  // Assert
  expect(viewModel.isLoading, false);
  expect(viewModel.error, null);
  expect(viewModel.data, testData);
});

test('ViewModel handles errors', () async {
  // Arrange
  when(mockUseCase.execute()).thenThrow(Exception('Error'));
  final viewModel = MyViewModel(useCase: mockUseCase);

  // Act
  await viewModel.loadData();

  // Assert
  expect(viewModel.isLoading, false);
  expect(viewModel.error, isNotNull);
  expect(viewModel.data, null);
});
```

## Documentation

See [CLEAN_ARCHITECTURE.md](../../CLEAN_ARCHITECTURE.md) for complete architecture documentation.

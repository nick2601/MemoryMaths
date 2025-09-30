import 'package:flutter/foundation.dart';
import 'package:mathsgames/domain/entities/calculator_entity.dart';
import 'package:mathsgames/domain/usecases/get_calculator_problems_usecase.dart';

/// ViewModel for Calculator game
/// Clean Architecture: Presentation Layer - ViewModels handle presentation logic
/// This separates UI logic from the UI widgets
class CalculatorViewModel extends ChangeNotifier {
  final GetCalculatorProblemsUseCase getCalculatorProblemsUseCase;
  final ClearCalculatorCacheUseCase clearCalculatorCacheUseCase;

  CalculatorViewModel({
    required this.getCalculatorProblemsUseCase,
    required this.clearCalculatorCacheUseCase,
  });

  List<CalculatorEntity> _problems = [];
  bool _isLoading = false;
  String? _error;
  int _currentLevel = 1;
  int _currentIndex = 0;
  String _userAnswer = '';

  // Getters
  List<CalculatorEntity> get problems => _problems;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentLevel => _currentLevel;
  int get currentIndex => _currentIndex;
  String get userAnswer => _userAnswer;
  CalculatorEntity? get currentProblem => 
    _problems.isNotEmpty && _currentIndex < _problems.length 
      ? _problems[_currentIndex] 
      : null;

  /// Loads problems for a specific level
  Future<void> loadProblems(int level) async {
    _isLoading = true;
    _error = null;
    _currentLevel = level;
    notifyListeners();

    try {
      _problems = await getCalculatorProblemsUseCase.execute(level);
      _currentIndex = 0;
      _userAnswer = '';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Moves to next problem
  void nextProblem() {
    if (_currentIndex < _problems.length - 1) {
      _currentIndex++;
      _userAnswer = '';
      notifyListeners();
    }
  }

  /// Updates user answer
  void updateAnswer(String answer) {
    _userAnswer = answer;
    notifyListeners();
  }

  /// Checks if the answer is correct
  bool checkAnswer() {
    if (currentProblem == null) return false;
    return int.tryParse(_userAnswer) == currentProblem!.answer;
  }

  /// Clears the cache
  void clearCache() {
    clearCalculatorCacheUseCase.execute();
  }

  /// Resets the game
  void reset() {
    _problems = [];
    _currentIndex = 0;
    _userAnswer = '';
    _error = null;
    notifyListeners();
  }
}

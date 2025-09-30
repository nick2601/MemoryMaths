import 'package:flutter/foundation.dart';
import 'package:mathsgames/domain/entities/game_entity.dart';
import 'package:mathsgames/domain/usecases/game_score_usecases.dart';

/// ViewModel for game score and progress
/// Clean Architecture: Presentation Layer - ViewModels
class GameScoreViewModel extends ChangeNotifier {
  final SaveGameScoreUseCase saveGameScoreUseCase;
  final GetGameScoreUseCase getGameScoreUseCase;
  final GetHighScoreUseCase getHighScoreUseCase;
  final ManageCoinsUseCase manageCoinsUseCase;

  GameScoreViewModel({
    required this.saveGameScoreUseCase,
    required this.getGameScoreUseCase,
    required this.getHighScoreUseCase,
    required this.manageCoinsUseCase,
  });

  GameScoreEntity? _currentScore;
  double _highScore = 0.0;
  int _totalCoins = 0;
  bool _isLoading = false;
  String? _error;

  // Getters
  GameScoreEntity? get currentScore => _currentScore;
  double get highScore => _highScore;
  int get totalCoins => _totalCoins;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Loads score for a specific level
  Future<void> loadScore(int level) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentScore = await getGameScoreUseCase.execute(level);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Saves current score
  Future<void> saveScore(GameScoreEntity score) async {
    try {
      await saveGameScoreUseCase.execute(score);
      _currentScore = score;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Loads high score
  Future<void> loadHighScore() async {
    try {
      _highScore = await getHighScoreUseCase.execute();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Loads total coins
  Future<void> loadCoins() async {
    try {
      _totalCoins = await manageCoinsUseCase.getTotalCoins();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Adds coins
  Future<void> addCoins(int amount) async {
    try {
      await manageCoinsUseCase.addCoins(amount);
      _totalCoins = await manageCoinsUseCase.getTotalCoins();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Deducts coins
  Future<void> deductCoins(int amount) async {
    try {
      await manageCoinsUseCase.deductCoins(amount);
      _totalCoins = await manageCoinsUseCase.getTotalCoins();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

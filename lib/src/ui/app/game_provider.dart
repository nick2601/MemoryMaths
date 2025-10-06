import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_provider.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/calculator_repository.dart';
import '../../data/repositories/complex_calcualtion_repository.dart';
import '../../data/repositories/correct_answer_repository.dart';
import '../../data/repositories/cube_root_repository.dart';
import '../../data/repositories/dual_repository.dart';
import '../../data/repositories/find_missing_repository.dart';
import '../../data/repositories/magic_triangle_repository.dart';
import '../../data/repositories/math_grid_repository.dart';
import '../../data/repositories/math_pairs_repository.dart';
import '../../data/repositories/mental_arithmetic_repository.dart';
import '../../data/repositories/number_pyramid_repository.dart';
import '../../data/repositories/numeric_memory_repository.dart';
import '../../data/repositories/picture_puzzle_repository.dart';
import '../../data/repositories/quick_calculation_repository.dart';
import '../../data/repositories/sign_repository.dart';
import '../../data/repositories/square_root_repository.dart';
import '../../data/repositories/true_false_repository.dart';
import 'coin_provider.dart';

/// Base provider for managing game state, score, timer, and lifecycle events.
/// Generic over the game model type [T].
/// Enhanced with proper OOP principles and inheritance.
class GameProvider<T> with ChangeNotifier, WidgetsBindingObserver {
  final GameCategoryType gameCategoryType;
  final DashboardProvider _homeViewModel = GetIt.I<DashboardProvider>();
  final TimeProvider _timeProvider;
  final BuildContext context;

  // Core game state - protected for inheritance
  @protected
  late List<T> list;
  @protected
  late int index;
  @protected
  late T currentState;
  @protected
  late String result;
  @protected
  late int levelNo;

  // Scoring system
  late double currentScore;
  late double oldScore;
  late int rightCount;
  late int wrongCount;

  // Dual game scores (only used by DualGameProvider)
  late double score1;
  late double score2;
  late bool isFirstClick;
  late bool isSecondClick;

  // Configuration
  late bool isTimer;
  late bool isRewardedComplete;

  // Statistics tracking
  late DateTime gameStartTime;
  late int totalCorrectAnswers;
  late int totalWrongAnswers;
  late int highestLevel;

  // Coin management
  CoinProvider? _coinProvider;
  VoidCallback? _coinListener;

  // Timer delegation
  DialogType get dialogType => _timeProvider.dialogType;
  set dialogType(DialogType value) => _timeProvider.dialogType = value;
  TimerStatus get timerStatus => _timeProvider.timerStatus;
  int get currentTime => _timeProvider.currentTime;

  // Public getters for protected members (needed by dialog listeners and views)
  int get currentIndex => index;
  int get currentLevel => levelNo;
  T get getCurrentState => currentState;
  List<T> get gameList => list;

  /// Creates a GameProvider for the specified game category and context.
  GameProvider({
    required TickerProvider vsync,
    required this.gameCategoryType,
    required this.context,
    bool? isTimer,
  }) : _timeProvider = TimeProvider(
         vsync: vsync,
         totalTime: KeyUtil.getTimeUtil(gameCategoryType),
       ) {
    _initializeGameState(isTimer);
    _setupProviders();
    _setupListeners();
  }

  /// Initialize core game state variables
  void _initializeGameState(bool? isTimer) {
    this.isTimer = isTimer ?? true;
    currentScore = 0;
    oldScore = 0;
    rightCount = 0;
    wrongCount = 0;
    score1 = 0;
    score2 = 0;
    isFirstClick = false;
    isSecondClick = false;
    isRewardedComplete = false;
    result = "";
    index = 0;
    levelNo = 1;

    // Statistics
    totalCorrectAnswers = 0;
    totalWrongAnswers = 0;
    highestLevel = 1;
  }

  /// Setup provider dependencies
  void _setupProviders() {
    try {
      _coinProvider = Provider.of<CoinProvider>(context, listen: false);
    } catch (_) {
      // Coin provider not available in context
    }
  }

  /// Setup listeners for providers
  void _setupListeners() {
    if (_coinProvider != null) {
      _coinListener = () => notifyListeners();
      _coinProvider!.addListener(_coinListener!);
    }

    _timeProvider.addListener(() => notifyListeners());
  }

  // Timer control methods
  void pauseTimer() => _timeProvider.pauseTimer();
  void resumeTimer() => _timeProvider.resumeTimer();
  void restartTimer() => _timeProvider.restartTimer();
  void reset() => _timeProvider.reset();
  void startTimer() => _timeProvider.startTimer();

  @override
  void dispose() {
    if (_coinProvider != null && _coinListener != null) {
      _coinProvider!.removeListener(_coinListener!);
    }
    _timeProvider.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Template method for starting the game - can be overridden by subclasses
  Future<void> startGame({int? level, bool? isTimer}) async {
    isTimer = isTimer ?? true;
    gameStartTime = DateTime.now();

    await _initializeGameData(level);
    await _handleFirstTimeUser();
    _setupGameObserver();
  }

  /// Initialize game data - template method
  Future<void> _initializeGameData(int? level) async {
    list = getList(level ?? 1);
    currentState = list[index];

    // Defer coin loading to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCoins();
    });
  }

  /// Handle first-time user experience
  Future<void> _handleFirstTimeUser() async {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    } else if (isTimer) {
      restartTimer();
      notifyListeners();
    }
  }

  /// Setup game lifecycle observer
  void _setupGameObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused && isTimer) {
      pauseTimer();
      dialogType = DialogType.pause;
      notifyListeners();
    }
  }

  /// Template method for handling correct answers
  void rightAnswer() {
    _updateScore(true);
    _trackAnswer(true);
    _addCoin();
    notifyListeners();
  }

  /// Template method for handling wrong answers
  void wrongAnswer() {
    _updateScore(false);
    _trackAnswer(false);
    _subtractCoin();

    if (currentScore <= 0) {
      _endGame();
    }
    notifyListeners();
  }

  /// Update score based on answer correctness
  void _updateScore(bool isCorrect) {
    oldScore = currentScore;

    if (isCorrect) {
      currentScore += KeyUtil.getScoreUtil(gameCategoryType);
    } else if (currentScore > 0) {
      double minusScore = KeyUtil.getScoreMinusUtil(gameCategoryType).abs();
      currentScore = (currentScore - minusScore).clamp(0, double.infinity);
    }
  }

  /// Track answer statistics
  void _trackAnswer(bool isCorrect) {
    if (isCorrect) {
      totalCorrectAnswers++;
      rightCount++;
    } else {
      totalWrongAnswers++;
      wrongCount++;
    }
  }

  /// Standard level progression - every 5 questions increases level
  @protected
  void updateLevelProgression() {
    int newLevel = (index ~/ 5) + 1;
    if (newLevel != levelNo) {
      levelNo = newLevel;
      if (levelNo > highestLevel) highestLevel = levelNo;
      onLevelUp(levelNo);
    }
  }

  /// Hook method for level up events - can be overridden
  @protected
  void onLevelUp(int newLevel) {
    print("[Level Up] ${gameCategoryType.toString()} -> Level $newLevel");
  }

  /// Template method for loading new data
  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    _resetClickStates();
    updateLevelProgression();

    if (_shouldLoadMoreData()) {
      _loadMoreData(level);
    }

    _moveToNextQuestion();
  }

  /// Reset dual game click states
  void _resetClickStates() {
    isFirstClick = false;
    isSecondClick = false;
  }

  /// Check if more data should be loaded
  bool _shouldLoadMoreData() {
    if (gameCategoryType == GameCategoryType.QUICK_CALCULATION) {
      return list.length - 2 <= index;
    }
    return list.length - 1 <= index;
  }

  /// Load more game data
  void _loadMoreData(int? level) {
    int newLevel = (index ~/ 5) + 1;
    int levelToLoad = level ?? newLevel;

    if (gameCategoryType == GameCategoryType.SQUARE_ROOT) {
      levelToLoad += 1;
    }

    list.addAll(getList(levelToLoad));
  }

  /// Move to next question
  void _moveToNextQuestion() {
    result = "";
    index++;

    if (index < list.length) {
      currentState = list[index];
    } else {
      _handleNoMoreQuestions();
    }
  }

  /// Handle case when no more questions are available
  void _handleNoMoreQuestions() {
    if (list.isNotEmpty) {
      int newLevel = (index ~/ 5) + 1;
      list.addAll(getList(newLevel));
      if (index < list.length) {
        currentState = list[index];
      }
    }
  }

  /// End the game
  void _endGame() {
    dialogType = DialogType.over;
    pauseTimer();
    _trackGameCompletion();
  }

  // Dialog management methods
  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    notifyListeners();
  }

  void showExitDialog() {
    pauseTimer();
    dialogType = DialogType.exit;
    notifyListeners();
  }

  void showHintDialog() {
    pauseTimer();
    dialogType = DialogType.hint;
    notifyListeners();
  }

  void pauseResumeGame() {
    if (!isTimer) return;

    if (timerStatus == TimerStatus.play) {
      pauseTimer();
      dialogType = DialogType.pause;
    } else {
      resumeTimer();
      dialogType = DialogType.non;
    }
    notifyListeners();
  }

  /// Handle info dialog acknowledgment
  void gotItFromInfoDialog(int? level) {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      _homeViewModel.setFirstTime(gameCategoryType);
      if (isTimer) {
        dialogType = DialogType.non;
        restartTimer();
      }
    } else {
      pauseResumeGame();
    }
    notifyListeners();
  }

  // Coin management - delegate to CoinProvider
  int get coin => _coinProvider?.coin ?? 0;

  /// Get coins (delegates to CoinProvider)
  Future<void> getCoin() async {
    await _coinProvider?.getCoin();
  }

  /// Add coins (public method for subclasses)
  Future<void> addCoin() async {
    _addCoin();
  }

  /// Subtract coins (public method for subclasses)
  Future<void> minusCoin({int? useCoin}) async {
    _subtractCoin(useCoin: useCoin);
  }

  /// Legacy getter for homeViewModel (for backward compatibility)
  DashboardProvider get homeViewModel => _homeViewModel;

  void _loadCoins() async {
    try {
      await _coinProvider?.getCoin();
    } catch (e) {
      print("Error loading coins: $e");
    }
  }

  void _addCoin() async {
    try {
      await _coinProvider?.addCoin();
    } catch (e) {
      print("Error adding coin: $e");
    }
  }

  void _subtractCoin({int? useCoin}) async {
    try {
      await _coinProvider?.minusCoin(useCoin: useCoin);
    } catch (e) {
      print("Error subtracting coin: $e");
    }
  }

  // Public methods for external access
  /// Gets the current answer safely, handling potential null cases
  dynamic getAnswer() {
    if (currentState == null) return '';
    try {
      return (currentState as dynamic).answer ?? '';
    } catch (e) {
      print('Error accessing answer: $e');
      return '';
    }
  }

  // Score management
  void updateScore() {
    _homeViewModel.updateScoreboard(gameCategoryType, currentScore);
    _trackGameCompletion();
  }

  /// Get current game statistics
  Map<String, dynamic> getCurrentStatistics() {
    return {
      'gameType': gameCategoryType.toString(),
      'currentScore': currentScore,
      'totalCorrectAnswers': totalCorrectAnswers,
      'totalWrongAnswers': totalWrongAnswers,
      'currentLevel': levelNo,
      'highestLevel': highestLevel,
      'accuracy': _calculateAccuracy(),
    };
  }

  double _calculateAccuracy() {
    int totalAnswers = totalCorrectAnswers + totalWrongAnswers;
    return totalAnswers > 0 ? (totalCorrectAnswers / totalAnswers) * 100 : 0.0;
  }

  /// Track game completion statistics
  Future<void> _trackGameCompletion() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final reportProvider = Provider.of<UserReportProvider>(context, listen: false);

      if (authProvider.userEmail != null) {
        final gameDuration = DateTime.now().difference(gameStartTime).inMinutes.clamp(1, 999);

        await reportProvider.updateUserStatistics(
          email: authProvider.userEmail!,
          gameType: gameCategoryType,
          score: currentScore,
          level: highestLevel,
          correctAnswers: totalCorrectAnswers,
          wrongAnswers: totalWrongAnswers,
          durationMinutes: gameDuration,
        );
      }
    } catch (e) {
      print("Error tracking game statistics: $e");
    }
  }

  // Dual game specific methods - can be overridden by DualGameProvider
  @protected
  void wrongDualAnswer(bool isFirst) {
    if (isFirst) {
      _handleDualScore1();
    } else {
      _handleDualScore2();
    }
  }

  void _handleDualScore1() {
    if (score1 > 0) {
      score1--;
    } else if (score1 == 0 && isSecondClick && score2 <= 0) {
      _endGame();
    }
    notifyListeners();
  }

  void _handleDualScore2() {
    if (score2 > 0) {
      score2--;
    } else if (score2 == 0 && isFirstClick && score1 <= 0) {
      _endGame();
    }
    notifyListeners();
  }

  /// Virtual method for getting game-specific data - can be overridden by subclasses
  /// Provides default implementation using repository pattern
  @protected
  List<T> getList(int level) {
    levelNo = level;
    return _getGameData(level);
  }

  /// Repository pattern implementation for game data
  List<T> _getGameData(int level) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level) as List<T>;
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(level) as List<T>;
      case GameCategoryType.FIND_MISSING:
        return FindMissingRepository.getFindMissingDataList(level) as List<T>;
      case GameCategoryType.TRUE_FALSE:
        return TrueFalseRepository.getTrueFalseDataList(level) as List<T>;
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level) as List<T>;
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level) as List<T>;
      case GameCategoryType.CONCENTRATION:
        return MathPairsRepository.getMathPairsDataList(level) as List<T>;
      case GameCategoryType.NUMERIC_MEMORY:
        return NumericMemoryRepository.getNumericMemoryDataList(level) as List<T>;
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level) as List<T>;
      case GameCategoryType.MAGIC_TRIANGLE:
        return level > 15
            ? MagicTriangleRepository.getNextLevelTriangleDataProviderList() as List<T>
            : MagicTriangleRepository.getTriangleDataProviderList() as List<T>;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level) as List<T>;
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5) as List<T>;
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level) as List<T>;
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level) as List<T>;
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level) as List<T>;
      case GameCategoryType.DUAL_GAME:
        return DualRepository.getDualData(level) as List<T>;
      case GameCategoryType.COMPLEX_CALCULATION:
        return ComplexCalculationRepository.getComplexData(level) as List<T>;
      case GameCategoryType.CUBE_ROOT:
        return CubeRootRepository.getCubeDataList(level) as List<T>;
      default:
        throw Exception("Unsupported game category type: $gameCategoryType");
    }
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/core/adaptive_difficulty.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/accessibility_provider.dart';
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

int rightCoin = 10;
int wrongCoin = 5;
int hintCoin = 10;

/// Base provider for managing game state, score, timer, and lifecycle events.
/// Generic over the game model type [T].
/// Now includes user statistics tracking for comprehensive progress monitoring.
class GameProvider<T> with ChangeNotifier, WidgetsBindingObserver {
  final GameCategoryType gameCategoryType;
  final _homeViewModel = GetIt.I<DashboardProvider>();
  final homeViewModel = GetIt.I<DashboardProvider>();

  // TimeProvider for handling the timer
  final TimeProvider _timeProvider;

  // Timer-related getters to access TimeProvider's properties
  DialogType get dialogType => _timeProvider.dialogType;
  set dialogType(DialogType value) => _timeProvider.dialogType = value;

  TimerStatus get timerStatus => _timeProvider.timerStatus;
  int get currentTime => _timeProvider.currentTime;

  // Game state variables
  late List<T> list;
  late int index;
  late double currentScore;
  late double score1 = 0;
  late double score2 = 0;
  late int rightCount = 0;
  late int wrongCount = 0;
  late double oldScore;
  late T currentState;
  late String result;
  late bool isTimer;
  late bool isRewardedComplete = false;
  late int levelNo;
  late BuildContext c;

  // Statistics tracking variables
  late DateTime gameStartTime;
  late int totalCorrectAnswers = 0;
  late int totalWrongAnswers = 0;
  late int highestLevel = 1;

  // --- Adaptive Difficulty Support ---
  final AdaptiveDifficultyManager _adaptive = AdaptiveDifficultyManager();
  DateTime? _questionStart; // per-question timer
  AccessibilityProvider? _accessibility;

  CoinProvider? _coinProvider; // reference to coin provider

  /// Creates a GameProvider for the specified game category and context.
  GameProvider({
    required TickerProvider vsync,
    required this.gameCategoryType,
    required this.c,
    bool? isTimer,
  }) : _timeProvider = TimeProvider(
         vsync: vsync,
         totalTime: KeyUtil.getTimeUtil(gameCategoryType),
       ) {
    this.isTimer = (isTimer == null) ? true : isTimer;
    // acquire coin provider (if available in tree) and listen for changes
    try {
      _coinProvider = Provider.of<CoinProvider>(c, listen: false);
      // Store the listener function so we can remove it later
      _coinListener = () => notifyListeners();
      _coinProvider?.addListener(_coinListener!);

      // accessibility provider (optional if not in tree yet)
      _accessibility = Provider.of<AccessibilityProvider>(c, listen: false);
    } catch (_) {}
    print("isTimer12===$isTimer");

    // Add listener to the timeProvider to propagate changes
    _timeProvider.addListener(() {
      notifyListeners();
    });
  }

  // Add a variable to store the coin listener function
  VoidCallback? _coinListener;

  // Timer control methods that delegate to the TimeProvider
  void pauseTimer() => _timeProvider.pauseTimer();
  void resumeTimer() => _timeProvider.resumeTimer();
  void restartTimer() => _timeProvider.restartTimer();
  void reset() => _timeProvider.reset();
  void startTimer() => _timeProvider.startTimer();

  @override
  void dispose() {
    // Remove the coin provider listener before disposing
    if (_coinProvider != null && _coinListener != null) {
      _coinProvider!.removeListener(_coinListener!);
    }

    _timeProvider.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Starts the game, initializes state, and handles first-time info dialog.
  void startGame({int? level, bool? isTimer}) async {
    isTimer = (isTimer == null) ? true : isTimer;
    result = "";

    // Initialize statistics tracking
    gameStartTime = DateTime.now();
    totalCorrectAnswers = 0;
    totalWrongAnswers = 0;
    highestLevel = level ?? 1;

    list = [];
    list = getList(level == null ? 1 : level);

    print("list--${list.length}====");
    index = 0;
    currentScore = 0;
    oldScore = 0;
    currentState = list[index];
    _questionStart = DateTime.now();
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    } else {
      print("isTimerStart==$isTimer");
      if (isTimer) {
        restartTimer();
        notifyListeners();
      }
    }

    // Defer coin loading until after build phase to prevent setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCoin();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (isTimer) {
          pauseTimer();
          dialogType = DialogType.pause;
          notifyListeners();
        }
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden: // Newer Flutter lifecycle state
        // Treat similar to paused (no extra action needed now)
        break;
    }
  }

  /// Loads new data for the next round or ends the game if finished.
  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    isFirstClick = false;
    isSecondClick = false;
    print("list12===${list.length}");

    if (index < 19) {
      if (gameCategoryType == GameCategoryType.QUICK_CALCULATION &&
          list.length - 2 == index) {
        list.addAll(getList(level == null ? index ~/ 5 + 1 : level));
      } else if (list.length - 1 == index) {
        print("level---${index ~/ 5 + 1}");
        if (gameCategoryType == GameCategoryType.SQUARE_ROOT)
          list.addAll(getList(level == null ? index ~/ 5 + 2 : level));
        else
          list.addAll(getList(level == null ? index ~/ 5 + 1 : level));
      }
      print("list1212===${list.length}");
      result = "";
      index = index + 1;

      print("index===$index");
      currentState = list[index];
      _questionStart = DateTime.now();
    } else {
      dialogType = DialogType.over;
      if (isTimer) {
        pauseTimer();
      }

      // Track game completion statistics when game ends
      _trackGameCompletion();

      notifyListeners();
    }
  }

  bool isFirstClick = false;
  bool isSecondClick = false;

  /// Handles wrong answer logic for dual games.
  void wrongDualAnswer(bool isFirst) {
    if (isFirst) {
      if (score1 > 0) {
        score1--;
        notifyListeners();
      } else if (score1 == 0 && isSecondClick && score2 <= 0) {
        dialogType = DialogType.over;
        pauseTimer();
        notifyListeners();
      } else {
        notifyListeners();
      }
    } else {}
    if (score2 > 0) {
      score2--;
      notifyListeners();
    } else if (score2 == 0 && isFirstClick && score1 <= 0) {
      dialogType = DialogType.over;

      pauseTimer();
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  /// Handles correct answer logic and updates score.
  void rightAnswer() {
    // Measure response time for adaptive difficulty
    final responseMillis = _questionStart == null
        ? 0
        : DateTime.now().difference(_questionStart!).inMilliseconds;

    print("currentScoreRight===$currentScore");
    oldScore = currentScore;
    currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

    // Track correct answer for statistics
    totalCorrectAnswers++;
    rightCount++;

    addCoin();

    print("currentScore===12 $currentScore");

    _adaptive.recordSample(isCorrect: true, responseMillis: responseMillis);

    notifyListeners();
  }

  /// Handles wrong answer logic and updates score.
  void wrongAnswer() {
    final responseMillis = _questionStart == null
        ? 0
        : DateTime.now().difference(_questionStart!).inMilliseconds;

    // Track wrong answer for statistics
    totalWrongAnswers++;
    wrongCount++;

    minusCoin();
    if (currentScore > 0) {
      oldScore = currentScore;
      double minusScore = KeyUtil.getScoreMinusUtil(gameCategoryType);
      if (minusScore < 0) {
        minusScore = minusScore.abs();
      }
      currentScore = currentScore - minusScore;
      notifyListeners();
    } else if (currentScore == 0) {
      dialogType = DialogType.over;
      pauseTimer();

      // Track game completion when user runs out of score
      _trackGameCompletion();

      _adaptive.recordSample(isCorrect: false, responseMillis: responseMillis);

      notifyListeners();
    }
  }

  /// Pauses or resumes the game timer and updates dialog state.
  void pauseResumeGame() {
    dialogType = DialogType.non;
    if (isTimer) {
      if (timerStatus == TimerStatus.play) {
        pauseTimer();
        dialogType = DialogType.pause;
        notifyListeners();
      } else {
        resumeTimer();
        dialogType = DialogType.non;
        notifyListeners();
      }
    }

    print("dialogType====${dialogType}");
  }

  /// Shows the info dialog and pauses the timer.
  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    notifyListeners();
  }

  /// Shows the exit dialog and pauses the timer.
  void showExitDialog() {
    print("dialog---true2");
    pauseTimer();
    print("dialog---true3");
    dialogType = DialogType.exit;
    print("dialog---true1");
    notifyListeners();
  }

  /// Shows the hint dialog and pauses the timer.
  void showHintDialog() {
    print("dialog---true2");
    pauseTimer();
    print("dialog---true3");
    dialogType = DialogType.hint;
    print("dialog---true1");
    notifyListeners();
  }

  /// Updates the score in the dashboard provider.
  void updateScore() {
    print("currentScore===$currentScore");
    _homeViewModel.updateScoreboard(gameCategoryType, currentScore);

    // Track final game completion statistics
    _trackGameCompletion();
  }

  /// Tracks game completion statistics and sends to UserReportProvider
  void _trackGameCompletion() async {
    try {
      final authProvider = Provider.of<AuthProvider>(c, listen: false);
      final reportProvider = Provider.of<UserReportProvider>(c, listen: false);

      if (authProvider.userEmail != null) {
        // Calculate game duration in minutes
        final gameDuration = DateTime.now().difference(gameStartTime).inMinutes.clamp(1, 999);

        // Update level tracking
        final currentLevel = levelNo;
        if (currentLevel > highestLevel) {
          highestLevel = currentLevel;
        }

        // Update user statistics
        await reportProvider.updateUserStatistics(
          email: authProvider.userEmail!,
          gameType: gameCategoryType,
          score: currentScore,
          level: highestLevel,
          correctAnswers: totalCorrectAnswers,
          wrongAnswers: totalWrongAnswers,
          durationMinutes: gameDuration,
        );

        print("Statistics tracked successfully for ${gameCategoryType.toString()}");
        print("Score: $currentScore, Correct: $totalCorrectAnswers, Wrong: $totalWrongAnswers, Duration: ${gameDuration}min");
      } else {
        print("User not logged in, statistics not tracked");
      }
    } catch (e) {
      print("Error tracking game statistics: $e");
    }
  }

  /// Tracks individual answer for real-time statistics (optional for advanced tracking)
  void _trackAnswer(bool isCorrect) {
    if (isCorrect) {
      totalCorrectAnswers++;
      rightCount++;
    } else {
      totalWrongAnswers++;
      wrongCount++;
    }
  }

  /// Enhanced right answer method with immediate tracking
  void rightAnswerWithTracking() {
    rightAnswer();
    _trackAnswer(true);
  }

  /// Enhanced wrong answer method with immediate tracking
  void wrongAnswerWithTracking() {
    wrongAnswer();
    _trackAnswer(false);
  }

  /// Method to manually update level for statistics tracking
  void updateLevel(int newLevel) {
    if (newLevel > highestLevel) {
      highestLevel = newLevel;
    }
    levelNo = newLevel;
  }

  /// Get current game statistics summary
  Map<String, dynamic> getCurrentStatistics() {
    return {
      'gameType': gameCategoryType.toString(),
      'currentScore': currentScore,
      'totalCorrectAnswers': totalCorrectAnswers,
      'totalWrongAnswers': totalWrongAnswers,
      'currentLevel': levelNo,
      'highestLevel': highestLevel,
      'gameStartTime': gameStartTime.toIso8601String(),
      'accuracy': totalCorrectAnswers + totalWrongAnswers > 0
          ? (totalCorrectAnswers / (totalCorrectAnswers + totalWrongAnswers)) * 100
          : 0.0,
    };
  }

  /// Expose current coin balance (falls back to 0 if coin provider not found).
  int get coin => _coinProvider?.coin ?? 0;

  /// Gets current coin balance
  void getCoin() async {
    try {
      final coinProvider = Provider.of<CoinProvider>(c, listen: false);
      await coinProvider.getCoin();
    } catch (e) {
      print("Error getting coin: $e");
    }
  }

  /// Add coins for correct answer
  void addCoin() async {
    try {
      final coinProvider = _coinProvider ?? Provider.of<CoinProvider>(c, listen: false);
      await coinProvider.addCoin();
      notifyListeners();
    } catch (e) {
      print("Error adding coin: $e");
    }
  }

  /// Subtract coins for wrong answer
  void minusCoin({int? useCoin}) async {
    try {
      final coinProvider = _coinProvider ?? Provider.of<CoinProvider>(c, listen: false);
      await coinProvider.minusCoin(useCoin: useCoin);
      notifyListeners();
    } catch (e) {
      print("Error subtracting coin: $e");
    }
  }

  /// Handles the acknowledgement action from the info dialog (restoring gameplay / starting timer on first play).
  void gotItFromInfoDialog(int? level) {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      _homeViewModel.setFirstTime(gameCategoryType);
      if (isTimer) {
        dialogType = DialogType.non; // Clear the info dialog state
        restartTimer(); // Start the timer
        print("Timer started after info dialog dismissed");
      }
    } else {
      pauseResumeGame();
    }
    notifyListeners();
  }

  /// Returns the list of game models for the given level.
  List<T> getList(int level) {
    this.levelNo = level;

    // If adaptive difficulty is enabled, adjust requested level (without mutating original levelNo yet)
    final bool adaptOn = _accessibility?.adaptiveDifficultyEnabled ?? false;
    final int requestedLevel = adaptOn ? _adaptive.adjustedLevel(levelNo) : levelNo;

    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(requestedLevel) as List<T>;
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(requestedLevel) as List<T>;
      case GameCategoryType.FIND_MISSING:
        return FindMissingRepository.getFindMissingDataList(requestedLevel) as List<T>;
      case GameCategoryType.TRUE_FALSE:
        return TrueFalseRepository.getTrueFalseDataList(requestedLevel) as List<T>;
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(requestedLevel) as List<T>;
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(requestedLevel) as List<T>;
      case GameCategoryType.CONCENTRATION:
        return MathPairsRepository.getMathPairsDataList(requestedLevel) as List<T>;
      case GameCategoryType.NUMERIC_MEMORY:
        return NumericMemoryRepository.getNumericMemoryDataList(requestedLevel) as List<T>;
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(requestedLevel) as List<T>;
      case GameCategoryType.MAGIC_TRIANGLE:
        if (requestedLevel > 15) {
          return MagicTriangleRepository.getNextLevelTriangleDataProviderList() as List<T>;
        } else {
          return MagicTriangleRepository.getTriangleDataProviderList() as List<T>;
        }
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(requestedLevel) as List<T>;
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(requestedLevel, 5) as List<T>;
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(requestedLevel) as List<T>;
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(requestedLevel) as List<T>;
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(requestedLevel) as List<T>;
      case GameCategoryType.DUAL_GAME:
        return DualRepository.getDualData(requestedLevel) as List<T>;
      case GameCategoryType.COMPLEX_CALCULATION:
        return ComplexCalculationRepository.getComplexData(requestedLevel) as List<T>;
      case GameCategoryType.CUBE_ROOT:
        return CubeRootRepository.getCubeDataList(requestedLevel) as List<T>;
      default:
        throw Exception("Unsupported game category type: $gameCategoryType");
    }
  }

  /// Debug info for adaptive difficulty (can be surfaced in dev panel)
  Map<String, dynamic> adaptiveSnapshot() => _adaptive.snapshot(currentLevel: levelNo);
}

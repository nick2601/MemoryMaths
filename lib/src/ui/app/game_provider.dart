import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/repository/calculator_repository.dart';
import 'package:mathsgames/src/data/repository/complex_calcualtion_repository.dart';
import 'package:mathsgames/src/data/repository/correct_answer_repository.dart';
import 'package:mathsgames/src/data/repository/cube_root_repository.dart';
import 'package:mathsgames/src/data/repository/dual_repository.dart';
import 'package:mathsgames/src/data/repository/find_missing_repository.dart';
import 'package:mathsgames/src/data/repository/magic_triangle_repository.dart';
import 'package:mathsgames/src/data/repository/math_grid_repository.dart';
import 'package:mathsgames/src/data/repository/math_pairs_repository.dart';
import 'package:mathsgames/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/data/repository/number_pyramid_repository.dart';
import 'package:mathsgames/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathsgames/src/data/repository/quick_calculation_repository.dart';
import 'package:mathsgames/src/data/repository/sign_repository.dart';
import 'package:mathsgames/src/data/repository/square_root_repository.dart';
import 'package:mathsgames/src/data/repository/true_false_repository.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import '../../data/repository/numeric_memory_repository.dart';

int rightCoin = 10;
int wrongCoin = 5;
int hintCoin = 10;

class GameProvider<T> extends TimeProvider with WidgetsBindingObserver {
  final GameCategoryType gameCategoryType;
  final _homeViewModel = GetIt.I<DashboardProvider>();
  final homeViewModel = GetIt.I<DashboardProvider>();

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
 // late AdsFile adsFile;
  late BuildContext c;

  GameProvider(
      {required TickerProvider vsync,
      required this.gameCategoryType,
      required this.c,
      bool? isTimer})
      : super(
          vsync: vsync,
          totalTime: KeyUtil.getTimeUtil(gameCategoryType),
        ) {
    this.isTimer = (isTimer == null) ? true : isTimer;
    // adsFile = new AdsFile(c);
    //
    // adsFile.createRewardedAd();
    print("isTimer12===$isTimer");
  }

  @override
  void dispose() {
    //disposeRewardedAd(adsFile);
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void startGame({int? level, bool? isTimer}) async {
    isTimer = (isTimer == null) ? true : isTimer;
    result = "";

    list = [];
    list = getList(level == null ? 1 : level);

    print("list--${list.length}====");
    index = 0;
    currentScore = 0;
    oldScore = 0;
    currentState = list[index];
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
    getCoin();
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
        // widget is inactive
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
    }
  }

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
      // if(isScoreAdd==null) {
      //   oldScore = currentScore;
      //   currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
      //
      //
      //   print("currentScore===$currentScore==${KeyUtil.getScoreUtil(
      //       gameCategoryType)}");
      // }
      currentState = list[index];
    } else {
      dialogType = DialogType.over;
      if (isTimer) {
        pauseTimer();
      }
      notifyListeners();
    }
  }

  bool isFirstClick = false;
  bool isSecondClick = false;

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

  void rightAnswer() {
    print("currentScoreRight===$currentScore");
    oldScore = currentScore;
    currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

    addCoin();

    print("currentScore===12 $currentScore");
    notifyListeners();
  }

  void wrongAnswer() {
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
      notifyListeners();
    }
  }

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

  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    notifyListeners();
  }

  void showExitDialog() {
    print("dialog---true2");
    pauseTimer();
    print("dialog---true3");
    dialogType = DialogType.exit;
    print("dialog---true1");
    notifyListeners();
  }

  void showHintDialog() {
    print("dialog---true2");
    pauseTimer();
    print("dialog---true3");
    dialogType = DialogType.hint;
    print("dialog---true1");
    notifyListeners();
  }

  void updateScore() {
    print("currentScore===$currentScore");
    _homeViewModel.updateScoreboard(gameCategoryType, currentScore);
  }

  void gotItFromInfoDialog(int? level) {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      _homeViewModel.setFirstTime(gameCategoryType);
      if (gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
        startGame(level: level);
      }
      if (isTimer) {
        restartTimer();
      }
    } else {
      pauseResumeGame();
    }

    print("home-==${_homeViewModel.isFirstTime(gameCategoryType)}");
  }

  List<T> getList(int level) {
    this.levelNo = level;

    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level);
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(level);
      case GameCategoryType.FIND_MISSING:
        return FindMissingRepository.getFindMissingDataList(level);
      case GameCategoryType.TRUE_FALSE:
        return TrueFalseRepository.getTrueFalseDataList(level);
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level);
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level);
      case GameCategoryType.CONCENTRATION:
        return MathPairsRepository.getMathPairsDataList(level);
      case GameCategoryType.NUMERIC_MEMORY:
        return NumericMemoryRepository.getNumericMemoryDataList(level);
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level);
      case GameCategoryType.MAGIC_TRIANGLE:
        if (level > 15) {
          return MagicTriangleRepository.getNextLevelTriangleDataProviderList();
        } else {
          return MagicTriangleRepository.getTriangleDataProviderList();
        }
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level);
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5);
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level);
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level);
      case GameCategoryType.DUAL_GAME:
        return DualRepository.getDualData(level);
      case GameCategoryType.COMPLEX_CALCULATION:
        return ComplexCalculationRepository.getComplexData(level);
      case GameCategoryType.CUBE_ROOT:
        return CubeRootRepository.getCubeDataList(level);
    }
  }
}

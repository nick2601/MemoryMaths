import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';

import 'app_assets.dart';

enum GameCategoryType {
  CALCULATOR,
  GUESS_SIGN,
  SQUARE_ROOT,
  MATH_PAIRS,
  CORRECT_ANSWER,
  MAGIC_TRIANGLE,
  MENTAL_ARITHMETIC,
  QUICK_CALCULATION,
  FIND_MISSING,
  TRUE_FALSE,
  MATH_GRID,
  PICTURE_PUZZLE,
  NUMBER_PYRAMID,
  DUAL_GAME,
  COMPLEX_CALCULATION,
  CUBE_ROOT,
  CONCENTRATION,
  NUMERIC_MEMORY,
}

enum PuzzleType { MATH_PUZZLE, MEMORY_PUZZLE, BRAIN_PUZZLE }

enum TimerStatus {
  restart,
  play,
  pause,
}

enum DialogType {
  non,
  info,
  over,
  pause,
  exit,
  hint,
}

class KeyUtil {
  static const IS_DARK_MODE = "isDarkMode";

  static const String splash = 'Splash';
  static const String dashboard = 'Dashboard';
  static const String login = 'Login';
  static const String signup = 'Signup';

  static const String home = 'Home';
  static const String level = 'Level';
  static const String dual = 'Dual';

  static const String calculator = 'Calculator';
  static const String guessSign = 'GuessSign';
  static const String trueFalse = 'TrueFalse';
  static const String dualGame = 'dualGame';
  static const String complexCalculation = 'complexCalculation';
  static const String correctAnswer = 'CorrectAnswer';
  static const String quickCalculation = 'QuickCalculation';
  static const String findMissing = 'FindMissing';
  static const String mentalArithmetic = 'MentalArithmetic';
  static const String squareRoot = 'SquareRoot';
  static const String mathPairs = 'MathPairs';
  static const String concentration = 'concentration';
  static const String cubeRoot = 'cubeRoot';

  static const String magicTriangle = 'MagicTriangle';
  static const String picturePuzzle = 'PicturePuzzle';
  static const String mathGrid = 'MathGrid';
  static const String numberPyramid = "NumberPyramid";
  static const String numericMemory = "numericMemory";
  static Color primaryColor1 = "#FFCB43".toColor();
  static Color bgColor1 = "#FFF2D5".toColor();
  static Color backgroundColor1 = "#FFDB7C".toColor();
  static Color backgroundColor2 = "#C2ECA3".toColor();
  static Color backgroundColor3 = "#E3D9FF".toColor();
  static Color primaryColor2 = "#AAE37B".toColor();
  static Color bgColor2 = "#EAF9DF".toColor();
  static Color primaryColor3 = "#C3AEFF".toColor();
  static Color bgColor3 = "#EFEBFE".toColor();
  static Color blackTransparentColor = "#BF000000".toColor();
  static String themeYellowFolder = 'imgYellow/';
  static String themeOrangeFolder = 'imgGreen/';
  static String themeBlueFolder = 'imgBlue/';

  static List<Dashboard> dashboardItems = [
    Dashboard(
        puzzleType: PuzzleType.MATH_PUZZLE,
        colorTuple: Tuple2(Color(0xff4895EF), Color(0xff3f37c9)),
        opacity: 0.07,
        outlineIcon: AppAssets.icMathPuzzleOutline,
        subtitle: "Each game with simple calculation with different approach.",
        title: "Mental Maths",
        gridColor: bgColor1,
        fillIconColor: Color(0xff4895ef),
        position: 0,
        outlineIconColor: Color(0xff436add),
        bgColor: bgColor1,
        backgroundColor: backgroundColor1,
        folder: themeYellowFolder,
        primaryColor: primaryColor1),
    Dashboard(
        position: 1,
        backgroundColor: backgroundColor2,
        puzzleType: PuzzleType.MEMORY_PUZZLE,
        colorTuple: Tuple2(Color(0xff9f2beb), Color(0xff560bad)),
        opacity: 0.07,
        outlineIcon: AppAssets.icMemoryPuzzleOutline,
        gridColor: bgColor2,
        subtitle:
            "Memorise numbers & signs before applying calculation to them.",
        title: "Memory Puzzle",
        fillIconColor: Color(0xff9f2beb),
        outlineIconColor: Color(0xff560BAD),
        bgColor: bgColor2,
        folder: themeOrangeFolder,
        primaryColor: primaryColor2),
    Dashboard(
        position: 2,
        gridColor: bgColor3,
        backgroundColor: backgroundColor3,
        puzzleType: PuzzleType.BRAIN_PUZZLE,
        colorTuple: Tuple2(Color(0xfff72585), Color(0xffb5179e)),
        opacity: 0.12,
        outlineIcon: AppAssets.icTrainBrainOutline,
        subtitle:
            "Enhance logical thinking, concentration and core cognitive skills.",
        title: "Train Your Brain",
        folder: themeBlueFolder,
        fillIconColor: Color(0xfff72585),
        outlineIconColor: Color(0xffB5179E),
        bgColor: bgColor3,
        primaryColor: primaryColor3),
  ];

  static List<Color> bgColorList = [
    bgColor1,
    bgColor2,
    bgColor3,
  ];

  static int getTimeUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorTimeOut;
      case GameCategoryType.GUESS_SIGN:
        return guessSignTimeOut;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootTimeOut;
      case GameCategoryType.CUBE_ROOT:
        return cubeRootTimeOut;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsTimeOut;
      case GameCategoryType.CONCENTRATION:
        return concentrationTimeOut;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerTimeOut;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleTimeOut;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticTimeOut;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationTimeOut;
      case GameCategoryType.MATH_GRID:
        return mathGridTimeOut;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleTimeOut;
      case GameCategoryType.NUMBER_PYRAMID:
        return numPyramidTimeOut;
      case GameCategoryType.NUMBER_PYRAMID:
        return numPyramidTimeOut;
      case GameCategoryType.FIND_MISSING:
        return findMissingTimeOut;

      case GameCategoryType.TRUE_FALSE:
        return trueFalseTimeOut;

      case GameCategoryType.DUAL_GAME:
        return dualTimeOut;
      case GameCategoryType.COMPLEX_CALCULATION:
        return complexCalculationTimeOut;

      case GameCategoryType.NUMERIC_MEMORY:
        return numericMemoryTimeOut;
    }
  }

  static double getScoreUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorScore;
      case GameCategoryType.GUESS_SIGN:
        return guessSignScore;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootScore;

      case GameCategoryType.CUBE_ROOT:
        return cubeRootScore;
      case GameCategoryType.MATH_PAIRS:
        return mathGridScore;
      case GameCategoryType.CONCENTRATION:
        return concentrationScore;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerScore;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleScore;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticScore;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationScore;
      case GameCategoryType.MATH_GRID:
        return mathGridScore;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidScore;
      case GameCategoryType.FIND_MISSING:
        return findMissingScore;
      case GameCategoryType.TRUE_FALSE:
        return trueFalseScore;
      case GameCategoryType.DUAL_GAME:
        return dualScore;
      case GameCategoryType.COMPLEX_CALCULATION:
        return complexCalculationScore;

      case GameCategoryType.NUMERIC_MEMORY:
        return numericMemoryScore;
    }
  }

  static double getScoreMinusUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorScoreMinus;
      case GameCategoryType.GUESS_SIGN:
        return guessSignScoreMinus;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootScoreMinus;
      case GameCategoryType.CUBE_ROOT:
        return cubeRootScoreMinus;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsScoreMinus;
      case GameCategoryType.CONCENTRATION:
        return concentrationScoreMinus;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerScoreMinus;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleScoreMinus;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticScoreMinus;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationScoreMinus;
      case GameCategoryType.MATH_GRID:
        return mathGridScoreMinus;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleScoreMinus;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidScoreMinus;
      case GameCategoryType.FIND_MISSING:
        return findMissingScoreMinus;
      case GameCategoryType.TRUE_FALSE:
        return trueFalseScoreMinus;
      case GameCategoryType.DUAL_GAME:
        return dualScoreMinus;

      case GameCategoryType.COMPLEX_CALCULATION:
        return complexCalculationScoreMinus;

      case GameCategoryType.NUMERIC_MEMORY:
        return numericMemoryScoreMinus;
    }
  }

  static double getCoinUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorCoin;
      case GameCategoryType.GUESS_SIGN:
        return guessSignCoin;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootCoin;
      case GameCategoryType.CUBE_ROOT:
        return cubeRootCoin;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsCoin;
      case GameCategoryType.CONCENTRATION:
        return concentrationCoin;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerCoin;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleCoin;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticCoin;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationCoin;
      case GameCategoryType.MATH_GRID:
        return mathGridCoin;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleCoin;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidCoin;
      case GameCategoryType.FIND_MISSING:
        return findMissingCoin;
      case GameCategoryType.TRUE_FALSE:
        return truFalseCoin;
      case GameCategoryType.DUAL_GAME:
        return dualGameCoin;
      case GameCategoryType.COMPLEX_CALCULATION:
        return complexCalculationCoin;
      case GameCategoryType.NUMERIC_MEMORY:
        return numericMemoryCoin;
    }
  }

  //Game TimeOut Constant
  static int calculatorTimeOut = 20;
  static int guessSignTimeOut = 20;
  static int correctAnswerTimeOut = 20;
  static int quickCalculationTimeOut = 20;
  static int quickCalculationPlusTime = 1;

  static int findMissingTimeOut = 20;
  static int findMissingTime = 1;

  static int trueFalseTimeOut = 20;
  static int trueFalseTime = 1;

  static int numericMemoryTimeOut = 5;
  static int numericMemoryTime = 1;

  static int complexCalculationTimeOut = 20;
  static int complexCalculationTime = 1;

  static int dualTimeOut = 20;
  static int dualTime = 1;

  static int mentalArithmeticTimeOut = 60;
  static int mentalArithmeticLocalTimeOut = 4;
  static int squareRootTimeOut = 15;
  static int cubeRootTimeOut = 15;
  static int mathGridTimeOut = 120;

  static int mathematicalPairsTimeOut = 60;
  static int concentrationTimeOut = 15;

  static int magicTriangleTimeOut = 60;
  static int picturePuzzleTimeOut = 90;
  static int numPyramidTimeOut = 120;

  //Game Score Constant
  static double calculatorScore = 1;
  static double calculatorScoreMinus = -1;

  static double complexCalculationScore = 1;
  static double complexCalculationScoreMinus = -1;

  static double numericMemoryScore = 1;
  static double numericMemoryScoreMinus = -1;

  static double guessSignScore = 1;
  static double guessSignScoreMinus = -1;

  static double correctAnswerScore = 1;
  static double correctAnswerScoreMinus = -1;

  static double findMissingScore = 1;
  static double findMissingScoreMinus = -1;

  static double dualScore = 1;
  static double dualScoreMinus = -1;

  static double trueFalseScore = 1;
  static double trueFalseScoreMinus = -1;

  static double quickCalculationScore = 1;
  static double quickCalculationScoreMinus = -1;

  static double mentalArithmeticScore = 2;
  static double mentalArithmeticScoreMinus = -1;

  static double squareRootScore = 1;
  static double squareRootScoreMinus = -1;

  static double cubeRootScore = 1;
  static double cubeRootScoreMinus = -1;

  static double mathematicalPairsScore = 5;
  static double mathematicalPairsScoreMinus = -5;

  static double mathGridScore = 5;
  static double mathGridScoreMinus = 0;

  static double concentrationScore = 5;
  static double concentrationScoreMinus = 0;

  static double magicTriangleScore = 5;
  static double magicTriangleScoreMinus = 0;

  static double picturePuzzleScore = 2;
  static double picturePuzzleScoreMinus = -1;

  static double numberPyramidScore = 5;
  static double numberPyramidScoreMinus = 0;

  //Game Coin Constant
  static double calculatorCoin = 0.5;
  static double guessSignCoin = 0.5;
  static double correctAnswerCoin = 0.5;
  static double quickCalculationCoin = 0.5;

  static double mentalArithmeticCoin = 1;
  static double squareRootCoin = 0.5;
  static double cubeRootCoin = 0.5;
  static double mathGridCoin = 3;
  static double mathematicalPairsCoin = 1;
  static double concentrationCoin = 1;

  static double magicTriangleCoin = 3;
  static double picturePuzzleCoin = 1;
  static double numberPyramidCoin = 3;
  static double findMissingCoin = 1;
  static double truFalseCoin = 1;
  static double dualGameCoin = 1;
  static double complexCalculationCoin = 1;
  static double numericMemoryCoin = 1;
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

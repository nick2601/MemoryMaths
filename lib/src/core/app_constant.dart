import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';

import 'app_assets.dart';

/// Enum representing different types of math games available in the application.
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

/// Enum for categorizing puzzles into main categories.
enum PuzzleType { MATH_PUZZLE, MEMORY_PUZZLE, BRAIN_PUZZLE }

/// Enum for managing timer states in games.
enum TimerStatus {
  restart,
  play,
  pause,
}

/// Enum for different types of dialog boxes shown in the app.
enum DialogType {
  /// No dialog is shown.
  non,
  /// An informational dialog.
  info,
  /// A dialog indicating the game is over.
  over,
  /// A dialog for pausing the game.
  pause,
  /// A dialog to confirm exiting the game.
  exit,
  /// A dialog for showing a hint.
  hint,
}

/// A utility class containing constants and helper methods for the application.
///
/// This class holds route names, theme colors, dashboard configurations, and
/// game-specific parameters like time limits, scores, and coin rewards.
class KeyUtil {
  /// A private constructor to prevent instantiation of this utility class.
  KeyUtil._();

  /// The key for storing the dark mode preference.
  static const IS_DARK_MODE = "isDarkMode";

  // region Route Names
  /// Route name for the Splash screen.
  static const String splash = 'Splash';
  /// Route name for the Dashboard screen.
  static const String dashboard = 'Dashboard';
  /// Route name for the Login screen.
  static const String login = 'Login';
  /// Route name for the Signup screen.
  static const String signup = 'Signup';
  /// Route name for the Home screen.
  static const String home = 'Home';
  /// Route name for the Level selection screen.
  static const String level = 'Level';
  /// Route name for the Dual game mode screen.
  static const String dual = 'Dual';
  /// Route name for the Calculator game.
  static const String calculator = 'Calculator';
  /// Route name for the Guess the Sign game.
  static const String guessSign = 'GuessSign';
  /// Route name for the True or False game.
  static const String trueFalse = 'TrueFalse';
  /// Route name for the Dual Game screen.
  static const String dualGame = 'dualGame';
  /// Route name for the Complex Calculation game.
  static const String complexCalculation = 'complexCalculation';
  /// Route name for the Correct Answer game.
  static const String correctAnswer = 'CorrectAnswer';
  /// Route name for the Quick Calculation game.
  static const String quickCalculation = 'QuickCalculation';
  /// Route name for the Find the Missing Number game.
  static const String findMissing = 'FindMissing';
  /// Route name for the Mental Arithmetic game.
  static const String mentalArithmetic = 'MentalArithmetic';
  /// Route name for the Square Root game.
  static const String squareRoot = 'SquareRoot';
  /// Route name for the Math Pairs game.
  static const String mathPairs = 'MathPairs';
  /// Route name for the Concentration game.
  static const String concentration = 'concentration';
  /// Route name for the Cube Root game.
  static const String cubeRoot = 'cubeRoot';
  /// Route name for the Magic Triangle game.
  static const String magicTriangle = 'MagicTriangle';
  /// Route name for the Picture Puzzle game.
  static const String picturePuzzle = 'PicturePuzzle';
  /// Route name for the Math Grid game.
  static const String mathGrid = 'MathGrid';
  /// Route name for the Number Pyramid game.
  static const String numberPyramid = "NumberPyramid";
  /// Route name for the Numeric Memory game.
  static const String numericMemory = "numericMemory";
  // endregion

  // region Theme Colors and Folders
  /// Primary color for the yellow theme.
  static Color primaryColor1 = "#FFCB43".toColor();
  /// Background color for the yellow theme.
  static Color bgColor1 = "#FFF2D5".toColor();
  /// Secondary background color for the yellow theme.
  static Color backgroundColor1 = "#FFDB7C".toColor();
  /// Secondary background color for the green theme.
  static Color backgroundColor2 = "#C2ECA3".toColor();
  /// Secondary background color for the blue theme.
  static Color backgroundColor3 = "#E3D9FF".toColor();
  /// Primary color for the green theme.
  static Color primaryColor2 = "#AAE37B".toColor();
  /// Background color for the green theme.
  static Color bgColor2 = "#EAF9DF".toColor();
  /// Primary color for the blue theme.
  static Color primaryColor3 = "#C3AEFF".toColor();
  /// Background color for the blue theme.
  static Color bgColor3 = "#EFEBFE".toColor();
  /// A transparent black color for overlays.
  static Color blackTransparentColor = "#BF000000".toColor();
  /// Asset folder for the yellow theme.
  static String themeYellowFolder = 'imgYellow/';
  /// Asset folder for the green theme.
  static String themeOrangeFolder = 'imgGreen/';
  /// Asset folder for the blue theme.
  static String themeBlueFolder = 'imgBlue/';
  // endregion

  /// A list of dashboard items defining the main menu structure of the app.
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

  /// A list of background colors corresponding to the dashboard items.
  static List<Color> bgColorList = [
    bgColor1,
    bgColor2,
    bgColor3,
  ];

  /// Returns the time limit in seconds for a specific game category.
  ///
  /// The [gameCategoryType] parameter specifies the game for which to retrieve the time limit.
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

  /// Returns the score awarded for a correct answer in a specific game category.
  ///
  /// The [gameCategoryType] parameter specifies the game for which to retrieve the score.
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

  /// Returns the penalty for an incorrect answer in a specific game category.
  ///
  /// The [gameCategoryType] parameter specifies the game for which to retrieve the penalty.
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

  /// Returns the number of coins awarded for completing a game in a specific category.
  ///
  /// The [gameCategoryType] parameter specifies the game for which to retrieve the coin reward.
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
  // region Time Constants
  /// Time limit in seconds for the Calculator game.
  static int calculatorTimeOut = 20;
  /// Time limit in seconds for the Guess the Sign game.
  static int guessSignTimeOut = 20;
  /// Time limit in seconds for the Correct Answer game.
  static int correctAnswerTimeOut = 20;
  /// Time limit in seconds for the Quick Calculation game.
  static int quickCalculationTimeOut = 20;
  /// Time added for each correct answer in Quick Calculation.
  static int quickCalculationPlusTime = 1;
  /// Time limit in seconds for the Find the Missing Number game.
  static int findMissingTimeOut = 20;
  /// Time added for each correct answer in Find the Missing Number.
  static int findMissingTime = 1;
  /// Time limit in seconds for the True or False game.
  static int trueFalseTimeOut = 20;
  /// Time added for each correct answer in True or False.
  static int trueFalseTime = 1;
  /// Time limit in seconds for the Numeric Memory game.
  static int numericMemoryTimeOut = 5;
  /// Time added for each correct answer in Numeric Memory.
  static int numericMemoryTime = 1;
  /// Time limit in seconds for the Complex Calculation game.
  static int complexCalculationTimeOut = 20;
  /// Time added for each correct answer in Complex Calculation.
  static int complexCalculationTime = 1;
  /// Time limit in seconds for the Dual Game mode.
  static int dualTimeOut = 20;
  /// Time added for each correct answer in Dual Game.
  static int dualTime = 1;
  /// Time limit in seconds for the Mental Arithmetic game.
  static int mentalArithmeticTimeOut = 60;
  /// Local timeout for individual questions in Mental Arithmetic.
  static int mentalArithmeticLocalTimeOut = 4;
  /// Time limit in seconds for the Square Root game.
  static int squareRootTimeOut = 15;
  /// Time limit in seconds for the Cube Root game.
  static int cubeRootTimeOut = 15;
  /// Time limit in seconds for the Math Grid game.
  static int mathGridTimeOut = 120;
  /// Time limit in seconds for the Math Pairs game.
  static int mathematicalPairsTimeOut = 60;
  /// Time limit in seconds for the Concentration game.
  static int concentrationTimeOut = 15;
  /// Time limit in seconds for the Magic Triangle game.
  static int magicTriangleTimeOut = 60;
  /// Time limit in seconds for the Picture Puzzle game.
  static int picturePuzzleTimeOut = 90;
  /// Time limit in seconds for the Number Pyramid game.
  static int numPyramidTimeOut = 120;
  // endregion

  // region Score Constants
  /// Points awarded for a correct answer in the Calculator game.
  static double calculatorScore = 1;
  /// Penalty for a wrong answer in the Calculator game.
  static double calculatorScoreMinus = -1;
  /// Points awarded for a correct answer in the Complex Calculation game.
  static double complexCalculationScore = 1;
  /// Penalty for a wrong answer in the Complex Calculation game.
  static double complexCalculationScoreMinus = -1;
  /// Points awarded for a correct answer in the Numeric Memory game.
  static double numericMemoryScore = 1;
  /// Penalty for a wrong answer in the Numeric Memory game.
  static double numericMemoryScoreMinus = -1;
  /// Points awarded for a correct answer in the Guess the Sign game.
  static double guessSignScore = 1;
  /// Penalty for a wrong answer in the Guess the Sign game.
  static double guessSignScoreMinus = -1;
  /// Points awarded for a correct answer in the Correct Answer game.
  static double correctAnswerScore = 1;
  /// Penalty for a wrong answer in the Correct Answer game.
  static double correctAnswerScoreMinus = -1;
  /// Points awarded for a correct answer in the Find the Missing Number game.
  static double findMissingScore = 1;
  /// Penalty for a wrong answer in the Find the Missing Number game.
  static double findMissingScoreMinus = -1;
  /// Points awarded for a correct answer in the Dual Game mode.
  static double dualScore = 1;
  /// Penalty for a wrong answer in the Dual Game mode.
  static double dualScoreMinus = -1;
  /// Points awarded for a correct answer in the True or False game.
  static double trueFalseScore = 1;
  /// Penalty for a wrong answer in the True or False game.
  static double trueFalseScoreMinus = -1;
  /// Points awarded for a correct answer in the Quick Calculation game.
  static double quickCalculationScore = 1;
  /// Penalty for a wrong answer in the Quick Calculation game.
  static double quickCalculationScoreMinus = -1;
  /// Points awarded for a correct answer in the Mental Arithmetic game.
  static double mentalArithmeticScore = 2;
  /// Penalty for a wrong answer in the Mental Arithmetic game.
  static double mentalArithmeticScoreMinus = -1;
  /// Points awarded for a correct answer in the Square Root game.
  static double squareRootScore = 1;
  /// Penalty for a wrong answer in the Square Root game.
  static double squareRootScoreMinus = -1;
  /// Points awarded for a correct answer in the Cube Root game.
  static double cubeRootScore = 1;
  /// Penalty for a wrong answer in the Cube Root game.
  static double cubeRootScoreMinus = -1;
  /// Points awarded for a correct answer in the Math Pairs game.
  static double mathematicalPairsScore = 5;
  /// Penalty for a wrong answer in the Math Pairs game.
  static double mathematicalPairsScoreMinus = -5;
  /// Points awarded for a correct answer in the Math Grid game.
  static double mathGridScore = 5;
  /// Penalty for a wrong answer in the Math Grid game.
  static double mathGridScoreMinus = 0;
  /// Points awarded for a correct answer in the Concentration game.
  static double concentrationScore = 5;
  /// Penalty for a wrong answer in the Concentration game.
  static double concentrationScoreMinus = 0;
  /// Points awarded for a correct answer in the Magic Triangle game.
  static double magicTriangleScore = 5;
  /// Penalty for a wrong answer in the Magic Triangle game.
  static double magicTriangleScoreMinus = 0;
  /// Points awarded for a correct answer in the Picture Puzzle game.
  static double picturePuzzleScore = 2;
  /// Penalty for a wrong answer in the Picture Puzzle game.
  static double picturePuzzleScoreMinus = -1;
  /// Points awarded for a correct answer in the Number Pyramid game.
  static double numberPyramidScore = 5;
  /// Penalty for a wrong answer in the Number Pyramid game.
  static double numberPyramidScoreMinus = 0;
  // endregion

  // region Coin Reward Constants
  /// Coins awarded for completing the Calculator game.
  static double calculatorCoin = 0.5;
  /// Coins awarded for completing the Guess the Sign game.
  static double guessSignCoin = 0.5;
  /// Coins awarded for completing the Correct Answer game.
  static double correctAnswerCoin = 0.5;
  /// Coins awarded for completing the Quick Calculation game.
  static double quickCalculationCoin = 0.5;
  /// Coins awarded for completing the Mental Arithmetic game.
  static double mentalArithmeticCoin = 1;
  /// Coins awarded for completing the Square Root game.
  static double squareRootCoin = 0.5;
  /// Coins awarded for completing the Cube Root game.
  static double cubeRootCoin = 0.5;
  /// Coins awarded for completing the Math Grid game.
  static double mathGridCoin = 3;
  /// Coins awarded for completing the Math Pairs game.
  static double mathematicalPairsCoin = 1;
  /// Coins awarded for completing the Concentration game.
  static double concentrationCoin = 1;
  /// Coins awarded for completing the Magic Triangle game.
  static double magicTriangleCoin = 3;
  /// Coins awarded for completing the Picture Puzzle game.
  static double picturePuzzleCoin = 1;
  /// Coins awarded for completing the Number Pyramid game.
  static double numberPyramidCoin = 3;
  /// Coins awarded for completing the Find the Missing Number game.
  static double findMissingCoin = 1;
  /// Coins awarded for completing the True or False game.
  static double truFalseCoin = 1;
  /// Coins awarded for completing the Dual Game mode.
  static double dualGameCoin = 1;
  /// Coins awarded for completing the Complex Calculation game.
  static double complexCalculationCoin = 1;
  /// Coins awarded for completing the Numeric Memory game.
  static double numericMemoryCoin = 1;
  // endregion

  // User Report and Analytics Constants

}

/// An extension on the [String] class to provide a method for converting a hex color string to a [Color] object.
extension ColorExtension on String {
  /// Converts a hex color string to a [Color] object.
  ///
  /// The hex string can be in the format of "RRGGBB" or "AARRGGBB".
  /// If the format is "RRGGBB", an alpha value of "FF" (fully opaque) is prepended.
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

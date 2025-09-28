import 'dart:ui';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:tuple/tuple.dart';

/// Utility class providing dialog information for various math game categories.
class DialogInfoUtil {
  // --- Common reusable descriptions ---
  static const String genericEquationDesc =
      "Select the correct number to finish the equation.";
  static const String signEquationDesc =
      "You need to find correct sign that finishes the given equation.";
  static const String calculatorDesc =
      "You need to solve given equation correctly.";
  static const String magicTriangleDesc =
      "Sum of the each side of triangle should be equal to the given number. "
      "To place any number, select triangle circle and press any given number from panel.";
  static const String mentalArithmeticDesc =
      "Number with operator will be shown one by one. "
      "You need to remember the number with operator and write final answer (No precedence).";
  static const String quickCalcDesc =
      "Solve simple equations one by one. Faster you solve, "
      "more time will be given to solve next equation.";
  static const String mathGridDesc =
      "Select number from math grid to reach answer shown above.";
  static const String picturePuzzleDesc =
      "Each shape represents a number. Find the number of each shape "
      "from given equations and solve the last equation.";
  static const String pyramidDesc =
      "Sum of consecutive cell should be placed on top cell. "
      "You need to fill all cells correctly to solve the Number Pyramid.";

  // --- Default color scheme mapping ---
  static final Map<GameCategoryType, Tuple2<Color, Color>> colorMap = {
    GameCategoryType.CALCULATOR: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.GUESS_SIGN: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.SQUARE_ROOT: Tuple2(
        KeyUtil.primaryColor2, KeyUtil.bgColor2),
    GameCategoryType.FIND_MISSING: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.TRUE_FALSE: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.DUAL_GAME: Tuple2(KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.COMPLEX_CALCULATION: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.CUBE_ROOT: Tuple2(KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.NUMERIC_MEMORY: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.CONCENTRATION: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.MATH_PAIRS: Tuple2(
        KeyUtil.primaryColor2, KeyUtil.bgColor2),
    GameCategoryType.CORRECT_ANSWER: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.MAGIC_TRIANGLE: Tuple2(
        KeyUtil.primaryColor3, KeyUtil.bgColor3),
    GameCategoryType.MENTAL_ARITHMETIC: Tuple2(
        KeyUtil.primaryColor2, KeyUtil.bgColor2),
    GameCategoryType.QUICK_CALCULATION: Tuple2(
        KeyUtil.primaryColor1, KeyUtil.bgColor1),
    GameCategoryType.MATH_GRID: Tuple2(KeyUtil.primaryColor2, KeyUtil.bgColor2),
    GameCategoryType.PICTURE_PUZZLE: Tuple2(
        KeyUtil.primaryColor3, KeyUtil.bgColor3),
    GameCategoryType.NUMBER_PYRAMID: Tuple2(
        KeyUtil.primaryColor3, KeyUtil.bgColor3),
  };

  /// Generates dialog information for a specific game category.
  static GameInfoDialog getInfoDialogData(GameCategoryType type) {
    switch (type) {
      case GameCategoryType.CALCULATOR:
        return _dialog(
          type,
          "Calculator",
          "assets/gif/calculator-intro.gif",
          calculatorDesc,
          KeyUtil.calculatorScore,
          KeyUtil.calculatorScoreMinus,
        );

      case GameCategoryType.GUESS_SIGN:
        return _dialog(
          type,
          "Guess The Sign",
          "assets/gif/whats-the-sign-intro.gif",
          signEquationDesc,
          KeyUtil.guessSignScore,
          KeyUtil.guessSignScoreMinus,
        );

      case GameCategoryType.SQUARE_ROOT:
        return _dialog(
          type,
          "Square Root",
          "assets/gif/sqroot-intro.gif",
          "Square root the given number.",
          KeyUtil.squareRootScore,
          KeyUtil.squareRootScoreMinus,
        );

      case GameCategoryType.FIND_MISSING:
        return _dialog(
          type,
          "Find Missing",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.findMissingScore,
          KeyUtil.findMissingScoreMinus,
        );

      case GameCategoryType.TRUE_FALSE:
        return _dialog(
          type,
          "True False",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.trueFalseScore,
          KeyUtil.trueFalseScoreMinus,
        );

      case GameCategoryType.DUAL_GAME:
        return _dialog(
          type,
          "Dual Game",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.dualScore,
          KeyUtil.dualScoreMinus,
        );

      case GameCategoryType.COMPLEX_CALCULATION:
        return _dialog(
          type,
          "Complex Calculation",
          "assets/gif/whats-the-sign-intro.gif",
          signEquationDesc,
          KeyUtil.complexCalculationScore,
          KeyUtil.complexCalculationScoreMinus,
        );

      case GameCategoryType.CUBE_ROOT:
        return _dialog(
          type,
          "Cube Root",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.cubeRootScore,
          KeyUtil.cubeRootScoreMinus,
        );

      case GameCategoryType.NUMERIC_MEMORY:
        return _dialog(
          type,
          "Numeric Memory",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.numericMemoryScore,
          KeyUtil.numericMemoryScoreMinus,
        );

      case GameCategoryType.CONCENTRATION:
        return _dialog(
          type,
          "Concentration",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.concentrationScore,
          KeyUtil.concentrationScoreMinus,
        );

      case GameCategoryType.MATH_PAIRS:
        return _dialog(
          type,
          "Math Pairs",
          "assets/gif/math-pair-intro.gif",
          "Each card contains either equation or an answer. "
              "Match the equation with correct answer.",
          KeyUtil.mathematicalPairsScore,
          KeyUtil.mathematicalPairsScoreMinus,
        );

      case GameCategoryType.CORRECT_ANSWER:
        return _dialog(
          type,
          "Correct Answer",
          "assets/gif/correct-answer.gif",
          genericEquationDesc,
          KeyUtil.correctAnswerScore,
          KeyUtil.correctAnswerScoreMinus,
        );

      case GameCategoryType.MAGIC_TRIANGLE:
        return _dialog(
          type,
          "Magic Triangle",
          "assets/gif/magic-triangle-intro.gif",
          magicTriangleDesc,
          KeyUtil.magicTriangleScore,
          KeyUtil.magicTriangleScore,
        );

      case GameCategoryType.MENTAL_ARITHMETIC:
        return _dialog(
          type,
          "Mental Arithmetic",
          "assets/gif/mental-arith-intro.gif",
          mentalArithmeticDesc,
          KeyUtil.mentalArithmeticScore,
          KeyUtil.mentalArithmeticScoreMinus,
        );

      case GameCategoryType.QUICK_CALCULATION:
        return _dialog(
          type,
          "Quick Calculation",
          "assets/gif/quick-calculation-intro.gif",
          quickCalcDesc,
          KeyUtil.quickCalculationScore,
          KeyUtil.quickCalculationScoreMinus,
        );

      case GameCategoryType.MATH_GRID:
        return _dialog(
          type,
          "Math Grid",
          "assets/gif/math-machine-intro.gif",
          mathGridDesc,
          KeyUtil.mathGridScore,
          KeyUtil.mathGridScore,
        );

      case GameCategoryType.PICTURE_PUZZLE:
        return _dialog(
          type,
          "Picture Puzzle",
          "assets/gif/picture-puzzle-intro.gif",
          picturePuzzleDesc,
          KeyUtil.picturePuzzleScore,
          KeyUtil.picturePuzzleScore,
        );

      case GameCategoryType.NUMBER_PYRAMID:
        return _dialog(
          type,
          "Number Pyramid",
          "assets/gif/num-pyramid.gif",
          pyramidDesc,
          KeyUtil.numberPyramidScore,
          KeyUtil.numberPyramidScore,
        );
    }
  }

  /// Internal helper to reduce duplication.
  static GameInfoDialog _dialog(GameCategoryType type,
      String title,
      String image,
      String dec,
      double correct, // ✅ changed from int → double
      double wrong, // ✅ changed from int → double
      ) {
    return GameInfoDialog(
      title: title,
      image: image,
      dec: dec,
      correctAnswerScore: correct,
      wrongAnswerScore: wrong,
      primaryColor: colorMap[type]!.item1,
      backgroundColor: colorMap[type]!.item2,
    );
  }
}

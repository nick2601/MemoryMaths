/// Utility class providing dialog information for various math game categories.
/// Contains methods to generate game-specific dialog information including
/// titles, descriptions, scoring rules, and visual assets.
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:tuple/tuple.dart';

class DialogInfoUtil {
  /// Generates dialog information for a specific game category.
  ///
  /// Returns a [GameInfoDialog] containing the game's:
  /// * Title
  /// * Description
  /// * Scoring rules
  /// * Visual assets
  /// * Theme colors
  static GameInfoDialog getInfoDialogData(GameCategoryType gameCategoryType) {
    // Theme color combinations for different game types
    var tuple1 = Tuple2(KeyUtil.primaryColor1, KeyUtil.bgColor1);
    var tuple2 = Tuple2(KeyUtil.primaryColor2, KeyUtil.bgColor2);
    var tuple3 = Tuple2(KeyUtil.primaryColor3, KeyUtil.bgColor3);
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        // Basic calculator game where players solve mathematical equations
        return GameInfoDialog(
            title: "Calculator",
            image: "assets/gif/calculator-intro.gif",
            dec: "You need to solve given equation correctly.",
            correctAnswerScore: KeyUtil.calculatorScore,
            wrongAnswerScore: KeyUtil.calculatorScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.GUESS_SIGN:
        // Players must identify the correct mathematical operator
        return GameInfoDialog(
            title: "Guess The Sign",
            image: "assets/gif/whats-the-sign-intro.gif",
            dec:
                "You need to find correct sign that finishes the given equation.",
            correctAnswerScore: KeyUtil.guessSignScore,
            wrongAnswerScore: KeyUtil.guessSignScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.SQUARE_ROOT:
        // Calculate the square root of given numbers
        return GameInfoDialog(
            title: "Square Root",
            image: "assets/gif/sqroot-intro.gif",
            dec: "square root the given number.",
            correctAnswerScore: KeyUtil.squareRootScore,
            wrongAnswerScore: KeyUtil.squareRootScoreMinus,
            colorTuple: tuple2);

      case GameCategoryType.FIND_MISSING:
        // Find the missing number in mathematical equations
        return GameInfoDialog(
            title: "Find Missing",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.findMissingScore,
            wrongAnswerScore: KeyUtil.findMissingScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.TRUE_FALSE:
        // Answer true or false to mathematical statements
        return GameInfoDialog(
            title: "True False",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.trueFalseScore,
            wrongAnswerScore: KeyUtil.trueFalseScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.DUAL_GAME:
        // Dual game mode with two mathematical operations
        return GameInfoDialog(
            title: "Dual Game",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.dualScore,
            wrongAnswerScore: KeyUtil.dualScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.COMPLEX_CALCULATION:
        // Complex mathematical calculations with multiple operations
        return GameInfoDialog(
            title: "Complex Calculation",
            image: "assets/gif/whats-the-sign-intro.gif",
            dec:
                "You need to find correct sign that finishes the given equation.",
            correctAnswerScore: KeyUtil.complexCalculationScore,
            wrongAnswerScore: KeyUtil.complexCalculationScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.CUBE_ROOT:
        // Calculate the cube root of given numbers
        return GameInfoDialog(
            title: "Cube Root",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.cubeRootScore,
            wrongAnswerScore: KeyUtil.cubeRootScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.NUMERIC_MEMORY:
        // Memory game with numerical sequences
        return GameInfoDialog(
            title: "Numeric Memory",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.numericMemoryScore,
            wrongAnswerScore: KeyUtil.numericMemoryScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.CONCENTRATION:
        // Concentration game with mathematical patterns
        return GameInfoDialog(
            title: "Concentration",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.concentrationScore,
            wrongAnswerScore: KeyUtil.concentrationScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.MATH_PAIRS:
        // Match mathematical equations with their solutions
        return GameInfoDialog(
            title: "Math Pairs",
            image: "assets/gif/math-pair-intro.gif",
            dec:
                "Each card contains either equation or an answer. Match the equation with correct answer.",
            correctAnswerScore: KeyUtil.mathematicalPairsScore,
            wrongAnswerScore: KeyUtil.mathematicalPairsScoreMinus,
            colorTuple: tuple2);
      case GameCategoryType.CORRECT_ANSWER:
        // Select the correct answer from multiple options
        return GameInfoDialog(
            title: "Correct Answer",
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.",
            correctAnswerScore: KeyUtil.correctAnswerScore,
            wrongAnswerScore: KeyUtil.correctAnswerScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.MAGIC_TRIANGLE:
        // Solve the magic triangle puzzle
        return GameInfoDialog(
          title: "Magic Triangle",
          image: "assets/gif/magic-triangle-intro.gif",
          dec:
              "Sum of the each side of triangle should be equal to the given number. To place any number, select triangle circle and press any given number from panel.",
          correctAnswerScore: KeyUtil.magicTriangleScore,
          colorTuple: tuple3,
          wrongAnswerScore: KeyUtil.magicTriangleScore,
        );
      case GameCategoryType.MENTAL_ARITHMETIC:
        // Mental arithmetic game with mathematical operations
        return GameInfoDialog(
          title: "Mental Arithmetic",
          colorTuple: tuple2,
          image: "assets/gif/mental-arith-intro.gif",
          dec:
              "Number with operator will be shown one by one. You need to remember the number with operator and write final answer(No precedency).",
          correctAnswerScore: KeyUtil.mentalArithmeticScore,
          wrongAnswerScore: KeyUtil.mentalArithmeticScoreMinus,
        );
      case GameCategoryType.QUICK_CALCULATION:
        // Quick calculation game with time limits
        return GameInfoDialog(
          title: "Quick Calculation",
          colorTuple: tuple1,
          image: "assets/gif/quick-calculation-intro.gif",
          dec:
              "Solve simple equation one by one. Faster you solve, more time will be given to solve next equation.",
          correctAnswerScore: KeyUtil.quickCalculationScore,
          wrongAnswerScore: KeyUtil.quickCalculationScoreMinus,
        );
      case GameCategoryType.MATH_GRID:
        // Grid-based math puzzle where players select numbers to reach a target sum
        return GameInfoDialog(
          title: "Math Grid",
          colorTuple: tuple2,
          image: "assets/gif/math-machine-intro.gif",
          dec:
              "Select number from math grid to reach answer shown above. You can select any number to reach above answer.",
          correctAnswerScore: KeyUtil.mathGridScore,
          wrongAnswerScore: KeyUtil.mathGridScore,
        );
      case GameCategoryType.PICTURE_PUZZLE:
        // Visual math puzzles using shapes to represent numbers
        return GameInfoDialog(
          title: "Picture Puzzle",
          colorTuple: tuple3,
          image: "assets/gif/picture-puzzle-intro.gif",
          dec:
              "Each shape represents a number. Find the number of each shape from given equation and solve the last equation.",
          correctAnswerScore: KeyUtil.picturePuzzleScore,
          wrongAnswerScore: KeyUtil.picturePuzzleScore,
        );
      case GameCategoryType.NUMBER_PYRAMID:
        // Pyramid puzzle where each cell is the sum of the two cells below it
        return GameInfoDialog(
          title: "Number Pyramid",
          colorTuple: tuple3,
          image: "assets/gif/num-pyramid.gif",
          dec:
              "sum of consecutive cell should be placed on top cell. You need to fill all cell correctly to solve Number pyramid.",
          correctAnswerScore: KeyUtil.numberPyramidScore,
          wrongAnswerScore: KeyUtil.numberPyramidScore,
        );
    }
  }
}

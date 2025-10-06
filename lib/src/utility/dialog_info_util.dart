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
        return GameInfoDialog(
            title: "Number Ninja",
            image: "assets/gif/calculator-intro.gif",
            dec: "🔢 HOW TO PLAY:\n"
                "• Solve mathematical equations using +, -, ×, ÷\n"
                "• Enter your answer using the number pad\n"
                "• Work quickly - you're timed!\n\n"
                "🎯 OBJECTIVE: Calculate correct answers to earn points\n\n"
                "⚡ TIP: Use the hint button if you get stuck!",
            correctAnswerScore: KeyUtil.calculatorScore,
            wrongAnswerScore: KeyUtil.calculatorScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.GUESS_SIGN:
        return GameInfoDialog(
            title: "Sign Seeker",
            image: "assets/gif/whats-the-sign-intro.gif",
            dec: "❓ HOW TO PLAY:\n"
                "• Look at the equation with a missing operator\n"
                "• Choose the correct sign: +, -, ×, or ÷\n"
                "• Make the equation mathematically correct\n\n"
                "🎯 OBJECTIVE: Find the missing mathematical operator\n\n"
                "💡 EXAMPLE: 8 ? 4 = 12 → Answer: +",
            correctAnswerScore: KeyUtil.guessSignScore,
            wrongAnswerScore: KeyUtil.guessSignScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.SQUARE_ROOT:
        return GameInfoDialog(
            title: "Root Ranger",
            image: "assets/gif/sqroot-intro.gif",
            dec: "√ HOW TO PLAY:\n"
                "• Find the square root of the given number\n"
                "• Enter your answer using the number pad\n"
                "• Remember: √16 = 4, √25 = 5, etc.\n\n"
                "🎯 OBJECTIVE: Calculate square roots correctly\n\n"
                "📚 TIP: Perfect squares get easier with practice!",
            correctAnswerScore: KeyUtil.squareRootScore,
            wrongAnswerScore: KeyUtil.squareRootScoreMinus,
            colorTuple: tuple2);

      case GameCategoryType.FIND_MISSING:
        return GameInfoDialog(
            title: "Missing Link",
            image: "assets/gif/correct-answer.gif",
            dec: "🔍 HOW TO PLAY:\n"
                "• Look at equations with missing numbers\n"
                "• Select the correct number from options\n"
                "• Complete the equation to make it true\n\n"
                "🎯 OBJECTIVE: Find missing numbers in equations\n\n"
                "💡 EXAMPLE: 5 + ? = 12 → Answer: 7",
            correctAnswerScore: KeyUtil.findMissingScore,
            wrongAnswerScore: KeyUtil.findMissingScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.TRUE_FALSE:
        return GameInfoDialog(
            title: "Math Truths",
            image: "assets/gif/correct-answer.gif",
            dec: "✅❌ HOW TO PLAY:\n"
                "• Read mathematical statements carefully\n"
                "• Decide if the equation is TRUE or FALSE\n"
                "• Tap your answer quickly - time matters!\n\n"
                "🎯 OBJECTIVE: Identify correct and incorrect equations\n\n"
                "💡 EXAMPLE: 6 × 3 = 18 → TRUE",
            correctAnswerScore: KeyUtil.trueFalseScore,
            wrongAnswerScore: KeyUtil.trueFalseScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.DUAL_GAME:
        return GameInfoDialog(
            title: "Math Duel",
            image: "assets/gif/correct-answer.gif",
            dec: "👥 HOW TO PLAY:\n"
                "• Two mathematical challenges appear simultaneously\n"
                "• Solve both problems as quickly as possible\n"
                "• Each player gets separate scoring\n\n"
                "🎯 OBJECTIVE: Outperform your opponent in math speed\n\n"
                "🏆 STRATEGY: Balance speed with accuracy!",
            correctAnswerScore: KeyUtil.dualScore,
            wrongAnswerScore: KeyUtil.dualScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.COMPLEX_CALCULATION:
        return GameInfoDialog(
            title: "Operation Overload",
            image: "assets/gif/whats-the-sign-intro.gif",
            dec: "🧮 HOW TO PLAY:\n"
                "• Solve multi-step mathematical expressions\n"
                "• Follow order of operations (PEMDAS/BODMAS)\n"
                "• Choose the correct answer from options\n\n"
                "🎯 OBJECTIVE: Master complex mathematical calculations\n\n"
                "📖 EXAMPLE: 2 × (5 + 3) - 4 = ?",
            correctAnswerScore: KeyUtil.complexCalculationScore,
            wrongAnswerScore: KeyUtil.complexCalculationScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.CUBE_ROOT:
        return GameInfoDialog(
            title: "Cube Quest",
            image: "assets/gif/correct-answer.gif",
            dec: "∛ HOW TO PLAY:\n"
                "• Find the cube root of the given number\n"
                "• Select your answer from the options\n"
                "• Remember: ∛8 = 2, ∛27 = 3, etc.\n\n"
                "🎯 OBJECTIVE: Calculate cube roots accurately\n\n"
                "🧠 TIP: Think 'what number × itself × itself = this?'",
            correctAnswerScore: KeyUtil.cubeRootScore,
            wrongAnswerScore: KeyUtil.cubeRootScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.NUMERIC_MEMORY:
        return GameInfoDialog(
            title: "Number Recall",
            image: "assets/gif/correct-answer.gif",
            dec: "🧠 HOW TO PLAY:\n"
                "• Watch the sequence of numbers appear\n"
                "• Memorize the exact order and values\n"
                "• Select the highlighted number from the grid\n"
                "• No time limit - take your time to remember!\n\n"
                "🎯 OBJECTIVE: Test and improve your numerical memory\n\n"
                "💡 TIP: Create mental patterns to remember sequences",
            correctAnswerScore: KeyUtil.numericMemoryScore,
            wrongAnswerScore: KeyUtil.numericMemoryScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.CONCENTRATION:
        return GameInfoDialog(
            title: "Memory Match",
            image: "assets/gif/correct-answer.gif",
            dec: "🃏 HOW TO PLAY:\n"
                "• Flip cards to reveal math expressions and answers\n"
                "• Match equations with their correct solutions\n"
                "• Remember card positions - no time pressure!\n"
                "• Find all pairs to complete the level\n\n"
                "🎯 OBJECTIVE: Match all equation-answer pairs\n\n"
                "🧠 STRATEGY: Focus on remembering card locations",
            correctAnswerScore: KeyUtil.concentrationScore,
            wrongAnswerScore: KeyUtil.concentrationScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.MATH_PAIRS:
        return GameInfoDialog(
            title: "Equation Match",
            image: "assets/gif/math-pair-intro.gif",
            dec: "🔗 HOW TO PLAY:\n"
                "• Cards show either equations OR answers\n"
                "• Find and match equations with correct answers\n"
                "• Tap two cards to check if they're a pair\n"
                "• Complete all matches to win the level\n\n"
                "🎯 OBJECTIVE: Match all equation-answer pairs\n\n"
                "💡 EXAMPLE: Match '6 × 4' with '24'",
            correctAnswerScore: KeyUtil.mathematicalPairsScore,
            wrongAnswerScore: KeyUtil.mathematicalPairsScoreMinus,
            colorTuple: tuple2);

      case GameCategoryType.CORRECT_ANSWER:
        return GameInfoDialog(
            title: "Answer Ace",
            image: "assets/gif/correct-answer.gif",
            dec: "🎯 HOW TO PLAY:\n"
                "• Read the mathematical question carefully\n"
                "• Choose the correct answer from multiple options\n"
                "• Work quickly but accurately for bonus points\n\n"
                "🎯 OBJECTIVE: Select correct answers from given choices\n\n"
                "⚡ TIP: Eliminate obviously wrong answers first!",
            correctAnswerScore: KeyUtil.correctAnswerScore,
            wrongAnswerScore: KeyUtil.correctAnswerScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.MAGIC_TRIANGLE:
        return GameInfoDialog(
          title: "Triangle Magic",
          image: "assets/gif/magic-triangle-intro.gif",
          dec: "🔺 HOW TO PLAY:\n"
              "• Place numbers so each side adds up to the target sum\n"
              "• Tap a circle, then tap a number to place it\n"
              "• All three sides must equal the magic number\n"
              "• Use each given number only once\n\n"
              "🎯 OBJECTIVE: Create a perfect magic triangle\n\n"
              "🧠 STRATEGY: Start with corner numbers, they count twice!",
          correctAnswerScore: KeyUtil.magicTriangleScore,
          colorTuple: tuple3,
          wrongAnswerScore: KeyUtil.magicTriangleScore,
        );

      case GameCategoryType.MENTAL_ARITHMETIC:
        return GameInfoDialog(
          title: "Mind Math",
          colorTuple: tuple2,
          image: "assets/gif/mental-arith-intro.gif",
          dec: "🧮 HOW TO PLAY:\n"
              "• Watch numbers and operators appear one by one\n"
              "• Remember the complete sequence in your mind\n"
              "• Calculate from left to right (no operator precedence)\n"
              "• Enter the final answer after animation ends\n\n"
              "🎯 OBJECTIVE: Perform mental calculations from memory\n\n"
              "💡 EXAMPLE: 5 + 3 × 2 = 16 (not 11!)",
          correctAnswerScore: KeyUtil.mentalArithmeticScore,
          wrongAnswerScore: KeyUtil.mentalArithmeticScoreMinus,
        );

      case GameCategoryType.QUICK_CALCULATION:
        return GameInfoDialog(
          title: "Flash Math",
          colorTuple: tuple1,
          image: "assets/gif/quick-calculation-intro.gif",
          dec: "⚡ HOW TO PLAY:\n"
              "• Solve equations as fast as possible\n"
              "• Each correct answer gives you more time\n"
              "• Wrong answers cost you precious seconds\n"
              "• Keep the momentum going!\n\n"
              "🎯 OBJECTIVE: Solve as many equations as possible\n\n"
              "🏃 BONUS: Speed matters - faster = more time!",
          correctAnswerScore: KeyUtil.quickCalculationScore,
          wrongAnswerScore: KeyUtil.quickCalculationScoreMinus,
        );

      case GameCategoryType.MATH_GRID:
        return GameInfoDialog(
          title: "Target Grid",
          colorTuple: tuple2,
          image: "assets/gif/math-machine-intro.gif",
          dec: "🔢 HOW TO PLAY:\n"
              "• See the target number at the top\n"
              "• Select numbers from the grid below\n"
              "• Add/combine them to reach the target\n"
              "• Multiple solutions may be possible\n\n"
              "🎯 OBJECTIVE: Reach target using grid numbers\n\n"
              "💡 TIP: Look for different number combinations!",
          correctAnswerScore: KeyUtil.mathGridScore,
          wrongAnswerScore: KeyUtil.mathGridScore,
        );

      case GameCategoryType.PICTURE_PUZZLE:
        return GameInfoDialog(
          title: "Shape Solver",
          colorTuple: tuple3,
          image: "assets/gif/picture-puzzle-intro.gif",
          dec: "🖼️ HOW TO PLAY:\n"
              "• Each shape represents a different number\n"
              "• Use the given equations to find each shape's value\n"
              "• Apply what you learned to solve the final equation\n"
              "• Think logically step by step\n\n"
              "🎯 OBJECTIVE: Decode shapes to solve the puzzle\n\n"
              "🔍 TIP: Start with the simplest equations first!",
          correctAnswerScore: KeyUtil.picturePuzzleScore,
          wrongAnswerScore: KeyUtil.picturePuzzleScore,
        );

      case GameCategoryType.NUMBER_PYRAMID:
        return GameInfoDialog(
          title: "Pyramid Sum",
          colorTuple: tuple3,
          image: "assets/gif/num-pyramid.gif",
          dec: "🏔️ HOW TO PLAY:\n"
              "• Each cell equals the sum of two cells below it\n"
              "• Fill in missing numbers following this rule\n"
              "• Work from bottom to top, or top to bottom\n"
              "• All numbers must follow the pyramid logic\n\n"
              "🎯 OBJECTIVE: Complete the number pyramid correctly\n\n"
              "🧠 STRATEGY: Use known numbers to calculate unknowns!",
          correctAnswerScore: KeyUtil.numberPyramidScore,
          wrongAnswerScore: KeyUtil.numberPyramidScore,
        );
    }
  }
}

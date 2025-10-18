import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/calculator/calculator_view.dart';
import 'package:mathsgames/src/ui/complexCalculation/complex_calculation_view.dart';
import 'package:mathsgames/src/ui/concentration/concentration_view.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_view.dart';
import 'package:mathsgames/src/ui/cubeRoot/cube_root_view.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import 'package:mathsgames/src/ui/dualGame/dual_view.dart';
import 'package:mathsgames/src/ui/guessTheSign/guess_sign_view.dart';
import 'package:mathsgames/src/ui/home/home_view.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_view.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_view.dart';
import 'package:mathsgames/src/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathsgames/src/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathsgames/src/ui/signup/signup_screen.dart';
import 'package:mathsgames/src/ui/splash/splash_view.dart';
import 'package:mathsgames/src/ui/squareRoot/square_root_view.dart';
import 'package:tuple/tuple.dart';

import '../data/models/game_category.dart';
import '../ui/findMissing/find_missing_view.dart';
import '../ui/level/level_view.dart';
import '../ui/numericMemory/numeric_view.dart';
import '../ui/trueFalseQuiz/true_false_view.dart';

/// A map that defines the application's routes.
///
/// Each route is associated with a `WidgetBuilder` that creates the corresponding
/// screen. The routes are identified by keys from the `KeyUtil` class.
///
/// Arguments are passed to the screens using `ModalRoute.of(context)?.settings.arguments`.
/// This allows for passing complex data structures like `Tuple2` to the destination widgets.
final Map<String, WidgetBuilder> appRoutes = {
  /// Route for the splash screen.
  KeyUtil.splash: (context) => SplashView(),

  /// Route for the main dashboard.
  KeyUtil.dashboard: (context) => DashboardView(),

  /// Route for the login screen.
  KeyUtil.login: (context) => LoginScreen(),

  /// Route for the signup screen.
  KeyUtil.signup: (context) => SignupScreen(),

  /// Route for the home screen, which requires dashboard data.
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),

  /// Route for the level selection screen for a specific game category.
  KeyUtil.level: (context) => LevelView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GameCategory, Dashboard>),

  /// Route for the Calculator game.
  KeyUtil.calculator: (context) => CalculatorView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Guess the Sign game.
  KeyUtil.guessSign: (context) => GuessSignView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the True or False game.
  KeyUtil.trueFalse: (context) => TrueFalseView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Complex Calculation game.
  KeyUtil.complexCalculation: (context) => ComplexCalculationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Find the Missing Number game.
  KeyUtil.findMissing: (context) => FindMissingView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Dual Game mode.
  KeyUtil.dualGame: (context) => DualView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Correct Answer game.
  KeyUtil.correctAnswer: (context) => CorrectAnswerView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Quick Calculation game.
  KeyUtil.quickCalculation: (context) => QuickCalculationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Mental Arithmetic game.
  KeyUtil.mentalArithmetic: (context) => MentalArithmeticView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Square Root game.
  KeyUtil.squareRoot: (context) => SquareRootView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Numeric Memory game.
  KeyUtil.numericMemory: (context) => NumericMemoryView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Cube Root game.
  KeyUtil.cubeRoot: (context) => CubeRootView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Math Pairs game.
  KeyUtil.mathPairs: (context) => MathPairsView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Concentration game.
  KeyUtil.concentration: (context) => ConcentrationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Magic Triangle game.
  KeyUtil.magicTriangle: (context) => MagicTriangleView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Math Grid game.
  KeyUtil.mathGrid: (context) => MathGridView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Picture Puzzle game.
  KeyUtil.picturePuzzle: (context) => PicturePuzzleView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  /// Route for the Number Pyramid game.
  KeyUtil.numberPyramid: (context) => NumberPyramidView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
};

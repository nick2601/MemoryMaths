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
import 'package:mathsgames/src/ui/home/home_view.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_view.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_view.dart';
import 'package:mathsgames/src/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathsgames/src/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathsgames/src/ui/signup/signup_screen.dart';
import 'package:mathsgames/src/ui/splash/splash_view.dart';
import 'package:mathsgames/src/ui/squareRoot/square_root_view.dart';
import 'package:mathsgames/src/ui/guessTheSign/guess_sign_view.dart';
import 'package:tuple/tuple.dart';
import '../data/models/game_category.dart';
import '../ui/findMissing/find_missing_view.dart';
import '../ui/level/level_view.dart';
import '../ui/numericMemory/numeric_view.dart';
import '../ui/trueFalseQuiz/true_false_view.dart';

/// A map of all application routes and their corresponding widget builders.
/// This map is used by the Flutter navigation system to determine which widget
/// to display for each named route.
///
/// Each route takes a BuildContext and returns a Widget, with some routes
/// expecting specific arguments passed through the navigation system.
var appRoutes = {
  // Dashboard screen - Entry point after authentication
  KeyUtil.dashboard: (context) => DashboardView(),

  // Initial splash screen shown when app launches
  KeyUtil.splash: (context) => SplashView(),

  // Authentication screens
  KeyUtil.login: (context) => LoginScreen(),
  KeyUtil.signup: (context) => SignupScreen(),

  // Home screen - Expects Dashboard and animation value as arguments
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),

  // Level selection screen - Expects GameCategory and Dashboard as arguments
  KeyUtil.level: (context) => LevelView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GameCategory, Dashboard>),

  // Game screens - All expect GradientModel (for styling) and level (int) as arguments
  KeyUtil.calculator: (context) => CalculatorView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),

  // ... similar game routes with same pattern ...
  // Each route expects a Tuple2<GradientModel, int> for styling and level information

  KeyUtil.numberPyramid: (context) => NumberPyramidView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
};

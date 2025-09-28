import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/data/models/game_category.dart';
import 'package:mathsgames/src/ui/calculator/calculator_view.dart';
import 'package:mathsgames/src/ui/complexCalculation/complex_calculation_view.dart';
import 'package:mathsgames/src/ui/concentration/concentration_view.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_view.dart';
import 'package:mathsgames/src/ui/cubeRoot/cube_root_view.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import 'package:mathsgames/src/ui/dualGame/dual_view.dart';
import 'package:mathsgames/src/ui/findMissing/find_missing_view.dart';
import 'package:mathsgames/src/ui/home/home_view.dart';
import 'package:mathsgames/src/ui/level/level_view.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_view.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_view.dart';
import 'package:mathsgames/src/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathsgames/src/ui/numericMemory/numeric_view.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathsgames/src/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathsgames/src/ui/signup/signup_screen.dart';
import 'package:mathsgames/src/ui/splash/splash_view.dart';
import 'package:mathsgames/src/ui/squareRoot/square_root_view.dart';
import 'package:mathsgames/src/ui/guessTheSign/guess_sign_view.dart';
import 'package:mathsgames/src/ui/trueFalseQuiz/true_false_view.dart';
import 'package:tuple/tuple.dart';

import 'app_constant.dart';


/// Helper for safe argument extraction
T getRouteArgs<T>(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments;
  if (args is T) return args;
  throw FlutterError("Expected args of type $T but got $args");
}

final Map<String, WidgetBuilder> appRoutes = {
  KeyUtil.splash: (_) => SplashView(),
  KeyUtil.dashboard: (_) => DashboardView(),
  KeyUtil.login: (_) => LoginScreen(),
  KeyUtil.signup: (_) => SignupScreen(),

  KeyUtil.home: (context) => HomeView(
    tuple2: getRouteArgs<Tuple2<Dashboard, double>>(context),
  ),
  KeyUtil.level: (context) => LevelView(
    tuple2: getRouteArgs<Tuple2<GameCategory, Dashboard>>(context),
  ),

  KeyUtil.calculator: (context) => CalculatorView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.guessSign: (context) => GuessSignView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.trueFalse: (context) => TrueFalseView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.complexCalculation: (context) => ComplexCalculationView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.findMissing: (context) => FindMissingView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.dualGame: (context) => DualView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.correctAnswer: (context) => CorrectAnswerView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.quickCalculation: (context) => QuickCalculationView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.mentalArithmetic: (context) => MentalArithmeticView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.squareRoot: (context) => SquareRootView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.numericMemory: (context) => NumericMemoryView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.cubeRoot: (context) => CubeRootView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.mathPairs: (context) => MathPairsView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.concentration: (context) => ConcentrationView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.magicTriangle: (context) => MagicTriangleView(
    colorTuple1: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.mathGrid: (context) => MathGridView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.picturePuzzle: (context) => PicturePuzzleView(
    colorTuple: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
  KeyUtil.numberPyramid: (context) => NumberPyramidView(
    colorTuple1: getRouteArgs<Tuple2<GradientModel, int>>(context),
  ),
};
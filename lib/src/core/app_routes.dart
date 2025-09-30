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
  KeyUtil.splash: (_) => const SplashView(),
  KeyUtil.dashboard: (_) => const DashboardView(),
  KeyUtil.login: (_) => const LoginScreen(),
  KeyUtil.signup: (_) => const SignupScreen(),

  KeyUtil.home: (context) {
    final tuple = getRouteArgs<Tuple2<Dashboard, double>>(context);
    return HomeView(tuple2: tuple);
  },
  KeyUtil.level: (context) {
    final tuple = getRouteArgs<Tuple2<GameCategory, Dashboard>>(context);
    return LevelView(tuple2: tuple);
  },

  KeyUtil.calculator: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return CalculatorView(colorTuple: tuple);
  },
  KeyUtil.guessSign: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return GuessSignView(colorTuple: tuple);
  },
  KeyUtil.trueFalse: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return TrueFalseView(colorTuple: tuple);
  },
  KeyUtil.complexCalculation: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return ComplexCalculationView(colorTuple: tuple);
  },
  KeyUtil.findMissing: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return FindMissingView(colorTuple: tuple);
  },
  KeyUtil.dualGame: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return DualView(colorTuple: tuple);
  },
  KeyUtil.correctAnswer: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return CorrectAnswerView(colorTuple: tuple);
  },
  KeyUtil.quickCalculation: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return QuickCalculationView(colorTuple: tuple);
  },
  KeyUtil.mentalArithmetic: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return MentalArithmeticView(colorTuple: tuple);
  },
  KeyUtil.squareRoot: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return SquareRootView(colorTuple: tuple);
  },
  KeyUtil.numericMemory: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return NumericMemoryView(colorTuple: tuple);
  },
  KeyUtil.cubeRoot: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return CubeRootView(colorTuple: tuple);
  },
  KeyUtil.mathPairs: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return MathPairsView(colorTuple: tuple);
  },
  KeyUtil.concentration: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return ConcentrationView(colorTuple: tuple);
  },
  KeyUtil.magicTriangle: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return MagicTriangleView(colorTuple1: tuple);
  },
  KeyUtil.mathGrid: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return MathGridView(colorTuple: tuple);
  },
  KeyUtil.picturePuzzle: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return PicturePuzzleView(colorTuple: tuple);
  },
  KeyUtil.numberPyramid: (context) {
    final tuple = getRouteArgs<Tuple2<GradientModel, int>>(context);
    return NumberPyramidView(colorTuple1: tuple);
  },
};
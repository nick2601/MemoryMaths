import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/svg_modify.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import '../core/app_assets.dart';
import '../ui/app/theme_provider.dart';

/// -----------------
/// GAME KEYS
/// -----------------
const String keyCalculator = "calculator";
const String keySign = "sign";
const String keyCorrectAnswer = "correct_answer";
const String keyQuickCalculation = "quick_calculation";
const String keyFindMissingCalculation = "find_missing_calculation";
const String keyTrueFalseCalculation = "true_false_calculation";
const String keyDualGame = "keyDualGame";
const String keyComplexGame = "keyComplexGame";
const String keyMentalArithmetic = "mental_arithmetic";
const String keySquareRoot = "square_root";
const String keyMathMachine = "math_machine";
const String keyMathPairs = "math_pairs";
const String keyCubeRoot = "cube_root";
const String keyConcentration = "concentration";
const String keyMagicTriangle = "magic_triangle";
const String keyPicturePuzzle = "picture_puzzle";
const String keyNumberPyramid = "number_pyramid";
const String keyNumericMemory = "numeric_memory";

/// -----------------
/// APP CONSTANTS
/// -----------------
const String fontFamily = "Montserrat";
const String fontFamily1 = "Poppins";
const int defaultLevelSize = 30;
const int easyQuiz = 1;
const int mediumQuiz = 2;
const int hardQuiz = 3;

/// -----------------
/// LAYOUT HELPERS
/// -----------------
double getPercentSize(double total, double percent) =>
    (total * percent) / 100;

double getScreenPercentSize(BuildContext context, double percent) =>
    (MediaQuery.of(context).size.height * percent) / 100;

double getWidthPercentSize(BuildContext context, double percent) =>
    (MediaQuery.of(context).size.width * percent) / 100;

double getHorizontalSpace(BuildContext context) =>
    FetchPixels.getPixelWidth(40);

double getVerticalSpace(BuildContext context) =>
    FetchPixels.getPixelHeight(37);

double getMainHeight(BuildContext context) =>
    getScreenPercentSize(context, 35);

double getCommonRadius(BuildContext context) =>
    getScreenPercentSize(context, 2.2);

double getCommonCalculatorRadius(BuildContext context) =>
    getScreenPercentSize(context, 4);

double getDefaultButtonSize(BuildContext context) =>
    getScreenPercentSize(context, 7.2);

double getRemainHeight({required BuildContext context}) {
  double topMargin = getScreenPercentSize(context, 2.5);
  return getScreenPercentSize(context, 100) -
      getScreenPercentSize(context, 7.5) -
      (topMargin * 2);
}

/// -----------------
/// SYSTEM HELPERS
/// -----------------
setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: color),
  );
}

/// -----------------
/// TEXT WIDGETS
/// -----------------
Widget getTextWidgetWithMaxLine(
    TextStyle textStyle,
    String text,
    TextAlign textAlign,
    double textSizes,
    int maxLine,
    ) =>
    Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: textStyle.copyWith(
        decoration: TextDecoration.none,
        fontSize: textSizes,
      ),
      textAlign: textAlign,
    );

Widget getTextWidget(
    TextStyle textStyle,
    String text,
    TextAlign textAlign,
    double textSizes,
    ) =>
    Text(
      text,
      style: textStyle.copyWith(
        decoration: TextDecoration.none,
        fontSize: textSizes,
      ),
      textAlign: textAlign,
    );

/// -----------------
/// DECORATIONS
/// -----------------
getDefaultDecoration( {
  double? radius,
  Color? bgColor,
  Color? borderColor,
  bool? isShadow,
  double? borderWidth,
  Color? shadowColor,
}) =>
    ShapeDecoration(
      color: bgColor ?? Colors.transparent,
      shadows: isShadow == true
          ? [
        BoxShadow(
          color: shadowColor ?? Colors.grey.shade200,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ]
          : [],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
    );
/// Only border decoration, no background fill
getDefaultDecorationWithBorder({
  double? radius,
  Color? borderColor,
  double? borderWidth,
  bool? isShadow,
}) =>
    BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: borderColor ?? Colors.black, width: borderWidth ?? 1),
      borderRadius: BorderRadius.circular(radius ?? 0),
      boxShadow: isShadow == true
          ? [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ]
          : [],
    );

/// Gradient fill decoration
getDefaultDecorationWithGradient({
  double? radius,
  Gradient? colors,
  Color? borderColor,
  double? borderWidth,
  bool? isShadow,
}) =>
    BoxDecoration(
      gradient: colors,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth ?? 1)
          : null,
      borderRadius: BorderRadius.circular(radius ?? 0),
      boxShadow: isShadow == true
          ? [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ]
          : [],
    );

/// Side-specific decoration (already in your file)
getDecorationWithSide({
  double? radius,
  Color? bgColor,
  Color? borderColor,
  bool? isTopRight,
  bool? isTopLeft,
  bool? isBottomRight,
  bool? isBottomLeft,
  bool? isShadow,
  Gradient? colors,
}) =>
    ShapeDecoration(
      color: colors == null ? bgColor ?? Colors.transparent : null,
      gradient: colors,
      shadows: isShadow == true
          ? [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ]
          : [],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: (isBottomRight ?? false)
              ? Radius.circular(radius ?? 0)
              : Radius.zero,
          bottomLeft: (isBottomLeft ?? false)
              ? Radius.circular(radius ?? 0)
              : Radius.zero,
          topLeft: (isTopLeft ?? false)
              ? Radius.circular(radius ?? 0)
              : Radius.zero,
          topRight: (isTopRight ?? false)
              ? Radius.circular(radius ?? 0)
              : Radius.zero,
        ),
      ),
    );


/// -----------------
/// ICON HELPERS
/// -----------------
getHintIcon({required Function function, Color? color, bool? isWhite}) =>
    GestureDetector(
      onTap: () => function(),
      child: SvgPicture.string(
        SvgModify.hintSvg(color ?? Colors.white, forceWhite: isWhite??false),
        height: 20,
      ),
    );

/// -----------------
/// COLOR UTILS
/// -----------------
Color lighten(Color color, [double amount = 0.04]) {
  final hsl = HSLColor.fromColor(color);
  return hsl
      .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
      .toColor();
}

Color darken(Color color, [double amount = .1]) {
  final hsl = HSLColor.fromColor(color);
  return hsl
      .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
      .toColor();
}

/// -----------------
/// SCORE WIDGET
/// -----------------
Widget getScoreWidget(BuildContext context, WidgetRef ref,
    {Color? color, bool? isCenter}) {
  final coin = ref.watch(dashboardProvider.select((s) => s.coins));
  return Row(
    mainAxisAlignment:
    isCenter == true ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: [
      SvgPicture.asset(AppAssets.icCoin, height: 30, width: 30),
      const SizedBox(width: 8),
      getTextWidget(
        Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
          color: color,
        ),
        coin.toString(),
        TextAlign.start,
        20,
      ),
    ],
  );
}
String getFolderName(BuildContext context, String folderName) {
  return "assets/images/$folderName/";
}

Color getBgColor(ThemeNotifier themeProvider, Color color) {
  return themeProvider.isDarkMode ? Colors.grey[800]! : color;
}

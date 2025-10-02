import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import '../core/app_assets.dart';
import '../ui/app/svg_modify.dart';
import '../ui/dashboard/dashboard_provider.dart';
import '../ui/resizer/fetch_pixels.dart';
import '../ui/setting_screen.dart';

/// Key string constants for different game types
String keyCalculator = "calculator";
String keySign = "sign";
String keyCorrectAnswer = "correct_answer";
String keyQuickCalculation = "quick_calculation";
String keyFindMissingCalculation = "find_missing_calculation";
String keyTrueFalseCalculation = "true_false_calculation";
String keyDualGame = "keyDualGame";
String keyComplexGame = "keyComplexGame";
String keyMentalArithmetic = "mental_arithmetic";
String keySquareRoot = "square_root";
String keyMathMachine = "math_machine";
String keyMathPairs = "math_pairs";
String keyCubeRoot = "cube_root";
String keyConcentration = "concentration";
String keyMagicTriangle = "magic_triangle";
String keyPicturePuzzle = "picture_puzzle";
String keyNumberPyramid = "number_pyramid";
String keyNumericMemory = "numeric_memory";

/// Font family constants
String fontFamily = "Montserrat";
String fontFamily1 = "Poppins";

/// Default level and difficulty constants
int defaultLevelSize = 30;
int easyQuiz = 1;
int mediumQuiz = 2;
int hardQuiz = 3;

/// Calculates percentage of a given total value
///
/// [total] - The total value
/// [percent] - The percentage to calculate (0-100)
/// Returns the calculated percentage value
double getPercentSize(double total, double percent) {
  return (total * percent) / 100;
}

/// Calculates a percentage of the screen height
///
/// [context] - BuildContext for accessing screen dimensions
/// [percent] - The percentage of screen height (0-100)
/// Returns height in pixels based on percentage
double getScreenPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height * percent) / 100;
}

/// Gets standard horizontal spacing
///
/// [context] - BuildContext for accessing screen dimensions
/// Returns a consistent horizontal spacing value
double getHorizontalSpace(BuildContext context) {
  FetchPixels(context);
  return FetchPixels.getPixelWidth(40);
}

/// Gets standard vertical spacing
///
/// [context] - BuildContext for accessing screen dimensions
/// Returns a consistent vertical spacing value
double getVerticalSpace(BuildContext context) {
  return FetchPixels.getPixelHeight(37);
}

/// Calculates a percentage of the screen width
///
/// [context] - BuildContext for accessing screen dimensions
/// [percent] - The percentage of screen width (0-100)
/// Returns width in pixels based on percentage
double getWidthPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width * percent) / 100;
}

/// Sets the status bar color
///
/// [color] - The color to apply to the status bar
void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color));
}

/// Creates a Text widget with maximum line constraint
///
/// [textStyle] - The text style to apply
/// [text] - The text to display
/// [textAlign] - The text alignment
/// [textSizes] - The text size
/// [maxLine] - Maximum number of lines before ellipsis
/// Returns a styled Text widget with max lines
Widget getTextWidgetWithMaxLine(TextStyle textStyle, String text,
    TextAlign textAlign, double textSizes, int maxLine) {
  return Text(
    text,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: textStyle.color,
        fontFamily: textStyle.fontFamily,
        fontWeight: textStyle.fontWeight),
    textAlign: textAlign,
  );
}

/// Creates a Text widget with standard styling
///
/// [textStyle] - The text style to apply
/// [text] - The text to display
/// [textAlign] - The text alignment
/// [textSizes] - The text size
/// [hint] - Optional hint text
/// Returns a styled Text widget
Widget getTextWidget(
    TextStyle textStyle, String text, TextAlign textAlign, double textSizes,
    {String? hint}) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: textStyle.color,
        fontFamily: textStyle.fontFamily,
        fontWeight: textStyle.fontWeight),
    textAlign: textAlign,
  );
}

/// Creates a smooth rectangle decoration with optional shadow
///
/// [radius] - Corner radius
/// [bgColor] - Background color
/// [borderColor] - Border color
/// [isShadow] - Whether to apply shadow
/// [borderWidth] - Border width
/// [shadowColor] - Shadow color
/// Returns a ShapeDecoration with smooth corners
ShapeDecoration getDefaultDecoration(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    double? borderWidth,
    Color? shadowColor}) {
  return ShapeDecoration(
    color: (bgColor == null) ? Colors.transparent : bgColor,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: shadowColor == null ? Colors.grey.shade200 : shadowColor,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderColor == null)
              ? 0
              : (borderWidth == null)
                  ? 1
                  : borderWidth),
      borderRadius: SmoothBorderRadius(
        cornerRadius: (radius == null) ? 0 : radius,
        cornerSmoothing: 0.8,
      ),
    ),
  );
}

/// Creates a smooth rectangle decoration with gradient
///
/// [radius] - Corner radius
/// [bgColor] - Background color
/// [borderColor] - Border color
/// [isShadow] - Whether to apply shadow
/// [colors] - Optional gradient colors
/// Returns a BoxDecoration with gradient and smooth corners
BoxDecoration getDefaultDecorationWithGradient(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Gradient? colors}) {
  return BoxDecoration(
    gradient: colors,
    boxShadow: isShadow == null
        ? []
        : [
            BoxShadow(
                color: bgColor!.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
    color: bgColor,
    border: Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderColor == null ? 0 : 1,
    ),
    borderRadius: BorderRadius.circular(radius ?? 0),
  );
}

/// Creates a smooth rectangle decoration with border
///
/// [radius] - Corner radius
/// [bgColor] - Background color
/// [borderColor] - Border color
/// [isShadow] - Whether to apply shadow
/// [colors] - Optional gradient colors
/// Returns a BoxDecoration with border and smooth corners
BoxDecoration getDefaultDecorationWithBorder(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Gradient? colors}) {
  return BoxDecoration(
    boxShadow: isShadow == null
        ? []
        : [
            BoxShadow(
                color: bgColor!.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
    color: bgColor ?? Colors.transparent,
    border: Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderColor == null ? 0 : 1,
    ),
    borderRadius: BorderRadius.circular(radius ?? 0),
  );
}

/// Creates a circular container with shadow
///
/// [widget] - Child widget to display in circle
/// [size] - Size of the circle
/// [color] - Background color
/// [isShadow] - Whether to apply shadow
/// Returns a circular container with optional shadow
Widget getShadowCircle(
    {required Widget widget, double? size, Color? color, bool? isShadow}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: (color == null) ? Colors.white : color,
      shape: BoxShape.circle,
      boxShadow: isShadow == null
          ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]
          : null,
    ),
    child: widget,
  );
}

/// Creates a header widget with title and content
///
/// [context] - BuildContext for accessing theme
/// [title] - Header title
/// [content] - Header content
/// [color] - Optional text color
/// Returns a Column with title and content
Widget getHeaderWidget(BuildContext context, String title, String content,
    {Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: getVerticalSpace(context)),
      getTextWidget(
          Theme.of(context).textTheme.titleSmall!.copyWith(
              color: color != null ? color : null, fontWeight: FontWeight.bold),
          title,
          TextAlign.start,
          getScreenPercentSize(context, 3)),
      SizedBox(height: getScreenPercentSize(context, 0.9)),
      Padding(
        padding: EdgeInsets.only(right: getWidthPercentSize(context, 25)),
        child: getTextWidgetWithMaxLine(
            Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: color != null ? color.withOpacity(0.9) : null),
            content,
            TextAlign.start,
            getScreenPercentSize(context, 1.7),
            2),
      ),
    ],
  );
}

/// Gets folder name based on theme mode
///
/// [context] - BuildContext for accessing theme
/// [folderName] - Base folder name
/// Returns folder path based on current theme
String getFolderName(BuildContext context, String folderName) {
  if (themeMode == ThemeMode.dark) {
    folderName = folderName.replaceAll("/", "");
    folderName = folderName + "Dark/";
  }

  return AppAssets.assetFolderPath + folderName;
}

/// Creates a hint icon button
///
/// [function] - Callback when icon is tapped
/// [color] - Icon color
/// [isWhite] - Whether to use white variant
/// Returns a GestureDetector with hint SVG icon
Widget getHintIcon({required Function function, Color? color, bool? isWhite}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: SvgPicture.string(
      SvgModify.hintSvg((color == null) ? Colors.white : color,
          isWhite: isWhite),
      height: 20,
    ),
  );
}

/// Creates a default icon widget (SVG or IconData)
///
/// [context] - BuildContext for sizing
/// [function] - Optional callback when icon is tapped
/// [icon] - Optional SVG icon name
/// [folder] - Optional folder path
/// [iconData] - Optional IconData for using system icons
/// [changeFolderName] - Whether to change folder name based on theme
/// Returns an InkWell with icon
Widget getDefaultIconWidget(BuildContext context,
    {Function? function,
    String? icon,
    String? folder,
    IconData? iconData,
    bool? changeFolderName}) {
  double size = getScreenPercentSize(context, 3.5);

  if (folder != null && changeFolderName == null) {
    folder = getFolderName(context, folder);
  } else if (folder != null) {
    folder = AppAssets.assetFolderPath + folder;
  }

  return InkWell(
    onTap: () {
      if (function != null) {
        function();
      }
    },
    child: icon == null
        ? Icon(
            iconData,
            size: size,
          )
        : SvgPicture.asset(
            '$folder$icon',
            width: size,
            height: size,
          ),
  );
}

/// Checks if a game category uses detail widget
///
/// [gameCategoryType] - The game category to check
/// Returns true if the game type should use detail widget
bool isDetailWidget(GameCategoryType gameCategoryType) {
  if (gameCategoryType == GameCategoryType.CALCULATOR ||
      gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC ||
      gameCategoryType == GameCategoryType.QUICK_CALCULATION ||
      gameCategoryType == GameCategoryType.MATH_GRID ||
      gameCategoryType == GameCategoryType.MATH_PAIRS ||
      gameCategoryType == GameCategoryType.CONCENTRATION ||
      gameCategoryType == GameCategoryType.MAGIC_TRIANGLE ||
      gameCategoryType == GameCategoryType.NUMERIC_MEMORY ||
      gameCategoryType == GameCategoryType.PICTURE_PUZZLE ||
      gameCategoryType == GameCategoryType.NUMBER_PYRAMID) {
    return false;
  } else {
    return true;
  }
}

getNoneAppBar(BuildContext context,
    {Function? function, String? icon, IconData? iconData, Color? color}) {
  if (color == null) {
    color = Theme.of(context).scaffoldBackgroundColor;
  }
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: color,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lighten(color, 0.5), color]),
      ),
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      systemNavigationBarIconBrightness: Theme.of(context).brightness,
    ),
  );
}

getTrophyIcon(BuildContext context) {
  double trophySize = FetchPixels.getPixelHeight(55);
  // double trophySize = getScreenPercentSize(context, 3.5);
  return SvgPicture.asset(
    AppAssets.icCoin,
    width: trophySize,
    height: trophySize,
  );
}

getBackGroundColor(BuildContext context) {
  Color bgColor = Colors.white;
  if (themeMode == ThemeMode.dark) {
    bgColor = "#353535".toColor();
  }
  return bgColor;
}

getCommonBackGroundColor(BuildContext context) {
  // ignore: unused_local_variable
  ThemeProvider themeProvider = Provider.of(context);
  Color bgColor = Colors.white;
  if (themeMode == ThemeMode.dark) {
    bgColor = "#000000".toColor();
    // bgColor = "#353535".toColor();
  }
  return bgColor;
}

getMainHeight(BuildContext context) {
  return getScreenPercentSize(context, 35);
}

getDecorationWithSide({
  double? radius,
  Color? bgColor,
  Color? borderColor,
  bool? isTopRight,
  var colors,
  bool? isTopLeft,
  bool? isBottomRight,
  bool? isBottomLeft,
  bool? isShadow,
}) {
  return ShapeDecoration(
    color: colors != null
        ? null
        : (bgColor == null)
            ? Colors.transparent
            : bgColor,
    gradient: (colors == null) ? null : colors,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderColor == null) ? 0 : 1),
      borderRadius: SmoothBorderRadius.only(
        bottomRight: SmoothRadius(
          cornerRadius: (isBottomRight == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        bottomLeft: SmoothRadius(
          cornerRadius: (isBottomLeft == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        topLeft: SmoothRadius(
          cornerRadius: (isTopLeft == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        topRight: SmoothRadius(
          cornerRadius: (isTopRight == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
      ),
    ),
  );
}

getSettingWidget(BuildContext context, {Function? function}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingScreen(),
          )).then((value) {
        if (function != null) {
          function();
        }
      });
    },
    // borderRadius: BorderRadius.circular(24),
    child: SvgPicture.asset(
      AppAssets.setting,
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(60),
      color: Theme.of(context).textTheme.titleMedium!.color,
    ),
  );
}

getScoreWidget(BuildContext context, {Color? color, bool? isCenter}) {
  return Consumer<CoinProvider>(
    builder: (context, coinProvider, _) => Row(
      mainAxisAlignment:
          (isCenter != null) ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: (isCenter != null)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        getTrophyIcon(context),
        SizedBox(
          width: FetchPixels.getPixelHeight(20),
        ),
        Text(
          coinProvider.coin.toString(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: color != null ? color : null),
        ),
      ],
    ),
  );
}

Widget getShadowWidget(
    {required Widget widget,
    double? verticalMargin,
    double? horizontalMargin,
    double? radius,
    double? topPadding,
    double? leftPadding,
    double? rightPadding,
    double? bottomPadding,
    Color? color,
    Color? shadowColor,
    bool? isShadow}) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: (verticalMargin == null) ? 0 : verticalMargin,
        horizontal: (horizontalMargin == null) ? 0 : horizontalMargin),
    decoration: getDefaultDecoration(
        bgColor: (color == null) ? Colors.white : color,
        shadowColor: shadowColor == null ? null : shadowColor,
        radius: (radius == null) ? 0 : radius,
        isShadow: (isShadow == null) ? true : isShadow),
    padding: EdgeInsets.only(
      top: (topPadding == null) ? 0 : topPadding,
      bottom: (bottomPadding == null) ? 0 : bottomPadding,
      right: (rightPadding == null) ? 0 : rightPadding,
      left: (leftPadding == null) ? 0 : leftPadding,
    ),
    child: widget,
  );
}

Color lighten(Color color, [double amount = 0.04]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

getRemainHeight({required BuildContext context}) {
  double topMargin = getScreenPercentSize(context, 2.5);

  return getScreenPercentSize(context, 100) -
      getScreenPercentSize(context, 7.5) -
      (topMargin * 2);
}

getShadowColor(BuildContext context) {
  if (themeMode == ThemeMode.dark) {
    return Colors.black12;
  } else {
    return Colors.grey.shade200;
  }
}

getBgColor(ThemeProvider themeProvider, Color color) {
  if (themeMode == ThemeMode.dark) {
    return "#565656".toColor();
  } else {
    return color;
  }
}

Widget getCommonMainWidget(
    {required BuildContext context,
    required var child,
    required Color color,
    required GameCategoryType gameCategoryType,
    bool? isTopMargin}) {
  double appBarHeight = getScreenPercentSize(context, 25);
  double mainHeight = getScreenPercentSize(context, 35);
  var circle = getScreenPercentSize(context, 12);
  var margin = getHorizontalSpace(context);

  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: Stack(
            children: [
              SizedBox(
                height: mainHeight,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  primary: false,
                  appBar: AppBar(
                    bottomOpacity: 0.0,
                    title: const Text(''),
                    toolbarHeight: 0,
                    elevation: 0,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: SizedBox(
                    width: (circle),
                    height: (circle),
                    child: Container(
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  ),
                  bottomNavigationBar: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(getScreenPercentSize(context, 4)),
                        topRight:
                            Radius.circular(getScreenPercentSize(context, 4))),
                    child: Container(
                      height: (appBarHeight),
                      child: BottomAppBar(
                        color: color,
                        elevation: 0,
                        shape: CircularNotchedRectangle(),
                        notchMargin: (10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Expanded(
                              child: SizedBox(width: 0),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: getPercentSize(mainHeight, 35)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: margin),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  getCommonDetailWidget(
                                      context: context,
                                      data: "0",
                                      icon: AppAssets.rightIcon,
                                      mainHeight: mainHeight),
                                  SizedBox(
                                    height: getScreenPercentSize(context, 0.8),
                                  ),
                                  getCommonDetailWidget(
                                      context: context,
                                      data: "0",
                                      icon: AppAssets.wrongIcon,
                                      mainHeight: mainHeight)
                                ],
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icTrophy,
                                  height: getPercentSize(mainHeight, 7),
                                  width: getPercentSize(mainHeight, 7),
                                ),
                                SizedBox(
                                  width: getWidthPercentSize(context, 1.2),
                                ),
                                Selector<GameProvider, Tuple2<double, double>>(
                                    selector: (p0, p1) =>
                                        Tuple2(p1.currentScore, p1.oldScore),
                                    builder: (context, tuple2, child) {
                                      int oldScore = tuple2.item2.toInt();
                                      int currentScore = tuple2.item1.toInt();
                                      return getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          oldScore > currentScore
                                              ? currentScore.toString()
                                              : oldScore.toString(),
                                          TextAlign.center,
                                          getPercentSize(mainHeight, 6));
                                      // return CommonScoreView(
                                      //   currentScore: tuple2.item1.toInt(),
                                      //   oldScore: tuple2.item2.toInt(),
                                      // );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                      child: child,
                    ))
                  ],
                ),
              ),

              // Container(
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: child,
              //   margin: EdgeInsets.only(top : getPercentSize(mainHeight, 50)),
              // ),
            ],
          ),
        ),
      ),
      // Container(
      //   margin: EdgeInsets.only(top : mainHeight,
      //   right: getHorizontalSpace(context),left: getHorizontalSpace(context)),
      //   child: child,
      // )
    ],
  );
}

Widget getCommonDetailWidget({
  required double mainHeight,
  required String icon,
  required String data,
  required BuildContext context,
  double? iconSize,
  double? fontSize,
  bool? isCenter,
  double? horizontalSpace,
}) {
  double size = iconSize == null ? getPercentSize(mainHeight, 6) : iconSize;
  double font = fontSize == null ? getPercentSize(mainHeight, 5) : fontSize;
  return Row(
    mainAxisAlignment:
        isCenter == null ? MainAxisAlignment.start : MainAxisAlignment.center,
    children: [
      Container(
        child: Image.asset(
          icon,
          height: size,
          width: size,
          fit: BoxFit.fill,
        ),
      ),
      SizedBox(
        width: horizontalSpace == null
            ? getWidthPercentSize(context, 1.5)
            : horizontalSpace,
      ),
      getTextWidget(
          Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight:
                  horizontalSpace == null ? FontWeight.w500 : FontWeight.w600),
          data,
          TextAlign.center,
          font),
    ],
  );
}

String getAppLink() {
  String pkgName = "com.example.mathsgamess";
  String appStoreIdentifier = "1562289688";
  if (Platform.isAndroid) {
    return "https://play.google.com/store/apps/details?id=$pkgName";
  } else if (Platform.isIOS) {
    return "https://apps.apple.com/us/app/apple-store/id$appStoreIdentifier";
  }
  return "";
}

Widget getCommonWidget(
    {required BuildContext context,
    required var child,
    required var subChild,
    var bgColor,
    bool? isTopMargin}) {
  double topMargin = getScreenPercentSize(context, 2.3);
  double remainHeight = getRemainHeight(context: context);
  double padding = getScreenPercentSize(context, 2);

  Color color = Colors.white;
  if (themeMode == ThemeMode.dark) {
    color = "#353535".toColor();
  }

  color = bgColor == null ? color : bgColor;
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        margin:
            EdgeInsets.symmetric(horizontal: (getHorizontalSpace(context) / 2)),
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          child: getShadowWidget(
              isShadow: false,
              widget: Container(
                height: remainHeight,
                margin: EdgeInsets.only(
                  top:
                      isTopMargin == null ? getPercentSize(remainHeight, 4) : 0,
                  left: (getHorizontalSpace(context) / 2),
                  right: (getHorizontalSpace(context) / 2),
                ),
                constraints: BoxConstraints.expand(),
                child: child,
              ),
              radius: getScreenPercentSize(context, 2),
              horizontalMargin: getHorizontalSpace(context),
              verticalMargin: topMargin,
              topPadding: padding,
              color: color,
              shadowColor: getShadowColor(context)),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: (topMargin)),
        child: Align(
          alignment: Alignment.topCenter,
          child: subChild,
        ),
      )
    ],
  );
}

getCommonRadius(BuildContext context) {
  return getScreenPercentSize(context, 2.2);
}

getCommonCalculatorRadius(BuildContext context) {
  return getScreenPercentSize(context, 4);
}

getDefaultButtonSize(BuildContext context) {
  return getScreenPercentSize(context, 7.2);
}

Widget getHintButtonWidget(
    BuildContext context, String s, var color, Function function,
    {bool? isBorder, Color? textColor, Color? borderColor}) {
  double height = getDefaultButtonSize(context);
  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 30);

  return InkWell(
    child: Container(
      height: height,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: isBorder == null
          ? getDefaultDecoration(radius: radius, bgColor: color)
          : getDefaultDecorationWithBorder(
              radius: radius,
              borderColor: borderColor == null ? color : borderColor,
              bgColor: Colors.transparent),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius),
                topLeft: Radius.circular(radius)),
            clipBehavior: Clip.antiAlias,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.icCoin,
                    height: getPercentSize(height, 25),
                    width: getPercentSize(height, 25),
                  ),
                  SizedBox(
                    width: getWidthPercentSize(context, 1),
                  ),
                  getTextWidget(
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: textColor == null ? Colors.white : textColor),
                      'Use 10 coin',
                      TextAlign.center,
                      (fontSize / 1.2))
                ],
              ),
            ),
          ),
          Center(
              child: getTextWidget(
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColor == null ? Colors.white : textColor),
                  s,
                  TextAlign.center,
                  fontSize))
        ],
      ),
    ),
    onTap: () {
      function();
    },
  );
}

Widget getButtonWidget(
    BuildContext context, String s, var color, Function function,
    {bool? isBorder, Color? textColor, Color? borderColor}) {
  double height = getDefaultButtonSize(context);
  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 30);

  return InkWell(
    child: Container(
      height: height,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: isBorder == null
          ? getDefaultDecoration(radius: radius, bgColor: color)
          : getDefaultDecorationWithBorder(
              radius: radius,
              borderColor: borderColor == null ? color : borderColor,
              bgColor: Colors.transparent),
      child: Center(
          child: getTextWidget(
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColor == null ? Colors.white : textColor),
              s,
              TextAlign.center,
              fontSize)),
    ),
    onTap: () {
      function();
    },
  );
}

String pkgName = "mathmatrix_";

String sound = pkgName + "sound";
String vibration = pkgName + "vibration";
String tickSound = 'tick.mp3';
String rightSound = 'right.mp3';
String wrongSound = 'wrong.mp3';
String gameOverSound = 'gameover.mp3';

String privacyURL = 'https://google.com';

setSound(bool rem) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(sound, rem);
}

getSound() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool intValue = prefs.getBool(sound) ?? true;
  return intValue;
}

setVibration(bool rem) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(vibration, rem);
}

getCommonDecoration(BuildContext context) {
  return getDecorationWithSide(
    isShadow: themeMode == ThemeMode.dark ? null : true,
    bgColor: getCommonBackGroundColor(context),
    isTopLeft: true,
    isTopRight: true,
    radius: getPercentSize(getMainHeight(context), 12),
  );
}

getVibration() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool intValue = prefs.getBool(vibration) ?? true;
  return intValue;
}

/// Converts seconds to time string format (MM:SS)
///
/// [sec] - Time in seconds
/// Returns formatted time string
String secToTime(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  int second = sec % 60;
  double minute = sec / 60;
  if (minute >= 60) {
    double hour = minute / 60;
    minute %= 60;

    return hour.toInt().toString() +
        ":" +
        (minute < 10
            ? minute == 0
                ? "00"
                : "0" + minute.toInt().toString()
            : minute.toInt().toString()) +
        ":" +
        (second < 10
            ? "00" + second.toInt().toString()
            : second.toInt().toString());
  }
  return (minute < 10
          ? minute == 0
              ? "00"
              : "0" + minute.toInt().toString()
          : minute.toInt().toString()) +
      ":" +
      (second < 10
          ? minute == 0
              ? "00"
              : "0" + second.toInt().toString()
          : second.toInt().toString());
}

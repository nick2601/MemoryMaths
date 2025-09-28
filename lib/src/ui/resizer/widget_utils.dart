import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathsgames/src/core/app_assets.dart';

import '../../utility/Constants.dart';
import 'fetch_pixels.dart';

/// 🔹 Show custom toast
void showCustomToast(String text, BuildContext context) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

/// 🔹 Space widgets
Widget getHorSpace(double width) => SizedBox(width: width);
Widget getVerSpace(double height) => SizedBox(height: height);

/// 🔹 SVG Image (default path handling)
Widget getSvgImage(
    BuildContext context,
    String image,
    double size, {
      Color? color,
      BoxFit fit = BoxFit.contain,
    }) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    color: color,
    width: FetchPixels.getPixelWidth(size),
    height: FetchPixels.getPixelHeight(size),
    fit: fit,
  );
}

/// 🔹 SVG with custom size
Widget getSvgImageWithSize(
    BuildContext context,
    String image,
    double width,
    double height, {
      Color? color,
      BoxFit fit = BoxFit.contain,
    }) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    color: color,
    width: width,
    height: height,
    fit: fit,
  );
}

/// 🔹 Custom Font Text
Widget getCustomFont(
    String text,
    double fontSize,
    Color fontColor,
    int maxLine, {
      TextOverflow overflow = TextOverflow.ellipsis,
      TextDecoration decoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start,
      double? txtHeight,
    }) {
  return Text(
    text,
    overflow: overflow,
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
    style: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: fontColor,
      fontFamily: fontFamily,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
  );
}

/// 🔹 Rounded container with neumorphic-like shape
Widget getRoundedContainer({
  required double height,
  required double width,
  required Color bgColor,
  double radius = 16,
  List<BoxShadow> shadows = const [],
  Widget? child,
}) {
  return Container(
    height: height,
    width: width,
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      color: bgColor,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
      shadows: shadows,
    ),
    child: child,
  );
}

/// 🔹 Loading Indicator
Widget getLoadingView({Color color = Colors.blue, double size = 36}) {
  return Center(
    child: SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2.8,
      ),
    ),
  );
}

/// 🔹 Divider
Widget getCustomDivider({
  double thickness = 1,
  Color color = Colors.grey,
  double indent = 0,
  double endIndent = 0,
}) {
  return Divider(
    thickness: thickness,
    color: color,
    indent: indent,
    endIndent: endIndent,
  );
}

/// 🔹 Gradient Button
Widget getGradientButton({
  required String text,
  required VoidCallback onTap,
  required List<Color> colors,
  double radius = 24,
  double fontSize = 16,
  EdgeInsetsGeometry padding =
  const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  Color textColor = Colors.white,
  FontWeight fontWeight = FontWeight.w600,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(radius),
    child: Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    ),
  );
}

/// 🔹 Icon Button (consistent style)
Widget getIconButton({
  required IconData icon,
  required VoidCallback onTap,
  Color color = Colors.black,
  double size = 24,
  EdgeInsets padding = const EdgeInsets.all(8),
  ShapeBorder shape = const CircleBorder(),
  Color backgroundColor = Colors.transparent,
}) {
  return Material(
    color: backgroundColor,
    shape: shape,
    child: InkWell(
      customBorder: shape,
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Icon(icon, size: size, color: color),
      ),
    ),
  );
}

/// 🔹 Circle Avatar with Image
Widget getCircleAvatar({
  required double size,
  required String imagePath,
  BoxFit fit = BoxFit.cover,
  Color? bgColor,
}) {
  return CircleAvatar(
    radius: size / 2,
    backgroundColor: bgColor ?? Colors.grey.shade200,
    backgroundImage: AssetImage(AppAssets.assetPath + imagePath),
  );
}

/// 🔹 Dialog wrapper
Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    ),
  );
}


Widget getButtonWidget(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed, {
      Color? textColor,
      double fontSize = 16,
      EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(8)),
    }) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: padding,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize),
    ),
  );
}

Widget getDefaultIconWidget(
    BuildContext context, {
      required String icon,
      required String folder,
      required VoidCallback function,
    }) {
  return IconButton(
    icon: Image.asset('$folder/$icon', width: 32, height: 32),
    onPressed: function,
  );
}

PreferredSizeWidget getNoneAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
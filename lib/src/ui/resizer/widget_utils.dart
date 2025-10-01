/**
 * Utility functions and widgets for UI components.
 * This file contains helper methods for creating reusable widgets and managing UI-related tasks.
 */

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathsgames/src/core/app_assets.dart';

import '../../utility/global_constants.dart';
import 'fetch_pixels.dart';

/// Displays a custom toast message at the bottom of the screen.
///
/// [texts] - The message to display.
/// [context] - The BuildContext of the widget.
void showCustomToast(String texts, BuildContext context) {
  Fluttertoast.showToast(
      msg: texts,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0);
}

/// Returns a vertical space widget with the specified height.
///
/// [verSpace] - The height of the vertical space.
Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

/// Returns an SVG image widget with specified dimensions and optional color.
///
/// [context] - The BuildContext of the widget.
/// [image] - The name of the SVG image file.
/// [width] - The width of the image.
/// [height] - The height of the image.
/// [color] - Optional color to apply to the image.
/// [fit] - How the image should be inscribed into the space allocated.
Widget getSvgImageWithSize(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit fit = BoxFit.fill}) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    color: color,
    width: width,
    height: height,
    fit: fit,
  );
}

/// Returns the default font size for editable text fields.
double getEditFontSize() {
  return 35;
}

/// Returns the default height for editable text fields.
double getEditHeight() {
  return FetchPixels.getPixelHeight(130);
}

/// Returns the default radius size for editable text fields.
double getEditRadiusSize() {
  return FetchPixels.getPixelHeight(35);
}

/// Returns an SVG image widget with a specified size and optional color.
///
/// [context] - The BuildContext of the widget.
/// [image] - The name of the SVG image file.
/// [size] - The size of the image.
/// [color] - Optional color to apply to the image.
Widget getSvgImage(BuildContext context, String image, double size,
    {Color? color}) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    color: color,
    width: FetchPixels.getPixelWidth(size),
    height: FetchPixels.getPixelHeight(size),
    fit: BoxFit.fill,
  );
}

/// Returns the default icon size for editable text fields.
double getEditIconSize() {
  return 55;
}

/// Returns a customizable text field widget.
///
/// [context] - The BuildContext of the widget.
/// [s] - The hint text for the text field.
/// [textEditingController] - The controller for the text field.
/// [fontColor] - The color of the text.
/// [selectedTheme] - The color of the border when focused.
/// [withPrefix] - Whether to include a prefix icon.
/// [imgName] - The name of the prefix icon image.
/// [minLines] - Whether the text field supports multiple lines.
/// [margin] - The margin around the text field.
/// [type] - The keyboard type for the text field.
Widget getDefaultTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    Color selectedTheme,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    TextInputType type = TextInputType.text}) {
  double height = getEditHeight();
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
      return MediaQuery(
        data: mqDataNew,
        child: Container(
          height: (minLines) ? (height * 2.2) : height,
          margin: margin,
          padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getPixelWidth(18), vertical: 0),
          alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                  color: isAutoFocus ? selectedTheme : Colors.grey, width: 1),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getEditRadiusSize(),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    isAutoFocus = true;
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    isAutoFocus = false;
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: SizedBox(
                height: double.infinity,
                child: (minLines)
                    ? TextField(
                        maxLines: (minLines) ? null : 1,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        keyboardType: type,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )
                    : Center(
                        child: TextField(
                        maxLines: (minLines) ? null : 1,
                        keyboardType: type,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )),
              )),
        ),
      );
    },
  );
}

/// Returns a text widget with customizable font properties.
///
/// [text] - The text to display.
/// [fontSize] - The size of the font.
/// [fontColor] - The color of the font.
/// [maxLine] - The maximum number of lines for the text.
/// [overflow] - How to handle text overflow.
/// [decoration] - Text decoration (e.g., underline).
/// [fontWeight] - The weight of the font.
/// [textAlign] - The alignment of the text.
/// [txtHeight] - The height of the text.
Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

/// Returns a horizontal space widget with the specified width.
///
/// [verSpace] - The width of the horizontal space.
Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

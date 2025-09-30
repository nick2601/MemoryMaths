import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathsgames/src/core/app_assets.dart';

import '../../utility/global_constants.dart';
import 'fetch_pixels.dart';

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

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

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

double getEditFontSize() {
  return 35;
}

double getEditHeight() {
  return FetchPixels.getPixelHeight(130);
}

double getEditRadiusSize() {
  return FetchPixels.getPixelHeight(35);
}

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

double getEditIconSize() {
  return 55;
}

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
                            // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
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

//
//
// Widget getCloseButton(BuildContext context, Function function) {
//   return InkWell(
//     onTap: () {
//       function();
//       // Constant.backToPrev(context);
//     },
//     child: getSvgImageWithSize(context, "Close.svg",
//         FetchPixels.getPixelHeight(24), FetchPixels.getPixelHeight(24)),
//   );
// }
//
// Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
//     {String fontFamily = fontFamily,
//     TextOverflow overflow = TextOverflow.ellipsis,
//     TextDecoration decoration = TextDecoration.none,
//     FontWeight fontWeight = FontWeight.normal,
//     TextAlign textAlign = TextAlign.start,
//     txtHeight = 1.0}) {
//   return Text(
//     text,
//     style: TextStyle(
//         decoration: decoration,
//         fontSize: fontSize,
//         fontStyle: FontStyle.normal,
//         color: fontColor,
//         fontFamily: fontFamily,
//         height: txtHeight,
//         fontWeight: fontWeight),
//     textAlign: textAlign,
//     textScaleFactor: FetchPixels.getTextScale(),
//   );
// }
//
// double getButtonHeight() {
//   return FetchPixels.getPixelHeight(60);
// }
//
// double getEditHeight() {
//   return FetchPixels.getPixelHeight(60);
// }
//
// double getEditFontSize() {
//   return 15;
// }
//
// double getEditRadiusSize() {
//   return FetchPixels.getPixelHeight(12);
// }
//
// double getEditIconSize() {
//   return 24;
//   // return FetchPixels.getPixelHeight(24);
// }
//
// double getButtonCorners() {
//   return FetchPixels.getPixelHeight(12);
// }
//
// double getButtonFontSize() {
//   return 16;
// }
//
// ShapeDecoration getButtonDecoration(Color bgColor,
//     {withBorder = false,
//     Color borderColor = Colors.transparent,
//     bool withCorners = true,
//     double corner = 0,
//     double cornerSmoothing = 1.1,
//     List<BoxShadow> shadow = const []}) {
//   return ShapeDecoration(
//       color: bgColor,
//       shadows: shadow,
//       shape: SmoothRectangleBorder(
//           side: BorderSide(
//               width: 1, color: (withBorder) ? borderColor : Colors.transparent),
//           borderRadius: SmoothBorderRadius(
//               cornerRadius: (withCorners) ? corner : 0,
//               cornerSmoothing: (withCorners) ? cornerSmoothing : 0)));
// }
//
// Widget getCenterTitleHeader(BuildContext context, String title,
//     EdgeInsets edgeInsets, Function backClick,
//     {bool visibleMore = false,
//     String moreImg = "More.svg",
//     Function? moreFunc}) {
//   return getPaddingWidget(
//       edgeInsets,
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           getBackIcon(context, () {
//             backClick();
//           }),
//           Expanded(
//             child: getCustomFont(title, 22, getFontColor(context), 1,
//                 textAlign: TextAlign.center, fontWeight: FontWeight.w600),
//             flex: 1,
//           ),
//           Visibility(
//             visible: visibleMore,
//             maintainAnimation: true,
//             maintainState: true,
//             maintainSize: true,
//             child: getBackIcon(context, () {
//               moreFunc!();
//             }, icon: moreImg),
//           )
//         ],
//       ));
// }
//
// Widget topHeader(double horWidget, String txt, BuildContext context,
//     {bool showProfile = true}) {
//   return Row(
//     children: [
//       getHorSpace(horWidget),
//       getCustomFont(txt, 22, getFontColor(context), 1,
//           fontWeight: FontWeight.w600),
//       Expanded(
//         child: getHorSpace(0),
//         flex: 1,
//       ),
//       Visibility(
//           maintainState: true,
//           maintainSize: true,
//           maintainAnimation: true,
//           child: getCircleImage(
//               context, "Profile.png", FetchPixels.getPixelHeight(44)),
//           visible: showProfile),
//       getHorSpace(FetchPixels.getDefaultHorSpace(context))
//     ],
//   );
// }
//
// Widget getCircleImage(BuildContext context, String imgName, double size) {
//   return SizedBox(
//     width: size,
//     height: size,
//     child: ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(size / 2)),
//       child: getAssetImage(context, imgName, double.infinity, double.infinity),
//     ),
//   );
// }
//
// Widget getSvgImage(BuildContext context, String image, double size,
//     {Color? color}) {
//   var darkThemeProvider = Provider.of<DarkMode>(context);
//
//   return SvgPicture.asset(
//     ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
//             ? Constant.assetImagePathNight
//             : Constant.assetImagePath) +
//         image,
//     color: color,
//     width: FetchPixels.getPixelWidth(size),
//     // height: FetchPixels.getPixelWidth(size),
//
//     height: FetchPixels.getPixelHeight(size),
//     fit: BoxFit.fill,
//     // fit: BoxFit.fill,
//
//     // fit: BoxFit.fitHeight,
//   );
// }
// //
// // List<String> getAllAssetsList(BuildContext context) {
// //   // var config = new File('./assets/imagesNight/arrow_bottom.svg');
// //   // var str = config.exists();
// //   // print("setstrs===${str.asStream().isBroadcast}");
// //
// //   var manifestContent = DefaultAssetBundle.of(context).loadString('AssetManifest.json');
// //
// //   var manifestMap = json.decode(manifestContent.asStream().toString());
// //   var imagePetPaths = manifestMap.keys.where((key) => key.contains(Constant.assetImagePathNight));
// //
// //   // final manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
// //   // final images = json
// //   //     .decode(manifestJson)
// //   //     .keys
// //   //     .where((String key) => key.startsWith('assets/imagesNight'));
// //   return imagePetPaths;
// // }
//
// Widget getSvgImageWithSize(
//     BuildContext context, String image, double width, double height,
//     {Color? color, BoxFit fit = BoxFit.fill}) {
//   var darkThemeProvider = Provider.of<DarkMode>(context);
//   return SvgPicture.asset(
//     ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
//             ? Constant.assetImagePathNight
//             : Constant.assetImagePath) +
//         image,
//     color: color,
//     width: width,
//     height: height,
//     fit: fit,
//   );
// }
//
// Widget getProfileTopView(
//   BuildContext context,
//   Function backClick,
//   String title, {
//   bool visibleMore = false,
//   Function? moreFunc,
//   bool visibleEdit = false,
//   Function? funcEdit,
// }) {
//   double horSpace = FetchPixels.getDefaultHorSpace(context);
//   return SizedBox(
//     height: FetchPixels.getPixelHeight(223 + 9),
//     child: Stack(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: FetchPixels.getPixelHeight(201),
//           child: getSvgImage(
//             context,
//             "profile_rect.svg",
//             double.infinity,
//           ),
//         ),
//         getCenterTitleHeader(
//             context,
//             title,
//             EdgeInsets.only(
//                 left: horSpace,
//                 right: horSpace,
//                 top: Constant.getToolbarTopHeight(context) +
//                     FetchPixels.getPixelHeight(10)), () {
//           backClick();
//         }, visibleMore: visibleMore, moreFunc: moreFunc),
//         Padding(
//           padding: EdgeInsets.only(left: horSpace),
//           child: Align(
//             alignment: Alignment.bottomLeft,
//             child: SizedBox(
//               width: FetchPixels.getPixelHeight(120),
//               height: FetchPixels.getPixelHeight(120),
//               child: Stack(
//                 children: [
//                   getCircleImage(
//                       context, "profile_Setting.png", double.infinity),
//                   Visibility(
//                     visible: visibleEdit,
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: InkWell(
//                         onTap: () {
//                           funcEdit!();
//                         },
//                         child: getSvgImageWithSize(
//                             context,
//                             "edit_icon.svg",
//                             FetchPixels.getPixelHeight(36),
//                             FetchPixels.getPixelHeight(36)),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// Widget getBackIcon(BuildContext context, Function function,
//     {String icon = "arrow_left.svg"}) {
//   return InkWell(
//       onTap: () {
//         function();
//       },
//       child: getSvgImageWithSize(context, icon, FetchPixels.getPixelHeight(19),
//           FetchPixels.getPixelHeight(21)));
// }
//
// Widget getAssetImage(
//     BuildContext context, String image, double width, double height,
//     {Color? color, BoxFit boxFit = BoxFit.contain}) {
//   var darkThemeProvider = Provider.of<DarkMode>(context);
//   return Image.asset(
//     ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
//             ? Constant.assetImagePathNight
//             : Constant.assetImagePath) +
//         image,
//     color: color,
//     width: width,
//     height: height,
//     fit: boxFit,
//     scale: FetchPixels.getScale(),
//   );
// }
//
// Widget getDialogDividerBottom(BuildContext context) {
//   return Container(
//     width: FetchPixels.getPixelWidth(134),
//     decoration: getButtonDecoration(getFontColor(context),
//         withCorners: true,
//         withBorder: false,
//         corner: FetchPixels.getPixelHeight(5)),
//     height: FetchPixels.getPixelHeight(5),
//   );
// }
//
// Widget getDialogDividerTop(BuildContext context) {
//   return Container(
//     width: FetchPixels.getPixelWidth(48),
//     decoration: getButtonDecoration(getCardColor(context),
//         withCorners: true,
//         withBorder: false,
//         corner: FetchPixels.getPixelHeight(4)),
//     height: FetchPixels.getPixelHeight(4),
//   );
// }
//
// Widget getDefaultTextFiled(BuildContext context, String s,
//     TextEditingController textEditingController, Color fontColor,
//     {bool withPrefix = false,
//     String imgName = "",
//     bool minLines = false,
//     EdgeInsetsGeometry margin = EdgeInsets.zero}) {
//   double height = getEditHeight();
//   FocusNode myFocusNode = FocusNode();
//   bool isAutoFocus = false;
//   return StatefulBuilder(
//     builder: (context, setState) {
//       final mqData = MediaQuery.of(context);
//       final mqDataNew =
//           mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//
//       return MediaQuery(
//         data: mqDataNew,
//         child: Container(
//           height: (minLines) ? (height * 2.2) : height,
//           margin: margin,
//           padding: EdgeInsets.symmetric(
//               horizontal: FetchPixels.getPixelWidth(18), vertical: 0),
//           alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
//           decoration: ShapeDecoration(
//             color: Colors.transparent,
//             shape: SmoothRectangleBorder(
//               side: BorderSide(
//                   color: isAutoFocus
//                       ? getAccentColor(context)
//                       : getCurrentTheme(context).focusColor,
//                   width: 1),
//               borderRadius: SmoothBorderRadius(
//                 cornerRadius: getEditRadiusSize(),
//                 cornerSmoothing: 0.8,
//               ),
//             ),
//           ),
//           child: Focus(
//               onFocusChange: (hasFocus) {
//                 if (hasFocus) {
//                   setState(() {
//                     isAutoFocus = true;
//                     myFocusNode.canRequestFocus = true;
//                   });
//                 } else {
//                   setState(() {
//                     isAutoFocus = false;
//                     myFocusNode.canRequestFocus = false;
//                   });
//                 }
//               },
//               child: SizedBox(
//                 height:double.infinity,
//                 child: (minLines)?TextField(
//                   // minLines: null,
//                   // maxLines: null,
//                   maxLines: (minLines) ? null : 1,
//                   controller: textEditingController,
//                   autofocus: false,
//                   focusNode: myFocusNode,
//                   textAlign: TextAlign.start,
//                   // expands: true,
//                   expands:minLines,
//                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
//                   style: TextStyle(
//                       fontFamily: fontFamily,
//                       color: fontColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: getEditFontSize()),
//                   decoration: InputDecoration(
//                       prefixIconConstraints: const BoxConstraints(
//                         minWidth: 0,
//                         minHeight: 0,
//                       ),
//                       // filled: true,
//                       // fillColor: Colors.green,
//                       prefixIcon  : (withPrefix)
//                           ? Padding(
//                         padding: EdgeInsets.only(
//                             right: FetchPixels.getPixelWidth(3)),
//                         child: getSvgImage(
//                             context, imgName, getEditIconSize()),
//                       )
//                           : getHorSpace(0),
//                       border: InputBorder.none,
//                       isDense: true,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       hintText: s,
//                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
//                       hintStyle: TextStyle(
//                           fontFamily: fontFamily,
//                           color: getFontHint(context),
//                           fontWeight: FontWeight.w400,
//                           fontSize: getEditFontSize())),
//                 ):Center(child: TextField(
//                   // minLines: null,
//                   // maxLines: null,
//                   maxLines: (minLines) ? null : 1,
//                   controller: textEditingController,
//                   autofocus: false,
//                   focusNode: myFocusNode,
//                   textAlign: TextAlign.start,
//                   // expands: true,
//                   expands:minLines,
//                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
//                   style: TextStyle(
//                       fontFamily: fontFamily,
//                       color: fontColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: getEditFontSize()),
//                   decoration: InputDecoration(
//                       prefixIconConstraints: const BoxConstraints(
//                         minWidth: 0,
//                         minHeight: 0,
//                       ),
//                       // filled: true,
//                       // fillColor: Colors.green,
//                       prefixIcon  : (withPrefix)
//                           ? Padding(
//                         padding: EdgeInsets.only(
//                             right: FetchPixels.getPixelWidth(3)),
//                         child: getSvgImage(
//                             context, imgName, getEditIconSize()),
//                       )
//                           : getHorSpace(0),
//                       border: InputBorder.none,
//                       isDense: true,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       hintText: s,
//                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
//                       hintStyle: TextStyle(
//                           fontFamily: fontFamily,
//                           color: getFontHint(context),
//                           fontWeight: FontWeight.w400,
//                           fontSize: getEditFontSize())),
//                 )),
//                 // child: MediaQuery(
//                 //   data: mqDataNew,
//                   // child: IntrinsicHeight(
//                   // child: IntrinsicHeight(
//                   //   child: Align(
//                   //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
//                     // ),
//                   // ),
//                 // ),
//               )),
//             // child: MediaQuery(
//             //     data: mqDataNew,
//             //     child: Container(
//             //       height:double.infinity,
//             //       // color: Colors.red,
//             //       child: IntrinsicHeight(
//             //         // child: IntrinsicHeight(
//             //         child: TextField(
//             //           maxLines: (minLines) ? null : 1,
//             //           controller: textEditingController,
//             //           autofocus: false,
//             //           focusNode: myFocusNode,
//             //           textAlign: TextAlign.start,
//             //           // textAlignVertical: TextAlignVertical.center,
//             //           style: TextStyle(
//             //               fontFamily: fontFamily,
//             //               color: fontColor,
//             //               fontWeight: FontWeight.w400,
//             //               fontSize: getEditFontSize()),
//             //           decoration: InputDecoration(
//             //               prefixIconConstraints: const BoxConstraints(
//             //                 minWidth: 0,
//             //                 minHeight: 0,
//             //               ),
//             //               // filled: true,
//             //               // fillColor: Colors.green,
//             //               prefixIcon: (withPrefix)
//             //                   ? Padding(
//             //                 padding: EdgeInsets.only(
//             //                     right: FetchPixels.getPixelWidth(3)),
//             //                 child: getSvgImage(
//             //                     context, imgName, getEditIconSize()),
//             //               )
//             //                   : getHorSpace(0),
//             //               border: InputBorder.none,
//             //               isDense: true,
//             //               focusedBorder: InputBorder.none,
//             //               enabledBorder: InputBorder.none,
//             //               errorBorder: InputBorder.none,
//             //               disabledBorder: InputBorder.none,
//             //               hintText: s,
//             //               // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
//             //               hintStyle: TextStyle(
//             //                   fontFamily: fontFamily,
//             //                   color: getFontHint(context),
//             //                   fontWeight: FontWeight.w400,
//             //                   fontSize: getEditFontSize())),
//             //         ),
//             //         // ),
//             //       ),
//             //     ))),
//
//         ),
//       );
//     },
//   );
// }
//
// Widget getDefaultCountryPickerTextFiled(BuildContext context, String s,
//     TextEditingController textEditingController, Color fontColor,
//     {bool withPrefix = false,
//     String imgName = "",
//     bool minLines = false,
//     EdgeInsetsGeometry margin = EdgeInsets.zero}) {
//   double height = getEditHeight();
//
//   FocusNode myFocusNode = FocusNode();
//   bool isAutoFocus = false;
//   return StatefulBuilder(
//     builder: (context, setState) {
//       final mqData = MediaQuery.of(context);
//       final mqDataNew =
//           mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//
//       return Container(
//         height: (minLines) ? (height * 2.2) : height,
//         margin: margin,
//         padding: EdgeInsets.symmetric(
//           horizontal: FetchPixels.getPixelWidth(18),
//         ),
//         alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
//         decoration: ShapeDecoration(
//           color: Colors.transparent,
//           shape: SmoothRectangleBorder(
//             side: BorderSide(
//                 color: isAutoFocus
//                     ? getAccentColor(context)
//                     : getCurrentTheme(context).focusColor,
//                 width: 1),
//             borderRadius: SmoothBorderRadius(
//               cornerRadius: getEditRadiusSize(),
//               cornerSmoothing: 0.8,
//             ),
//           ),
//         ),
//         child: Focus(
//             onFocusChange: (hasFocus) {
//               if (hasFocus) {
//                 setState(() {
//                   isAutoFocus = true;
//                   myFocusNode.canRequestFocus = true;
//                 });
//               } else {
//                 setState(() {
//                   isAutoFocus = false;
//                   myFocusNode.canRequestFocus = false;
//                 });
//               }
//             },
//             child: MediaQuery(
//               data: mqDataNew,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CountryCodePicker(
//                     onChanged: print,
//                     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                     initialSelection: 'IN',
//                     flagWidth: FetchPixels.getPixelWidth(24),
//                     padding: EdgeInsets.zero,
//                     textStyle: TextStyle(
//                         fontFamily: fontFamily,
//                         color: fontColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: getEditFontSize()),
//                     favorite: const ['+91', 'IN'],
//                     // optional. Shows only country name and flag
//                     showCountryOnly: false,
//                     showDropDownButton: true,
//
//                     // optional. Shows only country name and flag when popup is closed.
//                     showOnlyCountryWhenClosed: false,
//                     // optional. aligns the flag and the Text left
//                     alignLeft: false,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       maxLines: (minLines) ? null : 1,
//                       controller: textEditingController,
//                       autofocus: false,
//                       focusNode: myFocusNode,
//                       textAlign: TextAlign.start,
//                       // textAlignVertical: TextAlignVertical.center,
//                       style: TextStyle(
//                           fontFamily: fontFamily,
//                           color: fontColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: getEditFontSize()),
//                       decoration: InputDecoration(
//                           prefixIcon: (withPrefix)
//                               ? Padding(
//                                   padding: EdgeInsets.only(
//                                       right: FetchPixels.getPixelWidth(3)),
//                                   child: getSvgImage(
//                                       context, imgName, getEditIconSize()),
//                                 )
//                               : const SizedBox(
//                                   width: 0,
//                                   height: 0,
//                                 ),
//                           border: InputBorder.none,
//                           isDense: true,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                           hintText: s,
//                           prefixIconConstraints:
//                               const BoxConstraints(minHeight: 0, minWidth: 0),
//                           hintStyle: TextStyle(
//                               fontFamily: fontFamily,
//                               color: getFontHint(context),
//                               fontWeight: FontWeight.w400,
//                               fontSize: getEditFontSize())),
//                     ),
//                     flex: 1,
//                   )
//                 ],
//               ),
//             )),
//       );
//     },
//   );
// }
//
// getProgressDialog() {
//   return Container(
//       color: Colors.transparent,
//       child: Center(
//           child: Theme(
//               data: ThemeData(
//                   cupertinoOverrideTheme:
//                       const CupertinoThemeData(brightness: Brightness.dark)),
//               child: const CupertinoActivityIndicator())));
// }
//
// Widget getPassTextFiled(
//     BuildContext context,
//     String s,
//     TextEditingController textEditingController,
//     Color fontColor,
//     bool showPass,
//     Function function,
//     {bool withPrefix = false,
//     String imgName = "",
//     bool minLines = false,
//     EdgeInsetsGeometry margin = EdgeInsets.zero}) {
//   double height = getEditHeight();
//
//   FocusNode myFocusNode = FocusNode();
//   bool isAutoFocus = false;
//
//   final mqData = MediaQuery.of(context);
//   final mqDataNew =
//       mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//   return StatefulBuilder(
//     builder: (context, setState) {
//       return Container(
//         height: (minLines) ? (height * 2.2) : height,
//         margin: margin,
//         padding: EdgeInsets.symmetric(
//           horizontal: FetchPixels.getPixelWidth(18),
//         ),
//         alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
//         decoration: getButtonDecoration(Colors.transparent,
//             withBorder: true,
//             borderColor: isAutoFocus
//                 ? getAccentColor(context)
//                 : getCurrentTheme(context).focusColor,
//             corner: getEditRadiusSize(),
//             withCorners: true,
//             cornerSmoothing: 0.8),
//         child: Focus(
//           onFocusChange: (hasFocus) {
//             if (hasFocus) {
//               setState(() {
//                 isAutoFocus = true;
//                 myFocusNode.canRequestFocus = true;
//               });
//             } else {
//               setState(() {
//                 isAutoFocus = false;
//                 myFocusNode.canRequestFocus = false;
//               });
//             }
//           },
//           child: Row(
//             children: [
//               Expanded(
//                 child: MediaQuery(
//                   child: TextField(
//                     maxLines: (minLines) ? null : 1,
//                     obscureText: (showPass) ? false : true,
//                     controller: textEditingController,
//                     autofocus: false,
//                     focusNode: myFocusNode,
//                     textAlign: TextAlign.start,
//                     // textAlignVertical: TextAlignVertical.center,
//                     style: TextStyle(
//                         fontFamily: fontFamily,
//                         color: fontColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: getEditFontSize()),
//                     decoration: InputDecoration(
//                         prefixIcon: (withPrefix)
//                             ? Padding(
//                                 padding: EdgeInsets.only(
//                                     right: FetchPixels.getPixelWidth(3)),
//                                 child: getSvgImage(
//                                     context, imgName, getEditIconSize()),
//                               )
//                             : const SizedBox(
//                                 width: 0,
//                                 height: 0,
//                               ),
//                         border: InputBorder.none,
//                         isDense: true,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         hintText: s,
//                         prefixIconConstraints:
//                             const BoxConstraints(minHeight: 0, minWidth: 0),
//                         hintStyle: TextStyle(
//                             fontFamily: fontFamily,
//                             color: getFontHint(context),
//                             fontWeight: FontWeight.w400,
//                             fontSize: getEditFontSize())),
//                   ),
//                   data: mqDataNew,
//                 ),
//                 flex: 1,
//               ),
//               InkWell(
//                   onTap: () {
//                     function();
//                   },
//                   child: getSvgImage(context, "Eye.svg", getEditIconSize()))
//               // color: Colors.grey))
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
// Widget getMediaQueryWidget(BuildContext context, Widget widget) {
//   final mqData = MediaQuery.of(context);
//   final mqDataNew =
//       mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//   return MediaQuery(child: widget, data: mqDataNew);
// }
//
// Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
//   return Padding(
//     padding: edgeInsets,
//     child: widget,
//   );
// }
//
// AppBar getInVisibleAppBar({Color color = Colors.transparent}) {
//   return AppBar(
//     toolbarHeight: 0,
//     elevation: 0,
//     backgroundColor: color,
//   );
// }
//
// Widget getSettingRow(
//     BuildContext context, String image, String name, Function function,
//     {bool withSwitch = false,
//     ValueChanged<bool>? onToggle,
//     bool checked = false}) {
//   double horSpace = FetchPixels.getPixelWidth(16);
//   double iconSize = FetchPixels.getPixelHeight(24);
//   return Container(
//     width: double.infinity,
//     height: getButtonHeight(),
//     margin: EdgeInsets.symmetric(
//         horizontal: FetchPixels.getPixelWidth(20),
//         vertical: FetchPixels.getPixelHeight(10)),
//     decoration: getButtonDecoration(
//         getCurrentTheme(context).dialogBackgroundColor,
//         withCorners: true,
//         corner: getButtonCorners(),
//         withBorder: false,
//         shadow: [
//           BoxShadow(
//               color: getCurrentTheme(context).shadowColor,
//               offset: const Offset(-5, 6),
//               blurRadius: 40)
//         ]),
//     child: InkWell(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           getHorSpace(horSpace),
//           getSvgImageWithSize(
//             context,
//             image,
//             iconSize,
//             iconSize,
//           ),
//           getHorSpace(FetchPixels.getPixelWidth(6)),
//           Expanded(
//             child: getCustomFont(name, 16, getFontColor(context), 1,
//                 fontWeight: FontWeight.w400),
//             flex: 1,
//           ),
//           (withSwitch)
//               ? FlutterSwitch(
//                   value: checked,
//                   padding: 0.5,
//                   inactiveColor: getCardColor(context),
//                   activeColor: getAccentColor(context),
//                   inactiveToggleColor: purpleColor,
//                   width: FetchPixels.getPixelHeight(67),
//                   height: FetchPixels.getPixelHeight(35),
//                   onToggle: onToggle!,
//                 )
//               : getSvgImageWithSize(
//                   context,
//                   "arrow_right.svg",
//                   iconSize,
//                   iconSize,
//                 ),
//           getHorSpace(horSpace),
//         ],
//       ),
//       onTap: () {
//         function();
//       },
//     ),
//   );
// }
//
// Widget getButton(
//     BuildContext context,
//     Color bgColor,
//     bool withCorners,
//     String text,
//     Color textColor,
//     Function function,
//     EdgeInsetsGeometry insetsGeometry,
//     {isBorder = false,
//     borderColor = Colors.transparent,
//     FontWeight weight = FontWeight.w600,
//     bool isIcon = false,
//     String? icons,
//     List<BoxShadow> shadow = const []}) {
//   double buttonHeight = getButtonHeight();
//   double fontSize = getButtonFontSize();
//   return InkWell(
//     onTap: () {
//       function();
//     },
//     child: Container(
//       margin: insetsGeometry,
//       width: double.infinity,
//       height: buttonHeight,
//       decoration: getButtonDecoration(bgColor,
//           withCorners: withCorners,
//           corner: (withCorners) ? getButtonCorners() : 0,
//           withBorder: isBorder,
//           borderColor: borderColor,
//           shadow: shadow),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           (isIcon)
//               ? getSvgImage(context, icons ?? "", getEditIconSize())
//               : getHorSpace(0),
//           (isIcon)
//               ? getHorSpace(FetchPixels.getPixelWidth(10))
//               : getHorSpace(0),
//           getCustomFont(
//             text,
//             fontSize,
//             textColor,
//             1,
//             textAlign: TextAlign.center,
//             fontWeight: weight,
//           )
//         ],
//       ),
//     ),
//   );
// }
//
// Widget getButtonWithEndIcon(
//     BuildContext context,
//     Color bgColor,
//     bool withCorners,
//     String text,
//     Color textColor,
//     Function function,
//     EdgeInsetsGeometry insetsGeometry,
//     {isBorder = false,
//     borderColor = Colors.transparent,
//     FontWeight weight = FontWeight.w600,
//     bool isIcon = false,
//     String? icons,
//     List<BoxShadow> shadow = const []}) {
//   double buttonHeight = getButtonHeight();
//   double fontSize = getButtonFontSize();
//   return InkWell(
//     onTap: () {
//       function();
//     },
//     child: Container(
//       margin: insetsGeometry,
//       width: double.infinity,
//       height: buttonHeight,
//       decoration: getButtonDecoration(bgColor,
//           withCorners: withCorners,
//           corner: (withCorners) ? getButtonCorners() : 0,
//           withBorder: isBorder,
//           borderColor: borderColor,
//           shadow: shadow),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           getHorSpace(FetchPixels.getPixelWidth(10)),
//           Expanded(
//             child: getCustomFont(
//               text,
//               fontSize,
//               textColor,
//               1,
//               textAlign: TextAlign.start,
//               fontWeight: weight,
//             ),
//             flex: 1,
//           ),
//           (isIcon)
//               ? getSvgImage(context, icons ?? "", getEditIconSize())
//               : getHorSpace(0),
//           getHorSpace(FetchPixels.getPixelWidth(10))
//         ],
//       ),
//     ),
//   );
// }
//
// Widget getSubButton(
//     BuildContext context,
//     Color bgColor,
//     bool withCorners,
//     String text,
//     Color textColor,
//     Function function,
//     EdgeInsetsGeometry insetsGeometry,
//     {isBorder = false,
//     double width = double.infinity,
//     borderColor = Colors.transparent,
//     FontWeight weight = FontWeight.w600,
//     bool isIcon = false,
//     String? icons}) {
//   double buttonHeight = FetchPixels.getPixelHeight(40);
//   double buttonCorner = FetchPixels.getPixelHeight(10);
//   return InkWell(
//     onTap: () {
//       function();
//     },
//     child: Container(
//       margin: insetsGeometry,
//       width: width,
//       height: buttonHeight,
//       decoration: getButtonDecoration(bgColor,
//           withCorners: withCorners,
//           corner: (withCorners) ? buttonCorner : 0,
//           withBorder: isBorder,
//           borderColor: borderColor),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           (isIcon)
//               ? getSvgImage(context, icons ?? "", getEditIconSize())
//               : getHorSpace(0),
//           (isIcon)
//               ? getHorSpace(FetchPixels.getPixelWidth(10))
//               : getHorSpace(0),
//           // Text("wruiewru"),
//           getCustomFont(
//             text,
//             13,
//             textColor,
//             1,
//             textAlign: TextAlign.center,
//             fontWeight: weight,
//           )
//         ],
//       ),
//     ),
//   );
// }
//
// Widget getCircularImage(BuildContext context, double width, double height,
//     double radius, String img,
//     {BoxFit boxFit = BoxFit.contain}) {
//   return SizedBox(
//     height: height,
//     width: width,
//     child: ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(radius)),
//       child: getAssetImage(context, img, width, height, boxFit: boxFit),
//     ),
//   );
// }
//
// Widget getVerSpace(double verSpace) {
//   return SizedBox(
//     height: verSpace,
//   );
// }
//
// Widget getSearchWidget(
//     BuildContext context,
//     TextEditingController searchController,
//     Function filterClick,
//     ValueChanged<String> onChanged) {
//   double height = FetchPixels.getPixelHeight(56);
//   double iconSize = FetchPixels.getPixelHeight(16);
//   double fontSize = 16;
//
//   final mqData = MediaQuery.of(context);
//   final mqDataNew =
//       mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//
//   return Container(
//     width: double.infinity,
//     height: height,
//     padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(19)),
//     decoration: getButtonDecoration(Colors.transparent,
//         withCorners: true,
//         corner: FetchPixels.getPixelHeight(12),
//         withBorder: true,
//         borderColor: getCurrentTheme(context).hoverColor),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         getSvgImageWithSize(context, "Search.svg", iconSize, iconSize),
//         getHorSpace(FetchPixels.getPixelWidth(17.9)),
//         Expanded(
//           child: MediaQuery(
//               data: mqDataNew,
//               child: IntrinsicHeight(
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: onChanged,
//                   decoration: InputDecoration(
//                       isDense: true,
//                       hintText: "Search...",
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: fontSize,
//                           fontWeight: FontWeight.w400,
//                           color: getFontColor(context))),
//                   style: TextStyle(
//                       fontFamily: fontFamily,
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w400,
//                       color: getFontColor(context)),
//                   textAlign: TextAlign.start,
//                   maxLines: 1,
//                 ),
//               )),
//           flex: 1,
//         ),
//         getHorSpace(FetchPixels.getPixelWidth(3)),
//         InkWell(
//           child: getSvgImageWithSize(context, "filter.svg", iconSize, iconSize),
//           onTap: () {
//             filterClick();
//           },
//         )
//       ],
//     ),
//   );
// }
//
Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

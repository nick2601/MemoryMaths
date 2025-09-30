import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';

import '../../utility/global_constants.dart';
import '../soundPlayer/audio_file.dart';

class CommonClearButton extends StatelessWidget {
  final Function onTab;
  final double height;
  final String text;
  final double fontSize;
  final double? btnRadius;

  const CommonClearButton({
    Key? key,
    required this.onTab,
    required this.text,
    this.height = 112,
    this.btnRadius,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    // double radius = getCommonCalculatorRadius(context);
    double radius =
        btnRadius == null ? getCommonCalculatorRadius(context) : btnRadius;

    print("radius===$radius");
    return CommonTabAnimationView(
        onTab: () {
          onTab();

          audioPlayer.playTickSound();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            alignment: Alignment.center,
            // height: height,

            // decoration:getDefaultDecoration(
            //     bgColor: Colors.transparent,
            //     radius: radius,
            //     borderColor: Colors.black
            //     ,borderWidth: 1.2
            // ) ,
            decoration: getDefaultDecoration(
                // bgColor: "#FFDB7C".toColor(),
                bgColor: Colors.white,
                radius: radius,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                borderWidth: 1.2),
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 2), vertical: 2),

            child: Center(
              child: getTextWidget(
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  (text),
                  TextAlign.center,
                  (text == "-")
                      ? getPercentSize(height, 40)
                      : getPercentSize(height, 18)),
            ),
          ),
        ));

    // return CommonTabAnimationView(
    //   onTab: (){
    //     onTab();
    //     audioPlayer.playTickSound();
    //
    //   },
    //   child: Container(
    //     alignment: Alignment.center,
    //     decoration: getDefaultDecoration(
    //         isShadow:  themeMode==ThemeMode.light?true:false,
    //         shadowColor: getShadowColor(context),
    //         bgColor: getBgColor(themeProvider, Theme.of(context).scaffoldBackgroundColor),
    //         radius: radius),
    //     child: Center(
    //       child: getTextWidget(
    //           Theme.of(context)
    //               .textTheme
    //               .subtitle1!
    //               .copyWith(fontWeight: FontWeight.w500),
    //           (text),
    //           TextAlign.center,
    //           (text == "-")
    //               ? getPercentSize(height, 40)
    //               : getPercentSize(height, 15)),
    //     ),
    //   ),
    // );
  }
}

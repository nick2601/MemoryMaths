import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/soundPlayer/audio_file.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:tuple/tuple.dart';

class CommonNumberButton extends StatelessWidget {
  final Function onTab;
  final String text;

  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;
  final double? btnRadius;

  final Tuple2<GradientModel, int> colorTuple;

  const CommonNumberButton({
    Key? key,
    required this.text,
    required this.onTab,
    this.btnRadius,
    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.totalHeight = 24,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    double radius =
        btnRadius == null ? getCommonCalculatorRadius(context) : btnRadius;

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

            decoration: getDefaultDecoration(
                // bgColor: "#FFDB7C".toColor(),
                bgColor: colorTuple.item1.backgroundColor,
                radius: radius,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                borderWidth: 1.2),
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 2), vertical: 2),
            // decoration: getDefaultDecorationWithGradient(radius: radius,bgColor:
            // colorTuple.item1.primaryColor!,isShadow: true,colors: LinearGradient(
            //   colors:
            //   [ colorTuple.item1.primaryColor!,darken(colorTuple.item1.primaryColor!,0.1)],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // )),
            child: Center(
              child: getTextWidget(
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  text,
                  TextAlign.center,
                  getPercentSize(height, 28)),
            )),
      ),
    );
  }
}

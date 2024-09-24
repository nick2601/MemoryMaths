import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/ui/soundPlayer/audio_file.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonButton extends StatelessWidget {
  final Function onTab;
  final String text;

  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;
  final Color color;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onTab,
    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.color = Colors.red,
    this.totalHeight = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);
    double height1 = getScreenPercentSize(context, 57);
    double height = getScreenPercentSize(context, 57) / 4;

    double radius = getCommonRadius(context);

    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getPercentSize(height1, 2.5),
            horizontal: (getHorizontalSpace(context))),
        child: CommonTabAnimationView(
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
                    bgColor: color,
                    radius: radius,
                    borderColor: Theme.of(context).colorScheme.crossColor,
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
                          color: (color == Colors.red)
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                      text.capitalize(),
                      TextAlign.center,
                      getPercentSize(height, 20)),
                )),
          ),
        ),
      ),
    );

    // AudioPlayer audioPlayer = new AudioPlayer(context);
    //
    // double radius = getCommonRadius(context);
    //
    // return CommonTabAnimationView(
    //   onTab:(){
    //     onTab();
    //
    //     audioPlayer.playTickSound();
    //
    //
    //   },
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(radius),
    //     child: Container(
    //         alignment: Alignment.center,
    //         // height: height,
    //         decoration: getDefaultDecoration(radius: radius,bgColor: color,isShadow: true,),
    //         child: Stack(
    //           children: [
    //             Align(
    //               alignment: Alignment.centerRight,
    //               child: LayoutBuilder(builder: (context, constraints) {
    //                 return Transform.translate(
    //                   offset: Offset(-constraints.maxHeight / 2.1, 15),
    //                   child: Transform.scale(
    //                     scale: is4Matrix? constraints.maxHeight / 5:constraints.maxHeight / 20,
    //                     alignment: Alignment.topCenter,
    //                     child: getTextWidget(Theme.of(context).textTheme.subtitle1!.copyWith(
    //                       color: Colors.white.withOpacity(0.1)
    //                           ,fontWeight: FontWeight.bold
    //                     ),text,TextAlign.center,
    //                         is4Matrix? getPercentSize(height, 2):getPercentSize(height, 15)),
    //                   ),
    //                 );
    //               }),
    //             ),
    //             Align(
    //               alignment: Alignment.center,
    //               child: getTextWidget(Theme.of(context).textTheme.subtitle1!.copyWith(
    //                   color: (color == Colors.red)?Colors.white:Colors.black,
    //                 fontWeight: FontWeight.bold
    //               ),text.toUpperCase(),TextAlign.center,
    //                   getPercentSize(height, 15)
    //               ),
    //             ),
    //           ],
    //         )),
    //   ),
    // );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

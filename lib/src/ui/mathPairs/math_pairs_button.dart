import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../soundPlayer/audio_file.dart';

class MathPairsButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;

  MathPairsButton({
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    double radius = getPercentSize(height, 35);

    return AnimatedOpacity(
      opacity: mathPairs.isVisible ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          audioPlayer.playTickSound();
          context.read<MathPairsProvider>().checkResult(mathPairs, index);
        },
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          decoration: !mathPairs.isActive
              ? getDefaultDecorationWithBorder(
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: radius)
              : getDefaultDecorationWithGradient(
                  radius: radius,
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  // bgColor: colorTuple.item1
                  colors: LinearGradient(
                    colors: [colorTuple.item2, colorTuple.item2],
                    // colors: [lighten(colorTuple.item1,0.05), darken(colorTuple.item1,0.05)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),

          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(24)),
          //   border: mathPairs.isActive
          //       ? null
          //       : Border.all(color: colorTuple.item1),
          //   gradient: mathPairs.isActive
          //       ? LinearGradient(
          //           colors: [colorTuple.item1, colorTuple.item2],
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //         )
          //       : null,
          // ),

          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,

            child: getTextWidget(
                Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: mathPairs.isActive ? Colors.black : null,
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
                mathPairs.text,
                TextAlign.center,
                getPercentSize(height, 20)),
            // child: Text(
            //   mathPairs.text,
            //   style: Theme.of(context).textTheme.subtitle1!.copyWith(
            //       fontSize: 24,
            //       color: mathPairs.isActive
            //           ? Theme.of(context).colorScheme.baseColor
            //           : colorTuple.item1),
            // ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/concentration/concentration_provider.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../soundPlayer/audio_file.dart';

class ConcentrationButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final bool isContinue;

  ConcentrationButton({
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.isContinue,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    double radius = getPercentSize(height, 30);

    return AnimatedOpacity(
      opacity: mathPairs.isVisible ? 1 : 0,
      duration: Duration(milliseconds: 35),
      child: InkWell(
        onTap: () {
          if (isContinue) {
            audioPlayer.playTickSound();
            context.read<ConcentrationProvider>().checkResult(mathPairs, index);
          }
        },
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          decoration: !isContinue
              ? getDefaultDecorationWithBorder(
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: radius)
              : !mathPairs.isActive
                  ? getDefaultDecorationWithGradient(
                      radius: radius,
                      borderColor: Theme.of(context).textTheme.titleSmall!.color,
                      colors: LinearGradient(
                        colors: [colorTuple.item2, colorTuple.item2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ))
                  : getDefaultDecorationWithBorder(
                      borderColor: Theme.of(context).textTheme.titleSmall!.color,
                      radius: radius),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: getTextWidget(
                Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: !isContinue
                        ? null
                        : !mathPairs.isActive
                            ? Colors.transparent
                            : null,
                    fontWeight: FontWeight.bold),
                mathPairs.text,
                TextAlign.center,
                getPercentSize(height, 20)),
          ),
        ),
      ),
    );
  }
}

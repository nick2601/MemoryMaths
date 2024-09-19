import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PicturePuzzleAnswerButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final double width;

  PicturePuzzleAnswerButton({
    required this.picturePuzzleShape,
    required this.colorTuple,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<PicturePuzzleProvider, Tuple2<double, double>>(
      selector: (p0, p1) => Tuple2(p1.currentScore, p1.oldScore),
      builder: (context, tuple2, child) {
        return CommonWrongAnswerAnimationView(
          currentScore: tuple2.item1.toInt(),
          oldScore: tuple2.item2.toInt(),
          child: child!,
        );
      },
      child: Container(
        // width: double.infinity,

        decoration: getDefaultDecoration(
            borderColor: Theme.of(context).textTheme.subtitle2!.color,
            bgColor: lighten(colorTuple.item1),
            radius: getPercentSize(height, 20)),

        child: Selector<PicturePuzzleProvider, String>(
          selector: (p0, p1) => p1.result,
          builder: (context, value, child) => Center(
            child: getTextWidget(
                Theme.of(context).textTheme.subtitle2!.copyWith(

                    // color: value == ""
                    //     ? colorTuple.item2
                    //     : colorTuple.item2,
                    ),
                value == "" ? "?" : value,
                TextAlign.center,
                getPercentSize(height, 60)),
          ),
        ),
      ),
    );
  }
}

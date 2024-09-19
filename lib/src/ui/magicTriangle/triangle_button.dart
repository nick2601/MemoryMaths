import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/soundPlayer/audio_file.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;
  final bool is3x3;
  final Tuple2<Color, Color> colorTuple;

  const TriangleButton({
    Key? key,
    required this.colorTuple,
    required this.digit,
    required this.index,
    required this.is3x3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    double remainHeight = getRemainHeight(context: context);
    double height = remainHeight / 11;

    if (!is3x3) {
      height = remainHeight / 14;
    }
    double radius = getPercentSize(height, 25);

    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: InkWell(
        onTap: () {
          audioPlayer.playTickSound();
          context.read<MagicTriangleProvider>().checkResult(index, digit);
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: height,
          decoration: getDefaultDecorationWithBorder(
              radius: radius, borderColor: colorTuple.item1),
          alignment: Alignment.center,
          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
              digit.value,
              TextAlign.center,
              getPercentSize(height, 40)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import 'picture_puzzle_provider.dart';

class PicturePuzzleAnswerButton extends ConsumerWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final double width;
  final int level;

  const PicturePuzzleAnswerButton({
    Key? key,
    required this.picturePuzzleShape,
    required this.colorTuple,
    required this.height,
    required this.width,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(picturePuzzleProvider(level));
    final notifier = ref.read(picturePuzzleProvider(level).notifier);

    return CommonWrongAnswerAnimationView(
      currentScore: state.currentScore.toInt(),
      oldScore: 0, // Using 0 since we don't track oldScore in GameState
      child: Container(
        decoration: getDefaultDecoration(
          borderColor: Theme.of(context).textTheme.titleSmall!.color,
          bgColor: lighten(colorTuple.item1),
          radius: getPercentSize(height, 20),
        ),
        child: Center(
          child: getTextWidget(
            Theme.of(context).textTheme.titleSmall!,
            notifier.result.isEmpty ? "?" : notifier.result,
            TextAlign.center,
            getPercentSize(height, 60),
          ),
        ),
      ),
    );
  }
}
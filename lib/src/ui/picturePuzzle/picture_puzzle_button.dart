import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/picturePuzzle/circle_shape.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_answer_button.dart';
import 'package:mathsgames/src/ui/picturePuzzle/square_shape.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import 'triangle_shape.dart';

class PicturePuzzleButton extends ConsumerWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Color shapeColor;
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const PicturePuzzleButton({
    Key? key,
    required this.picturePuzzleShape,
    required this.shapeColor,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);
    double width = screenWidth / 15;

    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 2);
    }

    switch (picturePuzzleShape.type) {
      case PicturePuzzleQuestionItemType.shape:
        return Expanded(
          child: Center(
            child: CustomPaint(
              painter: picturePuzzleShape.shapeType == PicturePuzzleShapeType.circle
                  ? CircleShape(color: shapeColor, strokeWidth: 1)
                  : picturePuzzleShape.shapeType == PicturePuzzleShapeType.triangle
                  ? TriangleShape(shapeColor, 1)
                  : SquareShape(shapeColor, 1),
              size: Size(width, width),
            ),
          ),
        );

      case PicturePuzzleQuestionItemType.sign:
      case PicturePuzzleQuestionItemType.hint:
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            width: width,
            child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!,
              picturePuzzleShape.text,
              TextAlign.start,
              getPercentSize(width, 70),
            ),
          ),
        );

      case PicturePuzzleQuestionItemType.answer:
        return Expanded(
          child: SizedBox(
            height: width * 1.5,
            width: width,
            child: PicturePuzzleAnswerButton(
              picturePuzzleShape: picturePuzzleShape,
              colorTuple: colorTuple,
              height: width * 1.5,
              width: width,
              level: level,
            ),
          ),
        );
    }
  }
}

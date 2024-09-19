import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/picturePuzzle/circle_shape.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_answer_button.dart';
import 'package:mathsgames/src/ui/picturePuzzle/square_shape.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import 'triangle_shape.dart';

class PicturePuzzleButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Color shapeColor;
  final Tuple2<Color, Color> colorTuple;

  PicturePuzzleButton({
    required this.picturePuzzleShape,
    required this.shapeColor,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = getWidthPercentSize(context, 100) / 15;

    print("screenSize ====$screenWidth-----$screenHeight");
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 2);
    }

    switch (picturePuzzleShape.type) {
      case PicturePuzzleQuestionItemType.shape:
        return Expanded(
          flex: 1,
          child: Container(
            child: Center(
              child: CustomPaint(
                painter: picturePuzzleShape.picturePuzzleShapeType ==
                        PicturePuzzleShapeType.CIRCLE
                    ? CircleShape(shapeColor, 1)
                    : (picturePuzzleShape.picturePuzzleShapeType ==
                            PicturePuzzleShapeType.TRIANGLE
                        ? TriangleShape(shapeColor, 1)
                        : SquareShape(shapeColor, 1)),
                size: Size(width, width),
              ),
            ),
          ),
        );
      case PicturePuzzleQuestionItemType.sign:
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            width: width,

            child: getTextWidget(
                Theme.of(context).textTheme.subtitle2!,
                picturePuzzleShape.text,
                TextAlign.start,
                getPercentSize(width, 70)),
            // child: Text(
            //   picturePuzzleShape.text,
            //   style:
            //       Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 30),
            // ),
          ),
        );
      case PicturePuzzleQuestionItemType.hint:
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            width: width,

            child: getTextWidget(
                Theme.of(context).textTheme.subtitle2!,
                picturePuzzleShape.text,
                TextAlign.start,
                getPercentSize(width, 70)),

            // child: Text(
            //   picturePuzzleShape.text,
            //   style:
            //       Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
            // ),
          ),
        );
      case PicturePuzzleQuestionItemType.answer:
        return Expanded(
          flex: 1,
          child: Container(
            height: width * 1.5,
            width: width,
            child: PicturePuzzleAnswerButton(
                picturePuzzleShape: picturePuzzleShape,
                colorTuple: colorTuple,
                height: width * 1.5,
                width: width),
          ),
        );
    }
  }
}

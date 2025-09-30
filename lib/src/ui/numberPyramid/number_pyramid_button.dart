import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class PyramidNumberButton extends ConsumerWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;
  final double buttonHeight;
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const PyramidNumberButton({
    Key? key,
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required this.height,
    required this.buttonHeight,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(numberPyramidProvider(level).notifier);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = getWidthPercentSize(context, 100) / 8.5;
    double btnHeight = buttonHeight / 10;
    double fontSize = getPercentSize(btnHeight, 23);

    if (screenHeight < screenWidth) {
      fontSize = getPercentSize(btnHeight, 30);
    }

    return InkWell(
      onTap: () {
        notifier.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: numPyramidCellModel.isHint
              ? LinearGradient(
            colors: [colorTuple.item1, colorTuple.item1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
          color: numPyramidCellModel.isHint
              ? null
              : (numPyramidCellModel.isDone
              ? (numPyramidCellModel.isCorrect
              ? Colors.transparent
              : Colors.redAccent)
              : Colors.transparent),
          border: Border.all(
            color: numPyramidCellModel.isActive ? Colors.black : Colors.black,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(getPercentSize(height, 30)),
        ),
        child: getTextWidget(
          Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),
          numPyramidCellModel.isHidden
              ? numPyramidCellModel.text
              : numPyramidCellModel.numberOnCell.toString(),
          TextAlign.center,
          fontSize,
        ),
      ),
    );
  }
}
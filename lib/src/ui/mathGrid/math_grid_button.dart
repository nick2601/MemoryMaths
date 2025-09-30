import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/math_grid.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class MathGridButton extends ConsumerWidget {
  final MathGridCellModel gridModel;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final int level; // add level if your provider is family-based

  const MathGridButton({
    Key? key,
    required this.gridModel,
    required this.index,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;
    double fontSize = getPercentSize(width, 40);

    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 0.3);
      fontSize = getScreenPercentSize(context, 1.7);
    }

    Color color = colorTuple.item2;

    return Container(
      decoration: getDefaultDecoration(
        bgColor: gridModel.isRemoved
            ? Colors.transparent
            : gridModel.isActive
            ? Theme.of(context).scaffoldBackgroundColor
            : color,
        borderColor: Theme.of(context).textTheme.titleSmall!.color,
        radius: getScreenPercentSize(context, 2),
      ),
      child: Visibility(
        visible: !gridModel.isRemoved,
        child: InkWell(
          onTap: () {
            // call the notifier
            ref
                .read(mathGridProvider(level).notifier)
                .checkResult(index, gridModel);
          },
          child: Center(
            child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: gridModel.isActive
                    ? (Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white)
                    : Colors.black,
              ),
              gridModel.value.toString(),
              TextAlign.center,
              fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
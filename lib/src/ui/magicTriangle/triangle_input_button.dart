import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_traingle_view.dart';

class TriangleInputButton extends ConsumerWidget {
  final MagicTriangleInput input;
  final int index;
  final double cellHeight;
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const TriangleInputButton({
    Key? key,
    required this.input,
    required this.cellHeight,
    required this.index,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double radius = getPercentSize(cellHeight, 25);

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      onTap: () {
        ref
            .read(magicTriangleProvider(level).notifier)
            .inputTriangleSelection(index, input);
      },
      child: CommonTriangleView(
        isMargin: true,
        height: cellHeight,
        width: cellHeight,
        color: Colors.transparent,
        child: Container(
          decoration: input.value != null
              ? getDefaultDecorationWithGradient(
            radius: radius,
            colors: LinearGradient(
              colors: [
                lighten(colorTuple.item1, 0.05),
                colorTuple.item1,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )
              : getDefaultDecoration(
            radius: radius,
            bgColor: colorTuple.item2,
            borderColor: input.isActive ? colorTuple.item1 : null,
          ),
          alignment: Alignment.center,
          child: getTextWidget(
            Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            input.value.toString(),
            TextAlign.center,
            getPercentSize(cellHeight, 45),
          ),
        ),
      ),
    );
  }
}

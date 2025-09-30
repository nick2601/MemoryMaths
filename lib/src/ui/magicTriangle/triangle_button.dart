import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class TriangleButton extends ConsumerWidget {
  final MagicTriangleGrid digit;
  final int index;
  final bool is3x3;
  final Tuple2<Color, Color> colorTuple;
  final int level; // ✅ Added level to target the correct provider instance

  const TriangleButton({
    Key? key,
    required this.colorTuple,
    required this.digit,
    required this.index,
    required this.is3x3,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double remainHeight = getRemainHeight(context: context);
    double height = is3x3 ? remainHeight / 11 : remainHeight / 14;
    double radius = getPercentSize(height, 25);

    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: InkWell(
        onTap: () {
          // ✅ Call provider logic directly
          ref
              .read(magicTriangleProvider(level).notifier)
              .checkResult(index, digit);
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: height,
          decoration: getDefaultDecorationWithBorder(
            radius: radius,
            borderColor: colorTuple.item1,
          ),
          alignment: Alignment.center,
          child: getTextWidget(
            Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
            digit.value.toString(),
            TextAlign.center,
            getPercentSize(height, 40),
          ),
        ),
      ),
    );
  }
}
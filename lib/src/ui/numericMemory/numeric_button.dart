import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class NumericMemoryButton extends StatelessWidget {
  final NumericMemoryPair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final bool isContinue;
  final VoidCallback onTap; // safer than raw Function

  const NumericMemoryButton({
    Key? key,
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.isContinue,
    required this.colorTuple,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = getPercentSize(height, 35);

    final borderColor = Theme.of(context).textTheme.titleSmall!.color!;
    final checkState = mathPairs.options[index].isCheck;

    // Decide color based on state
    final color = checkState != null
        ? (checkState ? Colors.green : Colors.red)
        : Colors.transparent;

    return InkWell(
      onTap: () {
        if (isContinue) {
          onTap();
        }
      },
      child: Container(
        decoration: checkState == null
            ? !isContinue
            ? getDefaultDecorationWithBorder(
          borderColor: borderColor,
          radius: radius,
        )
            : getDefaultDecorationWithGradient(
          radius: radius,
          borderColor: borderColor,
          colors: LinearGradient(
            colors: [
              colorTuple.item1,
              colorTuple.item1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : getDefaultDecorationWithGradient(
          radius: radius,
          borderColor: borderColor,
          colors: LinearGradient(
            colors: [color, color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.center,
        child: getTextWidget(
          Theme.of(context).textTheme.titleMedium!.copyWith(
            color: checkState == null
                ? (!isContinue ? null : Colors.transparent)
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
          mathPairs.options[index].key!,
          TextAlign.center,
          getPercentSize(height, 20),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:tuple/tuple.dart';

class NumericMemoryButton extends StatelessWidget {
  final NumericMemoryPair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final bool isContinue;
  final Function function;

  NumericMemoryButton({
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.isContinue,
    required this.colorTuple,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    double radius = getPercentSize(height, 35);

    Color borderColor = Theme.of(context).textTheme.titleSmall!.color!;
    Color color = mathPairs.list[index].isCheck != null
        ? mathPairs.list[index].isCheck!
            ? Colors.green
            : Colors.red
        : Colors.transparent;
    return InkWell(
      onTap: () {
        print("isContinue123===$isContinue");
        if (isContinue) {
          function();
        }
      },
      child: Container(
        decoration: mathPairs.list[index].isCheck == null
            ? !isContinue
                ? getDefaultDecorationWithBorder(
                    borderColor: borderColor, radius: radius)
                : getDefaultDecorationWithGradient(
                    radius: radius,
                    borderColor: borderColor,
                    colors: LinearGradient(
                      colors: [
                        colorTuple.item1,
                        colorTuple.item1,
                        // lighten(colorTuple.item1, 0.05),
                        // darken(colorTuple.item1, 0.05)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ))
            : getDefaultDecorationWithGradient(
                radius: radius,
                borderColor: borderColor,
                colors: LinearGradient(
                  colors: [
                    // colorTuple.item1,
                    // colorTuple.item1,
                    color, color
                    // lighten(color, 0.05),
                    // darken(color, 0.05)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
        alignment: Alignment.center,
        child: getTextWidget(
            Theme.of(context).textTheme.titleMedium!.copyWith(
                color: mathPairs.list[index].isCheck == null
                    ? !isContinue
                        ? null
                        : Colors.transparent
                    : Colors.white,
                fontWeight: FontWeight.bold),
            mathPairs.list[index].key!,
            TextAlign.center,
            getPercentSize(height, 20)),
      ),
    );
  }
}

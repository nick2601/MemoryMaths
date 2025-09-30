import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class MathPairsButton extends ConsumerWidget {
  final Pair pair;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final int level;

  const MathPairsButton({
    Key? key,
    required this.pair,
    required this.index,
    required this.height,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = getPercentSize(height, 35);
    final textColor = Theme.of(context).textTheme.titleSmall?.color;

    return AnimatedOpacity(
      opacity: pair.isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          ref
              .read(mathPairsProvider(level).notifier)
              .checkResult(index);
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          alignment: Alignment.center,
          decoration: !pair.isActive
              ? getDefaultDecorationWithBorder(
            borderColor: textColor,
            radius: radius,
          )
              : getDefaultDecorationWithGradient(
            radius: radius,
            borderColor: textColor,
            colors: LinearGradient(
              colors: [colorTuple.item1, colorTuple.item2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: getTextWidget(
              Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: pair.isActive ? Colors.black : textColor,
              ),
              pair.text,
              TextAlign.center,
              getPercentSize(height, 20),
            ),
          ),
        ),
      ),
    );
  }
}
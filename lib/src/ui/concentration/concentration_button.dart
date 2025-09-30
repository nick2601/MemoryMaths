import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/concentration/concentration_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class ConcentrationButton extends ConsumerWidget {
  final Pair pair;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final bool isContinue;
  final int level; // ✅ new

  const ConcentrationButton({
    Key? key,
    required this.pair,
    required this.index,
    required this.height,
    required this.isContinue,
    required this.colorTuple,
    required this.level, // ✅ new
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = getPercentSize(height, 30);
    final textColor = Theme.of(context).textTheme.titleSmall?.color;

    return AnimatedOpacity(
      opacity: pair.isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 150),
      child: InkWell(
        onTap: () {
          if (isContinue) {
            ref
                .read(concentrationProvider(level).notifier) // ✅ pass level here
                .checkResult(index);
          }
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          alignment: Alignment.center,
          decoration: _buildDecoration(radius, textColor),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: getTextWidget(
              Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: !isContinue
                    ? textColor
                    : (!pair.isActive ? Colors.transparent : textColor),
              ) ??
                  const TextStyle(fontWeight: FontWeight.bold),
              pair.text,
              TextAlign.center,
              getPercentSize(height, 20),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds different decorations depending on state
  BoxDecoration _buildDecoration(double radius, Color? borderColor) {
    if (!isContinue) {
      return getDefaultDecorationWithBorder(
        borderColor: borderColor,
        radius: radius,
      );
    } else if (!pair.isActive) {
      return getDefaultDecorationWithGradient(
        radius: radius,
        borderColor: borderColor,
        colors: LinearGradient(
          colors: [colorTuple.item1, colorTuple.item2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    } else {
      return getDefaultDecorationWithBorder(
        borderColor: borderColor,
        radius: radius,
      );
    }
  }
}
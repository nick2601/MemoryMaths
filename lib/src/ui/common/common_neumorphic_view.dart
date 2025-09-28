import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonNeumorphicView extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool isLarge;
  final bool isMargin;
  final Color color;

  const CommonNeumorphicView({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.color = Colors.red,
    this.isLarge = false,
    this.isMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remainHeight = getRemainHeight(context: context);
    final defaultSize = getPercentSize(remainHeight, 8.5);

    // Use provided height or fallback
    final effectiveHeight = height ?? defaultSize;

    // Use provided width, fallback depends on isLarge
    final effectiveWidth = width ?? (isLarge ? null : defaultSize);

    return Container(
      height: effectiveHeight,
      width: effectiveWidth,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: isMargin
            ? getWidthPercentSize(context, 2)
            : (getHorizontalSpace(context) * 2.5),
      ),
      decoration: getDefaultDecoration(
        bgColor: color,
        borderColor: Theme.of(context).textTheme.titleSmall?.color,
        borderWidth: 1.3,
        radius: getPercentSize(effectiveHeight, 20),
      ),
      child: child,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonTriangleView extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool isLarge;
  final bool isMargin;
  final Color color;

  const CommonTriangleView({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.color = Colors.red,
    this.isLarge = false,
    this.isMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: isMargin ? 0 : getHorizontalSpace(context)),
      decoration: getDefaultDecoration(
          bgColor: lighten(color), radius: getPercentSize(height!, 20)),
      child: child,
    );
  }
}

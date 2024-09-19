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
    double remainHeight = getRemainHeight(context: context);
    double size = getPercentSize(remainHeight, 8.5);
    return Container(
      height: height == null ? size : height,
      width: width == null
          ? isLarge
              ? null
              : size
          : width,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: isMargin
              ? getWidthPercentSize(context, 2)
              : (getHorizontalSpace(context) * 2.5)),
      decoration: getDefaultDecoration(
          bgColor: color,
          borderColor: Theme.of(context).textTheme.subtitle2!.color,
          borderWidth: 1.3,
          radius: getPercentSize(height!, 20)),
      child: child,
    );
  }
}

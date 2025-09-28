import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonAlertDialog extends StatelessWidget {
  final Widget child;
  final bool isGameOver;
  final Color? bgColor;

  const CommonAlertDialog({
    Key? key,
    required this.child,
    this.isGameOver = false,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isGameOver ? 0 : getHorizontalSpace(context) * 2,
        ),
        decoration: getDefaultDecoration(
          radius: isGameOver ? 0 : getScreenPercentSize(context, 2),
          bgColor: bgColor ??
              (isGameOver
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).dialogBackgroundColor),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getHorizontalSpace(context),
          vertical: getScreenPercentSize(context, 1.8),
        ),
        child: child,
      ),
    );
  }
}
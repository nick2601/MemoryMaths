import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonAlertOverDialog extends StatelessWidget {
  final Widget child;
  final bool isGameOver;
  final Color? bgColor;

  const CommonAlertOverDialog({
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
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: getHorizontalSpace(context) * 2,
        ),
        decoration: BoxDecoration(
          color: bgColor ??
              (isGameOver
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).dialogBackgroundColor),
          borderRadius: BorderRadius.circular(
            isGameOver ? 0 : getScreenPercentSize(context, 2),
          ),
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
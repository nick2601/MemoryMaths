import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/global_constants.dart';

class CommonAlertDialog extends AlertDialog {
  final Widget child;
  final bool? isGameOver;
  final Color? bgColor;

  CommonAlertDialog({required this.child, this.isGameOver, this.bgColor})
      : super();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal:
                isGameOver == null ? getHorizontalSpace(context) * 2 : 0),
        decoration: getDefaultDecoration(
            radius: isGameOver == null ? getScreenPercentSize(context, 2) : 0,
            bgColor: isGameOver == null
                ? Theme.of(context).dialogBackgroundColor
                : Theme.of(context).scaffoldBackgroundColor),
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontalSpace(context),
            vertical: getScreenPercentSize(context, 1.8)),
        child: child,
      ),
    );
  }
}

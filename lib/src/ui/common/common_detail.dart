import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonDetail extends StatelessWidget {
  final int right;
  final int wrong;
  final bool center;

  const CommonDetail({
    Key? key,
    this.right = 0,
    this.wrong = 0,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment:
      center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        getTextWidget(
          textStyle,
          'Right: $right',
          TextAlign.center,
          getScreenPercentSize(context, 2),
        ),
        SizedBox(height: getScreenPercentSize(context, 0.7)),
        getTextWidget(
          textStyle.copyWith(color: Colors.redAccent),
          'Wrong: $wrong',
          TextAlign.center,
          getScreenPercentSize(context, 2),
        ),
      ],
    );
  }
}
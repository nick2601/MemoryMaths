import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonDetail extends StatelessWidget {
  final int? right;
  final int? wrong;

  const CommonDetail({
    Key? key,
    required this.right,
    required this.wrong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTextWidget(Theme.of(context).textTheme.subtitle2!, 'Right: $right',
            TextAlign.center, getScreenPercentSize(context, 2)),
        SizedBox(
          height: getScreenPercentSize(context, 0.7),
        ),
        getTextWidget(Theme.of(context).textTheme.subtitle2!, 'Wrong: $wrong',
            TextAlign.center, getScreenPercentSize(context, 2)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback onTab;
  final double height;
  final double? btnRadius;

  const CommonBackButton({
    Key? key,
    required this.onTab,
    this.btnRadius,
    this.height = 112,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = btnRadius ?? getCommonCalculatorRadius(context);

    return CommonTabAnimationView(
      onTab: () {
        onTab();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: getWidthPercentSize(context, 2),
            vertical: 2,
          ),
          decoration: getDefaultDecoration(
            bgColor: Theme.of(context).scaffoldBackgroundColor,
            radius: radius,
            borderColor: Theme.of(context).dividerColor,
            borderWidth: 1.2,
          ),
          child: Icon(
            Icons.backspace,
            size: getPercentSize(height, 20),
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
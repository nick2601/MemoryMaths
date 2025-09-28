import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonClearButton extends StatelessWidget {
  final VoidCallback onTab;
  final double height;
  final String text;
  final double fontSize;
  final double? btnRadius;

  const CommonClearButton({
    Key? key,
    required this.onTab,
    required this.text,
    this.height = 112,
    this.btnRadius,
    this.fontSize = 14,
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
          child: Center(
            child: getTextWidget(
              Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              text,
              TextAlign.center,
              text == "-"
                  ? getPercentSize(height, 40)
                  : getPercentSize(height, 18),
            ),
          ),
        ),
      ),
    );
  }
}
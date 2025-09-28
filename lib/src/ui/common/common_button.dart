import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final Color color;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onTab,
    this.is4Matrix = false,
    this.fontSize = 24,
    this.height = 112,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = getCommonRadius(context);

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
            vertical: getPercentSize(height, 2),
          ),
          decoration: getDefaultDecoration(
            bgColor: color,
            radius: radius,
            borderColor: Theme.of(context).dividerColor,
            borderWidth: 1.2,
          ),
          child: Center(
            child: getTextWidget(
              Theme.of(context).textTheme.titleMedium!.copyWith(
                color: color == Colors.red
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
                fontWeight: FontWeight.bold,
              ),
              text.capitalize(),
              TextAlign.center,
              fontSize,
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
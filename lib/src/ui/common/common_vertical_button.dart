import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class CommonVerticalButton extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;
  final bool isNumber;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonVerticalButton({
    Key? key,
    required this.text,
    required this.onTab,
    this.isNumber = false,
    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.totalHeight = 24,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height1 = getScreenPercentSize(context, 57);
    final double btnHeight = height1 / 4;
    final double radius = getCommonRadius(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: getPercentSize(height1, 2.5),
          horizontal: getHorizontalSpace(context),
        ),
        child: CommonTabAnimationView(
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
                bgColor: colorTuple.item1.backgroundColor,
                radius: radius,
                borderColor: Theme.of(context).colorScheme.crossColor,
                borderWidth: 1.2,
              ),
              child: Center(
                child: getTextWidget(
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  text,
                  TextAlign.center,
                  getPercentSize(
                    btnHeight,
                    isNumber ? 20 : 28,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:tuple/tuple.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTab;
  final Tuple2<Color, Color> colorTuple;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CommonTextButton({
    Key? key,
    required this.text,
    required this.onTab,
    required this.colorTuple,
    this.fontSize = 24,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTabAnimationView(
      onTab: onTab,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 2,
        margin: EdgeInsets.zero, // avoid extra spacing
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            gradient: LinearGradient(
              colors: [colorTuple.item1, colorTuple.item2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: padding,
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
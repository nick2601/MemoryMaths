import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

class CommonDualButton extends StatelessWidget {
  final String text;
  final bool is4Matrix;
  final double totalHeight;
  final double height;
  final VoidCallback onTab;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualButton({
    Key? key,
    required this.text,
    required this.is4Matrix,
    required this.totalHeight,
    required this.height,
    required this.onTab,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.all(getScreenPercentSize(context, 1)),
        height: height,
        decoration: BoxDecoration(
          color: colorTuple.item1.cellColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: getTextWidget(
          Theme.of(context).textTheme.titleMedium!,
          text,
          TextAlign.center,
          getScreenPercentSize(context, 2.5),
        ),
      ),
    );
  }
}

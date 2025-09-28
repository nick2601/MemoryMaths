import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class CommonGameExitDialogView extends StatelessWidget {
  final double score;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonGameExitDialogView({
    Key? key,
    required this.score,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final iconSize = getScreenPercentSize(context, 3);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button (top-right)
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: SvgPicture.asset(
              AppAssets.assetPath + colorTuple.item1.folderName! + AppAssets.closeIcon, // Corrected path
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),

        SizedBox(height: getScreenPercentSize(context, 1.8)),

        // Title
        getTextWidget(
          theme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          "Quit Game?",
          TextAlign.center,
          getScreenPercentSize(context, 2.5),
        ),

        SizedBox(height: getScreenPercentSize(context, 1.5)),

        // Message
        getTextWidget(
          theme.bodyLarge!.copyWith(fontWeight: FontWeight.w400),
          "Are you sure you want to quit the game?",
          TextAlign.center,
          getScreenPercentSize(context, 2.2),
        ),

        SizedBox(height: getScreenPercentSize(context, 3)),

        // Buttons
        Row(
          children: [
            Expanded(
              child: getButtonWidget(
                context,
                "Yes",
                colorTuple.item1.primaryColor!,
                () => Navigator.pop(context, true),
                textColor: darken(colorTuple.item1.primaryColor!),
                // isBorder: true, // Removed this line
              ),
            ),
            SizedBox(width: getWidthPercentSize(context, 3)),
            Expanded(
              child: getButtonWidget(
                context,
                "No",
                colorTuple.item1.primaryColor!,
                () => Navigator.pop(context, false),
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
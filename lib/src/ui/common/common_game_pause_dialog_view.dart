import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:mathsgames/src/utility/dialog_info_util.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class CommonGamePauseDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final double score;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonGamePauseDialogView({
    required this.gameCategoryType,
    required this.score,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = getScreenPercentSize(context, 3);
    final GameInfoDialog gameInfoDialog =
    DialogInfoUtil.getInfoDialogData(gameCategoryType);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              "${colorTuple.item1.folderName ?? ''}${AppAssets.closeIcon}",
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
        SizedBox(height: getScreenPercentSize(context, 1.8)),

        // Title
        getTextWidget(
          Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          gameInfoDialog.title,
          TextAlign.center,
          getScreenPercentSize(context, 2.5),
        ),

        SizedBox(height: getScreenPercentSize(context, 4)),

        // Score
        getTextWidget(
          Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          score.toInt().toString(),
          TextAlign.center,
          getScreenPercentSize(context, 6),
        ),
        SizedBox(height: getScreenPercentSize(context, 1)),

        getTextWidget(
          Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          "Your current score",
          TextAlign.center,
          getScreenPercentSize(context, 2.2),
        ),

        SizedBox(height: getScreenPercentSize(context, 5)),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: getButtonWidget(
                context,
                "RESUME",
                colorTuple.item1.primaryColor!,
                    () => Navigator.pop(context, true),
                textColor: Colors.black,
              ),
            ),
            SizedBox(width: getHorizontalSpace(context)),
            _CircleIconButton(
              icon: Icons.refresh,
              onTap: () => Navigator.pop(context, false),
              color: colorTuple.item1.primaryColor!,
            ),
          ],
        ),
      ],
    );
  }
}

/// Small reusable circular icon button for dialogs
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double size = getDefaultButtonSize(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        height: size,
        width: size,
        decoration: getDefaultDecoration(
          radius: getPercentSize(size, 20),
          bgColor: color,
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}

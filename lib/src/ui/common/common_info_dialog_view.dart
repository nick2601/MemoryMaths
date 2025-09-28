import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:mathsgames/src/utility/dialog_info_util.dart';

import '../resizer/widget_utils.dart';

class CommonInfoDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Color color;

  const CommonInfoDialogView({
    required this.gameCategoryType,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameInfoDialog gameInfoDialog =
    DialogInfoUtil.getInfoDialogData(gameCategoryType);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getScreenPercentSize(context, 2),
        horizontal: getHorizontalSpace(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          getTextWidget(
            Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            gameInfoDialog.title,
            TextAlign.center,
            getScreenPercentSize(context, 3.5),
          ),

          SizedBox(height: getScreenPercentSize(context, 5)),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 10),
            ),
            child: getTextWidgetWithMaxLine(
              Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
              gameInfoDialog.dec,
              TextAlign.center,
              getScreenPercentSize(context, 2),
              4,
            ),
          ),

          SizedBox(height: getScreenPercentSize(context, 4)),

          // Score info (Correct / Wrong)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTextWidget(
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    "${gameInfoDialog.correctAnswerScore}",
                    TextAlign.center,
                    getScreenPercentSize(context, 2),
                  ),
                  SizedBox(height: getScreenPercentSize(context, 1.8)),
                  getTextWidget(
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    "${gameInfoDialog.wrongAnswerScore}",
                    TextAlign.center,
                    getScreenPercentSize(context, 2),
                  ),
                ],
              ),
              SizedBox(width: getWidthPercentSize(context, 2)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTextWidget(
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    "for correct answer",
                    TextAlign.center,
                    getScreenPercentSize(context, 2),
                  ),
                  SizedBox(height: getScreenPercentSize(context, 1.8)),
                  getTextWidget(
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    "for wrong answer",
                    TextAlign.center,
                    getScreenPercentSize(context, 2),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: getScreenPercentSize(context, 5)),

          // Buttons
          Row(
            children: [
              Expanded(
                child: getButtonWidget(
                  context,
                  "Cancel",
                  Theme.of(context).scaffoldBackgroundColor,
                      () => Navigator.pop(context),
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              SizedBox(width: getWidthPercentSize(context, 5)),
              Expanded(
                child: getButtonWidget(
                  context,
                  "Go",
                  color,
                      () => Navigator.pop(context),
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

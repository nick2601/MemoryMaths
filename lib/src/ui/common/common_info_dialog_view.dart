import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:mathsgames/src/utility/dialog_info_util.dart';
import 'package:mathsgames/src/utility/global_constants.dart';

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
    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            0.8, // Allow dialog to use up to 80% of screen height
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getScreenPercentSize(context, 2),
            horizontal: getHorizontalSpace(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getTextWidget(
                Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                gameInfoDialog.title,
                TextAlign.center,
                getScreenPercentSize(context, 3.5)),

            SizedBox(height: getScreenPercentSize(context, 3)),

            // Scrollable text area for game instructions
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidthPercentSize(context, 5)),
                  child: Text(
                    gameInfoDialog.dec,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          height: 1.4, // Improve line spacing
                        ),
                    textAlign:
                        TextAlign.left, // Left align for better readability
                  ),
                ),
              ),
            ),

            SizedBox(height: getScreenPercentSize(context, 4)),

            // Scoring section
            Container(
              padding: EdgeInsets.all(getScreenPercentSize(context, 2)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(getScreenPercentSize(context, 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      getTextWidget(
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.green),
                          "+${gameInfoDialog.correctAnswerScore}",
                          TextAlign.center,
                          getScreenPercentSize(context, 2.2)),
                      SizedBox(
                        height: getScreenPercentSize(context, 1.8),
                      ),
                      getTextWidget(
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.red),
                          "${gameInfoDialog.wrongAnswerScore}",
                          TextAlign.center,
                          getScreenPercentSize(context, 2.2)),
                    ],
                  ),
                  SizedBox(width: getWidthPercentSize(context, 3)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          "for correct answer",
                          TextAlign.center,
                          getScreenPercentSize(context, 2)),
                      SizedBox(
                        height: getScreenPercentSize(context, 1.8),
                      ),
                      getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          "for wrong answer",
                          TextAlign.center,
                          getScreenPercentSize(context, 2)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: getScreenPercentSize(context, 4)),

            // Action buttons
            Row(
              children: [
                Expanded(
                    child: getButtonWidget(context, "Cancel",
                        Theme.of(context).textTheme.bodyLarge!.color, () {
                  Navigator.pop(context, false); // Return false for cancel
                },
                        isBorder: true,
                        textColor:
                            Theme.of(context).textTheme.bodyLarge!.color)),
                SizedBox(
                  width: getWidthPercentSize(context, 5),
                ),
                Expanded(
                    child: getButtonWidget(context, "Let's Play!", color, () {
                  Navigator.pop(context, true); // Return true for go
                }, textColor: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';
import 'common_dual_score_widget.dart';

class CommonDualGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score1;
  final int score2;
  final int index;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualGameOverDialogView({
    Key? key,
    required this.gameCategoryType,
    required this.score1,
    required this.score2,
    required this.index,
    required this.totalQuestion,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Icon
        getDefaultIconWidget(
          context,
          icon: AppAssets.backIcon,
          folder: colorTuple.item1.folderName!,
          function: () => Navigator.pop(context),
        ),
        SizedBox(height: getScreenPercentSize(context, 1.8)),

        // Title
        Center(
          child: getTextWidget(
            textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            "Game Over!!!",
            TextAlign.center,
            getScreenPercentSize(context, 3),
          ),
        ),

        SizedBox(height: getScreenPercentSize(context, 1)),

        // Scores
        Expanded(
          child: CommonDualScoreWidget(
            colorTuple: colorTuple,
            totalLevel: defaultLevelSize,
            currentLevel: 1,
            gameCategoryType: gameCategoryType,
            score1: score1,
            score2: score2,
            right: index,
            wrong: totalQuestion - index,
            totalQuestion: totalQuestion,
            index: index,
            homeClick: () => Navigator.pop(context),
            shareClick: () {
              // TODO: implement share logic
            },
          ),
        ),

        // Restart Button
        getButtonWidget(
          context,
          "Restart",
          colorTuple.item1.primaryColor!,
              () => Navigator.pop(context, true),
          textColor: Colors.black,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../model/gradient_model.dart';
import '../soundPlayer/audio_file.dart';
import 'common_dual_score_widget.dart';

class CommonDualGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score1;
  final int score2;
  final int index;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualGameOverDialogView({
    required this.gameCategoryType,
    required this.score1,
    required this.score2,
    required this.index,
    required this.totalQuestion,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);

    audioPlayer.playGameOverSound();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDefaultIconWidget(context,
            icon: AppAssets.backIcon,
            folder: colorTuple.item1.folderName, function: () {
          Navigator.pop(context);
        }),
        SizedBox(height: getScreenPercentSize(context, 1.8)),
        Center(
          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
              "Game Over!!!",
              TextAlign.center,
              getScreenPercentSize(context, 3)),
        ),
        Expanded(
            child: Container(
          child: CommonDualScoreWidget(
            context: context,
            colorTuple: colorTuple,
            totalLevel: defaultLevelSize,
            currentLevel: 1,
            gameCategoryType: gameCategoryType,
            score1: score1,
            score2: score2,
            right: 1,
            totalQuestion: totalQuestion,
            index: index,
            wrong: 1,
            homeClick: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView(),));
            },
            shareClick: () {
              // share();
            },
          ),
        )),
        getButtonWidget(context, "Restart", colorTuple.item1.primaryColor, () {
          Navigator.pop(context, true);
        }, textColor: Colors.black),
      ],
    );
  }
}

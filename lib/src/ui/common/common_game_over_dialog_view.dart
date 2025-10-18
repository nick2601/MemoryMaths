import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_score_widget.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:tuple/tuple.dart';

import '../model/gradient_model.dart';
import '../soundPlayer/audio_file.dart';

class CommonGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score;
  final int right;
  final int wrong;
  final int level;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;
  final Function function;
  final Function updateFunction;

  const CommonGameOverDialogView({
    required this.gameCategoryType,
    required this.score,
    required this.right,
    required this.wrong,
    required this.level,
    required this.totalQuestion,
    required this.colorTuple,
    required this.function,
    required this.updateFunction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer(context);
    // AdsFile? adsFile = new AdsFile(context);
    // adsFile.createInterstitialAd();

    audioPlayer.playGameOverSound();

    double percentage = (score * 100) / 20;
    int star = 0;

    if (percentage < 35) {
      star = 1;
    } else if (percentage > 35 && percentage < 75) {
      star = 2;
    } else if (percentage > 75) {
      star = 3;
    }

    print("start---$star");

    return CommonScoreWidget(
      context: context,
      colorTuple: colorTuple,
      totalLevel: defaultLevelSize,
      currentLevel: level,
      gameCategoryType: gameCategoryType,
      score: score,
      right: right,
      totalQuestion: totalQuestion,
      wrong: wrong,
      function: function,
      closeClick: () {
        Navigator.pop(context);
      },
      homeClick: () {
        updateFunction();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardView(),
            ));
      },
      restartClick: () {
        // showInterstitialAd(adsFile, () {
        //   disposeInterstitialAd(adsFile);
        //
        // });
        Navigator.pop(context, true);
      },
      nextClick: () {
        if (star >= 2) {
          // showInterstitialAd(adsFile, () {
          //   disposeInterstitialAd(adsFile);
          //
          // });
          if (colorTuple.item2 < defaultLevelSize) {
            function(colorTuple.item2 + 1);
          }
          Navigator.pop(context, true);
        }
      },
      shareClick: () {
        share();
      },
    );

    // return Container(
    //   height: 400,
    // );
  }

  share() async {
    await FlutterShare.share(
        title: 'Math Games',
        text: 'Your highest score is $score\n ${getAppLink()}',
        linkUrl: '',
        chooserTitle: 'Share');
  }
}

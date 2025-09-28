import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class CommonScoreWidget extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int totalLevel;
  final int currentLevel;
  final int score;
  final int right;
  final int wrong;
  final int totalQuestion;
  final Function function;
  final Function homeClick;
  final Function closeClick;
  final Function shareClick;
  final Function restartClick;
  final Function nextClick;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonScoreWidget({
    Key? key,
    required this.shareClick,
    required this.restartClick,
    required this.closeClick,
    required this.nextClick,
    required this.homeClick,
    required this.currentLevel,
    required this.totalLevel,
    required this.colorTuple,
    required this.totalQuestion,
    required this.score,
    required this.wrong,
    required this.right,
    required this.gameCategoryType,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    final appBarHeight = getScreenPercentSize(context, 25);
    final mainHeight = getScreenPercentSize(context, 30);
    final radius = getScreenPercentSize(context, 2.5);
    final circle = getScreenPercentSize(context, 12);
    final circleInner = getScreenPercentSize(context, 9.4);
    final stepSize = getScreenPercentSize(context, 1.3);
    final scoreHeight = getPercentSize(mainHeight, 55);

    final starSize = getWidthPercentSize(context, 10);

    // ⭐ Score to star logic
    double percentage = (score * 100) / 20;
    percentage = percentage.clamp(0, 100);
    int star = 0;
    if (percentage >= 75) {
      star = 3;
    } else if (percentage >= 35) {
      star = 2;
    } else if (percentage > 10) {
      star = 1;
    }

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            // 🔵 Top circular level indicator
            SizedBox(
              height: mainHeight,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  toolbarHeight: 0,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
                floatingActionButton: SizedBox(
                  width: circle,
                  height: circle,
                  child: Stack(
                    children: [
                      CircularStepProgressIndicator(
                        totalSteps: totalLevel,
                        currentStep: currentLevel,
                        stepSize: stepSize,
                        selectedColor: colorTuple.item1.primaryColor,
                        unselectedColor: Theme.of(context)
                            .colorScheme
                            .unSelectedProgressColor,
                        padding: 0,
                        width: circle,
                        height: circle,
                        selectedStepSize: stepSize,
                        roundedCap: (_, __) => true,
                      ),
                      Center(
                        child: Container(
                          width: circleInner,
                          height: circleInner,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: getTextWidget(
                              Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600) ??
                                  const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                              '$currentLevel/$totalLevel\nLevel',
                              TextAlign.center,
                              getPercentSize(circle, 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  child: BottomAppBar(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 10,
                    child: Padding(
                      padding: EdgeInsets.all(
                          FetchPixels.getDefaultHorSpace(context)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: getDefaultIconWidget(
                          context,
                          icon: AppAssets.closeIcon,
                          folder: colorTuple.item1.folderName!,
                          function: () => closeClick(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 🟡 Main Game Over & score details
            Container(
              margin: EdgeInsets.only(top: getPercentSize(mainHeight, 60)),
              decoration: getDecorationWithSide(
                radius: radius,
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                isBottomLeft: true,
                isBottomRight: true,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: getTextWidget(
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      "Game Over!!!",
                      TextAlign.center,
                      getScreenPercentSize(context, 3.5),
                    ),
                  ),
                  SizedBox(height: getScreenPercentSize(context, 5)),

                  // 🏆 Score row
                  _ScoreRow(score: score, scoreHeight: scoreHeight),

                  getTextWidget(
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    'Your Score',
                    TextAlign.center,
                    getPercentSize(scoreHeight, 12),
                  ),

                  SizedBox(height: getScreenPercentSize(context, 5)),

                  // ⭐ Stars
                  _StarRow(star: star, starSize: starSize),

                  // 🏠 Action buttons (restart, share, home)
                  _ActionButtons(
                    themeProvider: themeProvider,
                    colorTuple: colorTuple,
                    restartClick: restartClick,
                    shareClick: shareClick,
                    homeClick: homeClick,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Extracted Widgets for clarity
class _ScoreRow extends StatelessWidget {
  final int score;
  final double scoreHeight;

  const _ScoreRow({required this.score, required this.scoreHeight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTextWidget(
          Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          score.toString(),
          TextAlign.center,
          getPercentSize(scoreHeight, 30),
        ),
        SizedBox(width: getWidthPercentSize(context, 1.2)),
        SvgPicture.asset(
          AppAssets.icTrophy,
          height: getPercentSize(scoreHeight, 23),
          width: getPercentSize(scoreHeight, 18),
        ),
      ],
    );
  }
}

class _StarRow extends StatelessWidget {
  final int star;
  final double starSize;

  const _StarRow({required this.star, required this.starSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 2.5)),
          child: Image.asset(
            (star > i) ? AppAssets.fillStartIcon : AppAssets.startIcon,
            width: starSize,
            height: starSize,
          ),
        );
      }),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final ThemeNotifier themeProvider;
  final Tuple2<GradientModel, int> colorTuple;
  final Function restartClick;
  final Function shareClick;
  final Function homeClick;

  const _ActionButtons({
    required this.themeProvider,
    required this.colorTuple,
    required this.restartClick,
    required this.shareClick,
    required this.homeClick,
  });

  @override
  Widget build(BuildContext context) {
    double size = getScreenPercentSize(context, 6.8);

    Widget buildButton(String icon, Function onTap, {bool isFolder = false}) {
      return InkWell(
        onTap: () => onTap(),
        child: Container(
          height: size,
          width: size,
          margin: EdgeInsets.symmetric(
            vertical: getScreenPercentSize(context, 4),
            horizontal: getWidthPercentSize(context, 2.5),
          ),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? colorTuple.item1.bgColor!
                : getBgColor(themeProvider, colorTuple.item1.bgColor!),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: getPercentSize(size, 52),
              color: isFolder
                  ? null
                  : Theme.of(context).textTheme.titleSmall?.color,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(
          '${getFolderName(context, colorTuple.item1.folderName!)}${AppAssets.restartIcon}',
          restartClick,
          isFolder: true,
        ),
        buildButton(AppAssets.scoreShareIcon, shareClick),
        buildButton(
          '${getFolderName(context, colorTuple.item1.folderName!)}${AppAssets.scoreHomeIcon}',
          homeClick,
          isFolder: true,
        ),
      ],
    );
  }
}
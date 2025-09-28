import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_constant.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';

class CommonDualScoreWidget extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int totalLevel;
  final int currentLevel;
  final int score1;
  final int score2;
  final int right;
  final int wrong;
  final int totalQuestion;
  final int index;
  final VoidCallback homeClick;
  final VoidCallback shareClick;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualScoreWidget({
    Key? key,
    required this.shareClick,
    required this.homeClick,
    required this.currentLevel,
    required this.totalLevel,
    required this.colorTuple,
    required this.totalQuestion,
    required this.score1,
    required this.score2,
    required this.index,
    required this.wrong,
    required this.right,
    required this.gameCategoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getMainHeight(context);
    double radius = getScreenPercentSize(context, 2.5);
    double circle = getScreenPercentSize(context, 12);
    double stepSize = getScreenPercentSize(context, 1.3);
    double scoreHeight = getPercentSize(mainHeight, 55);

    Color bgColor = colorTuple.item1.bgColor ?? Colors.transparent; // Changed this line

    // Highlight winner/loser
    bool player1Wins = score1 > score2;
    bool player2Wins = score2 > score1;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: bgColor,
          child: Stack(
            children: [
              // Circular progress (quiz progress ring)
              SizedBox(
                height: mainHeight,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  primary: false,
                  appBar: AppBar(
                    toolbarHeight: 0,
                    elevation: 0,
                    title: const Text(''),
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
                          unselectedColor: Colors.grey.shade200,
                          padding: 0,
                          width: circle,
                          height: circle,
                          selectedStepSize: stepSize,
                          roundedCap: (_, __) => true,
                        ),
                        Center(
                          child: getTextWidget(
                            theme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600),
                            '${index + 1}/$totalQuestion\nQuiz',
                            TextAlign.center,
                            getPercentSize(circle, 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    child: SizedBox(
                      height: appBarHeight,
                      child: BottomAppBar(
                        color: colorTuple.item1.bgColor,
                        elevation: 0,
                        shape: const CircularNotchedRectangle(),
                        notchMargin: 10,
                        child: const Row(
                          children: [Expanded(child: SizedBox())],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Scoreboard
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: scoreHeight,
                    margin: EdgeInsets.only(
                      top: getPercentSize(mainHeight, 52),
                    ),
                    padding: EdgeInsets.only(
                      bottom: getPercentSize(scoreHeight, 15),
                    ),
                    decoration: getDecorationWithSide(
                      radius: radius,
                      bgColor: colorTuple.item1.bgColor,
                      isBottomLeft: true,
                      isBottomRight: true,
                    ),
                    child: Row(
                      children: [
                        // Player 1 Score
                        Expanded(
                          child: Column(
                            children: [
                              getTextWidget(
                                theme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: player1Wins
                                      ? Colors.green
                                      : Colors.black,
                                ),
                                score1.toString(),
                                TextAlign.center,
                                getPercentSize(scoreHeight, 30),
                              ),
                              SizedBox(height: getScreenPercentSize(context, 1)),
                              getTextWidget(
                                theme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                "Player 1",
                                TextAlign.center,
                                getPercentSize(scoreHeight, 12),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        Container(
                          width: 2,
                          color: colorTuple.item1.primaryColor,
                          height: getScreenPercentSize(context, 15),
                        ),

                        // Player 2 Score
                        Expanded(
                          child: Column(
                            children: [
                              getTextWidget(
                                theme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: player2Wins
                                      ? Colors.green
                                      : Colors.black,
                                ),
                                score2.toString(),
                                TextAlign.center,
                                getPercentSize(scoreHeight, 30),
                              ),
                              SizedBox(height: getScreenPercentSize(context, 1)),
                              getTextWidget(
                                theme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                "Player 2",
                                TextAlign.center,
                                getPercentSize(scoreHeight, 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 Helper button
  Widget getHomeButton(BuildContext context, String icon, VoidCallback onTap) {
    double size = getScreenPercentSize(context, 6.8);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        margin: EdgeInsets.symmetric(
          vertical: getScreenPercentSize(context, 4),
          horizontal: getWidthPercentSize(context, 2.5),
        ),
        decoration: BoxDecoration(
          color: colorTuple.item1.bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            height: getPercentSize(size, 52),
          ),
        ),
      ),
    );
  }
}
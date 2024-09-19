import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';

class CommonDualScoreWidget extends StatelessWidget {
  final BuildContext? context;
  final GameCategoryType? gameCategoryType;
  final int totalLevel;
  final int currentLevel;
  final int score1;
  final int score2;
  final int right;
  final int wrong;
  final int totalQuestion;
  final int index;
  final Function homeClick;
  final Function shareClick;
  final Tuple2<GradientModel, int> colorTuple;

  CommonDualScoreWidget({
    required this.context,
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
  });

  @override
  Widget build(BuildContext context) {
    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getMainHeight(context);
    var radius = getScreenPercentSize(context, 2.5);
    var circle = getScreenPercentSize(context, 12);
    var stepSize = getScreenPercentSize(context, 1.3);

    Color bgColor = getBackGroundColor(context);
    double scoreHeight = getPercentSize(mainHeight, 55);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: bgColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Stack(
              children: [
                SizedBox(
                  height: mainHeight,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    primary: false,
                    appBar: AppBar(
                      bottomOpacity: 0.0,
                      title: const Text(''),
                      toolbarHeight: 0,
                      elevation: 0,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: SizedBox(
                      width: (circle),
                      height: (circle),
                      child: Stack(
                        children: [
                          Container(
                            child: CircularStepProgressIndicator(
                              totalSteps: totalLevel,
                              currentStep: currentLevel,
                              stepSize: stepSize,
                              selectedColor: colorTuple.item1.primaryColor,
                              unselectedColor: Colors.grey.shade100,
                              padding: 0,
                              width: circle,
                              height: circle,
                              selectedStepSize: stepSize,
                              roundedCap: (_, __) => true,
                            ),
                          ),
                          Center(
                            child: getTextWidget(
                                Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w600),
                                '${index + 1}/20\nQuiz',
                                TextAlign.center,
                                getPercentSize(circle, 15)),
                          )
                        ],
                      ),
                    ),
                    bottomNavigationBar: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      child: Container(
                        height: (appBarHeight),
                        child: BottomAppBar(
                          color: colorTuple.item1.bgColor,
                          elevation: 0,
                          shape: CircularNotchedRectangle(),
                          notchMargin: (10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Expanded(
                                child: SizedBox(width: 0),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: scoreHeight,
                      margin:
                          EdgeInsets.only(top: getPercentSize(mainHeight, 52)),
                      padding: EdgeInsets.only(
                          bottom: getPercentSize(scoreHeight, 15)),
                      decoration: getDecorationWithSide(
                          radius: radius,
                          bgColor: colorTuple.item1.bgColor,
                          isBottomLeft: true,
                          isBottomRight: true),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.w600),
                                    (score1 > 0)
                                        ? score1.toInt().toString()
                                        : "0",
                                    TextAlign.center,
                                    getPercentSize(scoreHeight, 30)),
                                SizedBox(
                                    height: getScreenPercentSize(context, 1)),
                                getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                    "Player 1",
                                    TextAlign.center,
                                    getPercentSize(scoreHeight, 12)),
                              ],
                            ),
                            flex: 1,
                          ),
                          Container(
                            width: 2,
                            color: colorTuple.item1.primaryColor,
                            height: getScreenPercentSize(context, 15),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.w600),
                                    (score2 > 0)
                                        ? score2.toInt().toString()
                                        : "0",
                                    TextAlign.center,
                                    getPercentSize(scoreHeight, 30)),
                                SizedBox(
                                    height: getScreenPercentSize(context, 1)),
                                getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                    "Player 2",
                                    TextAlign.center,
                                    getPercentSize(scoreHeight, 12)),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  getHomeButton(BuildContext context, String icon, Function function) {
    double size = getScreenPercentSize(context, 6.8);
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        height: size,
        width: size,
        margin: EdgeInsets.symmetric(
            vertical: getScreenPercentSize(context, 4),
            horizontal: getWidthPercentSize(context, 2.5)),
        decoration: BoxDecoration(
            color: colorTuple.item1.bgColor, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            icon,
            height: getPercentSize(size, 52),
          ),
        ),
      ),
    );
  }

  getStarWidget(int star, double starSize, int count) {
    return Image.asset(
      (star > count) ? AppAssets.fillStartIcon : AppAssets.startIcon,
      width: starSize,
      height: starSize,
    );
  }

  getDetail(BuildContext context, String s, String icon, double btnHeight) {
    return getCommonDetailWidget(
        context: context,
        data: s,
        icon: icon,
        isCenter: true,
        iconSize: getPercentSize(btnHeight, 47),
        fontSize: getPercentSize(btnHeight, 35),
        horizontalSpace: getWidthPercentSize(context, 3),
        mainHeight: btnHeight);
  }
}

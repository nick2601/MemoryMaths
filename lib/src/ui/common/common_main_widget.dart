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
import '../app/game_provider.dart';

class CommonMainWidget<T extends GameProvider> extends StatelessWidget {
  final BuildContext? context;
  final GameCategoryType? gameCategoryType;
  final bool? isTopMargin;
  final Widget? subChild;
  final Color? color;
  final bool? isTimer;

  final Color? primaryColor;

  CommonMainWidget({
    required this.context,
    required this.subChild,
    this.isTimer,
    required this.color,
    required this.primaryColor,
    required this.gameCategoryType,
    this.isTopMargin,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<T>(context);

    bool isDetailView = true;
    // bool isDetailView = isDetailWidget(gameCategoryType!);

    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getMainHeight(context);
    var circle = getScreenPercentSize(context, 12);
    var margin = getHorizontalSpace(context);
    var stepSize = getScreenPercentSize(context, 1.3);

    print("type===${KeyUtil.getTimeUtil(gameCategoryType!)}");

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Stack(
              children: [
                Visibility(
                  visible: isTimer == null,
                  child: SizedBox(
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
                                totalSteps:
                                    KeyUtil.getTimeUtil(gameCategoryType!),
                                currentStep: model.currentTime,
                                stepSize: stepSize,
                                selectedColor: primaryColor,
                                unselectedColor: Theme.of(context)
                                    .colorScheme
                                    .unSelectedProgressColor,
                                padding: 0,
                                width: circle,
                                height: circle,
                                selectedStepSize: stepSize,
                                roundedCap: (_, __) => true,
                              ),

                              // decoration:
                              // BoxDecoration(color: transpar, shape: BoxShape.circle),
                            ),
                            Center(
                              child: getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  secToTime(model.currentTime),
                                  TextAlign.center,
                                  getPercentSize(circle, 18)),
                            )
                          ],
                        ),
                      ),
                      bottomNavigationBar: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                getScreenPercentSize(context, 4)),
                            topRight: Radius.circular(
                                getScreenPercentSize(context, 4))),
                        child: Container(
                          height: (appBarHeight),
                          child: BottomAppBar(
                            color: color,
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
                ),
                Visibility(
                  visible: isTimer != null,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin:
                        EdgeInsets.only(top: getPercentSize(mainHeight, 25)),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(getScreenPercentSize(context, 4)),
                          topRight: Radius.circular(
                              getScreenPercentSize(context, 4))),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 35)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin),
                        child: Stack(
                          children: [
                            Opacity(
                              // ignore: dead_code
                              opacity: isDetailView ? 1 : 0,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w500),
                                    'Level : ${model.levelNo}',
                                    TextAlign.center,
                                    getPercentSize(mainHeight, 6)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icTrophy,
                                        height: getPercentSize(mainHeight, 7),
                                        width: getPercentSize(mainHeight, 7),
                                      ),
                                      SizedBox(
                                        width:
                                            getWidthPercentSize(context, 1.2),
                                      ),
                                      Selector<T, Tuple2<double, double>>(
                                          selector: (p0, p1) => Tuple2(
                                              p1.currentScore, p1.oldScore),
                                          builder: (context, tuple2, child) {
                                            int currentScore =
                                                tuple2.item1.toInt();

                                            print(
                                                "current====${tuple2.item2.toInt()}=====${tuple2.item1.toInt()}");
                                            return getTextWidget(
                                                Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                currentScore.toString(),
                                                TextAlign.center,
                                                getPercentSize(mainHeight, 6));
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getScreenPercentSize(context, 1.5),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icCoin,
                                        height: getPercentSize(mainHeight, 7),
                                        width: getPercentSize(mainHeight, 7),
                                      ),
                                      SizedBox(
                                        width:
                                            getWidthPercentSize(context, 1.2),
                                      ),
                                      Selector<T, int>(
                                        builder: (context, value, child) {
                                          return getTextWidget(
                                              Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                              value.toString(),
                                              TextAlign.center,
                                              getPercentSize(mainHeight, 6));
                                        },
                                        selector: (p0, p1) {
                                          return p1.coin;
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(
                            top: FetchPixels.getPixelHeight(50)),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: color,
                          // color: color,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        subChild!,
      ],
    );
  }
}

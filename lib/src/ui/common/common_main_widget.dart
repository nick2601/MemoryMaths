import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../utility/Constants.dart';
import '../app/game_provider.dart';

class CommonMainWidget extends ConsumerWidget {
  final GameCategoryType gameCategoryType;
  final bool? isTopMargin;
  final Widget? subChild;
  final Color color;
  final Color primaryColor;
  final bool? isTimer;

  const CommonMainWidget({
    required this.subChild,
    required this.color,
    required this.primaryColor,
    required this.gameCategoryType,
    this.isTimer,
    this.isTopMargin,
    Key? key,
  }) : super(key: key);

  String secToTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timeProvider(gameCategoryType.index));
    ref.read(timeProvider(gameCategoryType.index).notifier);

    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getMainHeight(context);
    var circle = getScreenPercentSize(context, 12);
    var margin = getHorizontalSpace(context);
    var stepSize = getScreenPercentSize(context, 1.3);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
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
                      width: circle,
                      height: circle,
                      child: Stack(
                        children: [
                          CircularStepProgressIndicator(
                            totalSteps: state.totalTime,
                            currentStep: state.currentTime,
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
                          Center(
                            child: getTextWidget(
                              Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                              secToTime(state.currentTime),
                              TextAlign.center,
                              getPercentSize(circle, 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    bottomNavigationBar: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft:
                        Radius.circular(getScreenPercentSize(context, 4)),
                        topRight:
                        Radius.circular(getScreenPercentSize(context, 4)),
                      ),
                      child: Container(
                        height: appBarHeight,
                        child: BottomAppBar(
                          color: color,
                          elevation: 0,
                          shape: const CircularNotchedRectangle(),
                          notchMargin: 10,
                          child: const Row(
                            children: [Expanded(child: SizedBox(width: 0))],
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
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 25)),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft:
                      Radius.circular(getScreenPercentSize(context, 4)),
                      topRight:
                      Radius.circular(getScreenPercentSize(context, 4)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: getPercentSize(mainHeight, 35)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: margin),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: getTextWidget(
                              Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                              'Level : ${state.levelNo}',
                              TextAlign.center,
                              getPercentSize(mainHeight, 6),
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
                                      width: getWidthPercentSize(context, 1.2),
                                    ),
                                    getTextWidget(
                                      Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                          fontWeight: FontWeight.w600),
                                      state.currentScore
                                          .toInt()
                                          .toString(),
                                      TextAlign.center,
                                      getPercentSize(mainHeight, 6),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: getScreenPercentSize(context, 1.5)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.icCoin,
                                      height: getPercentSize(mainHeight, 7),
                                      width: getPercentSize(mainHeight, 7),
                                    ),
                                    SizedBox(
                                      width: getWidthPercentSize(context, 1.2),
                                    ),
                                    getTextWidget(
                                      Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                          fontWeight: FontWeight.w600),
                                      state.coin.toString(),
                                      TextAlign.center,
                                      getPercentSize(mainHeight, 6),
                                    ),
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
                        decoration: BoxDecoration(color: color),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (subChild != null) subChild!,
      ],
    );
  }
}

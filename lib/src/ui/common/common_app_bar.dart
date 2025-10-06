import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/dialog_info_util.dart';
import '../model/gradient_model.dart';
import 'common_linear_percent_indicator.dart';

class CommonAppBar<T extends GameProvider> extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;
  final BuildContext? context;
  final bool? isTimer;
  final bool? hint;
  final GameCategoryType? gameCategoryType;
  final Widget? infoView;

  const CommonAppBar({
    Key? key,
    required this.colorTuple,
    required this.context,
    this.isTimer,
    this.hint,
    required this.infoView,
    required this.gameCategoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 7.5);
    return Container(
      child: Column(
        children: [
          Container(
            height: height,
            padding: EdgeInsets.symmetric(
              horizontal: getHorizontalSpace(context),
            ),
            child: Row(
              children: [
                Consumer<T>(builder: (context, provider, child) {
                  return getDefaultIconWidget(context,
                      icon: AppAssets.backIcon,
                      folder: colorTuple.item1.folderName, function: () {
                    provider.showExitDialog();
                  });
                }),
                SizedBox(
                  width: getWidthPercentSize(context, 2.5),
                ),
                Expanded(
                  flex: 1,
                  child: getTextWidgetWithMaxLine(
                      Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                      DialogInfoUtil.getInfoDialogData(gameCategoryType!).title,
                      TextAlign.start,
                      getPercentSize(height, 35),
                      1),
                ),
                hint == null
                    ? Consumer<T>(builder: (context, provider, child) {
                        // For Mental Arithmetic, only show hint after animation completes
                        bool shouldShowHint = true;
                        if (gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
                          // Cast to MentalArithmeticProvider to access animation state
                          final mentalProvider = provider as dynamic;
                          shouldShowHint = mentalProvider.isAnimationCompleted ?? false;
                        }

                        return shouldShowHint
                            ? getHintIcon(
                                function: () {
                                  provider.showHintDialog();
                                },
                                color: colorTuple.item1.primaryColor)
                            : Container(); // Hide hint icon during animation
                      })
                    : Container(),
                SizedBox(
                  width: getWidthPercentSize(context, 2),
                ),
                infoView!,
                isTimer == null
                    ? Consumer<T>(builder: (context, provider, child) {
                        return provider.timerStatus == TimerStatus.pause
                            ? getDefaultIconWidget(context,
                                folder: colorTuple.item1.folderName,
                                changeFolderName: false,
                                icon: AppAssets.playIcon, function: () {
                                provider.pauseResumeGame();
                              })
                            : getDefaultIconWidget(context,
                                folder: colorTuple.item1.folderName,
                                icon: AppAssets.pauseIcon, function: () {
                                provider.pauseResumeGame();
                              });
                      })
                    : Container(),
              ],
            ),
          ),
          isTimer == null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: CommonLinearPercentIndicator<T>(
                    lineHeight: getScreenPercentSize(context, 0.3),
                    backgroundColor: Color(0xffeeeeee),
                    linearGradient: LinearGradient(
                      colors: [
                        colorTuple.item1.primaryColor!,
                        colorTuple.item1.primaryColor!,
                      ],
                    ),
                  ),
                )
              : Container(
                  height: getScreenPercentSize(context, 0.3),
                  width: double.infinity,
                  color: colorTuple.item1.primaryColor!,
                ),
        ],
      ),
    );
  }
}

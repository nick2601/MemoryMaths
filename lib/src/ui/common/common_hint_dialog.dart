import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import '../../core/app_assets.dart';
import '../app/game_provider.dart';
import '../model/gradient_model.dart';

class CommonHintDialog extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Tuple2<GradientModel, int> colorTuple;
  final GameProvider provider;

  const CommonHintDialog({
    required this.gameCategoryType,
    required this.colorTuple,
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHint = false;

    double iconSize = getScreenPercentSize(context, 3);
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: getScreenPercentSize(context, 2),
            horizontal: getHorizontalSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Center(
                  child: getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      isHint ? '' : 'Hint',
                      TextAlign.center,
                      getScreenPercentSize(context, 3)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      getFolderName(context, colorTuple.item1.folderName!) +
                          AppAssets.closeIcon,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getScreenPercentSize(context, 2)),
            isHint
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidthPercentSize(context, 10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getTextWidgetWithMaxLine(
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
                                'Answer is :',
                                TextAlign.center,
                                getScreenPercentSize(context, 2),
                                4),
                            SizedBox(width: getWidthPercentSize(context, 0.5)),
                            getTextWidgetWithMaxLine(
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                                provider.currentState.answer.toString(),
                                TextAlign.center,
                                getScreenPercentSize(context, 3),
                                4),
                          ],
                        ),
                      ),
                      SizedBox(height: getScreenPercentSize(context, 5)),
                      getButtonWidget(
                          context, "Ok", colorTuple.item1.primaryColor, () {
                        Navigator.pop(context);
                      }, textColor: Colors.black),
                    ],
                  )
                : Column(
                    children: [
                      // Opacity(
                      //   opacity: provider.isRewardedComplete ? 0.5 : 1,
                      //   child: getButtonWidget(context, "Watch Video",
                      //       colorTuple.item1.primaryColor, () {
                      //     if (!provider.isRewardedComplete) {
                      //       showRewardedAd(provider.adsFile, () {
                      //         setState(() {
                      //           isHint = true;
                      //           provider.isRewardedComplete = true;
                      //         });
                      //       }, function1: () {
                      //         Navigator.pop(context);
                      //       });
                      //     }
                      //   }, textColor: Colors.black),
                      // ),
                      SizedBox(height: getScreenPercentSize(context, 0.2)),
                      getHintButtonWidget(
                          context, "Coin", colorTuple.item1.primaryColor, () {
                        if (provider.coin >= hintCoin) {
                          setState(() {
                            isHint = true;
                          });

                          provider.minusCoin(useCoin: hintCoin);
                        } else {
                          showCustomToast('Coin not available', context);
                        }
                      }, textColor: Colors.black),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}

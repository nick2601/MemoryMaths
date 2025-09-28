import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../../utility/dialog_info_util.dart';
import '../app/game_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';
import 'common_linear_percent_indicator3.dart';

class CommonAppBar extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;
  final bool isTimer;
  final bool showHint;
  final GameCategoryType gameCategoryType;
  final Widget? infoView;

  const CommonAppBar({
    Key? key,
    required this.colorTuple,
    this.isTimer = true,
    this.showHint = true,
    required this.infoView,
    required this.gameCategoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider(gameCategoryType));
    final notifier = ref.read(gameProvider(gameCategoryType).notifier);

    double height = getScreenPercentSize(context, 7.5);

    return Column(
      children: [
        Container(
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: getHorizontalSpace(context),
          ),
          child: Row(
            children: [
              // Back button → Exit dialog
              getDefaultIconWidget(
                context,
                icon: AppAssets.backIcon,
                folder: colorTuple.item1.folderName!,
                function: () => notifier.exit(),
              ),

              SizedBox(width: getWidthPercentSize(context, 2.5)),

              // Game title
              Expanded(
                child: getTextWidgetWithMaxLine(
                  Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  DialogInfoUtil.getInfoDialogData(gameCategoryType).title,
                  TextAlign.start,
                  getPercentSize(height, 35),
                  1,
                ),
              ),

              // Hint button
              if (showHint)
                getHintIcon(
                  function: () => notifier.pause(), // replace with notifier.showHint()
                  color: colorTuple.item1.primaryColor,
                ),

              SizedBox(width: getWidthPercentSize(context, 2)),

              // Info view (custom)
              if (infoView != null) infoView!,

              // Timer control buttons
              if (isTimer)
                state.isTimerRunning
                    ? getDefaultIconWidget(
                  context,
                  folder: colorTuple.item1.folderName!,
                  icon: AppAssets.pauseIcon,
                  function: () => notifier.pause(),
                )
                    : getDefaultIconWidget(
                  context,
                  folder: colorTuple.item1.folderName!,
                  icon: AppAssets.playIcon,
                  function: () => notifier.resume(),
                ),
            ],
          ),
        ),

        // Timer progress bar
        isTimer
            ? Align(
          alignment: Alignment.bottomCenter,
          child: CommonLinearPercentIndicator(
            gameCategoryType: gameCategoryType, // Added this line
            lineHeight: getScreenPercentSize(context, 0.3),
            backgroundColor: const Color(0xffeeeeee),
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
    );
  }
}
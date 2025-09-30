import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/dualGame/dual_game_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import 'dart:math' as math;

import '../../utility/Constants.dart';
import '../common/common_dual_button.dart';
import '../common/common_main_widget.dart';

class DualView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const DualView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 2;
    double height = getPercentSize(remainHeight, 45) / 3;
    double crossAxisSpacing = getPercentSize(height, 20);
    var widthItem =
        (getWidthPercentSize(context, 100) - ((crossAxisCount - 1) * crossAxisSpacing)) /
            crossAxisCount;
    double aspectRatio = widthItem / height;

    final gameState = ref.watch(dualGameProvider(colorTuple.item2));
    final notifier = ref.read(dualGameProvider(colorTuple.item2).notifier);

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.DUAL_GAME,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.DUAL_GAME,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.DUAL_GAME,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.DUAL_GAME,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Column(
          children: [
            // Player 1 (top, rotated 180°)
            Expanded(
              child: Transform.rotate(
                angle: math.pi,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          gameState.currentState?.question ?? "",
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      flex: 1,
                    ),
                    GridView.count(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: aspectRatio,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: getHorizontalSpace(context),
                        vertical: getHorizontalSpace(context),
                      ),
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: crossAxisSpacing,
                      primary: false,
                      children: List.generate(
                        gameState.currentState?.optionList.length ?? 0,
                            (index) {
                          String e = gameState.currentState!.optionList[index];
                          return CommonDualButton(
                            is4Matrix: true,
                            text: e,
                            totalHeight: remainHeight,
                            height: height,
                            onTab: () {
                              notifier.checkResult1(e);
                              debugPrint("score1====${notifier.score1}");
                            },
                            colorTuple: colorTuple,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),

            Container(height: 1, color: colorTuple.item1.primaryColor),

            // Player 2 (bottom, normal orientation)
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        gameState.currentState?.question ?? "",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    flex: 1,
                  ),
                  GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalSpace(context),
                      vertical: getHorizontalSpace(context),
                    ),
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: crossAxisSpacing,
                    primary: false,
                    children: List.generate(
                      gameState.currentState?.optionList.length ?? 0,
                          (index) {
                        String e = gameState.currentState!.optionList[index];
                        return CommonDualButton(
                          is4Matrix: true,
                          text: e,
                          totalHeight: remainHeight,
                          height: height,
                          onTab: () {
                            notifier.checkResult2(e);
                            debugPrint("score2====${notifier.score2}");
                          },
                          colorTuple: colorTuple,
                        );
                      },
                    ),
                  ),
                ],
              ),
              flex: 1,
            ),
          ],
        ),
        isTopMargin: false,
      ),
    );
  }
}

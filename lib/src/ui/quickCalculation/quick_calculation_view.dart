import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_neumorphic_view.dart';
import 'package:mathsgames/src/ui/common/common_number_button.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/quickCalculation/quick_calculation_question_view.dart';
import 'package:mathsgames/src/ui/quickCalculation/quick_calculation_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../model/gradient_model.dart';

class QuickCalculationView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const QuickCalculationView({Key? key, required this.colorTuple}) : super(key: key);

  final List<String> keypad = const [
    "7", "8", "9",
    "4", "5", "6",
    "1", "2", "3",
    "Clear", "0", "Back"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickCalculationProvider(colorTuple.item2));
    final notifier = ref.read(quickCalculationProvider(colorTuple.item2).notifier);

    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;
    double keypadHeight = getScreenPercentSize(context, 57);
    double buttonHeight = keypadHeight / 5.3;

    double crossAxisSpacing = getPercentSize(buttonHeight, 30);
    double widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / buttonHeight;
    double mainHeight = getMainHeight(context);
    var margin = getHorizontalSpace(context);

    if (state.currentState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.QUICK_CALCULATION,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.QUICK_CALCULATION,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Column(
          children: [
            /// 🔹 Question + Answer Section
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: margin * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Question Widget
                    Expanded(
                      child: QuickCalculationQuestionView(
                        currentState: state.currentState!,
                        nextCurrentState: notifier.nextCurrentState,
                        previousCurrentState: notifier.previousCurrentState,
                      ),
                    ),

                    SizedBox(width: getWidthPercentSize(context, 3)),

                    /// "=" symbol
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      " = ",
                      TextAlign.center,
                      getPercentSize(remainHeight, 4),
                    ),

                    SizedBox(width: getWidthPercentSize(context, 3)),

                    /// Answer Box with Score Animation
                    CommonWrongAnswerAnimationView(
                      currentScore: state.currentScore.toInt(),
                      oldScore: 0, // Using 0 since oldScore doesn't exist in GameState
                      child: CommonNeumorphicView(
                        isMargin: true,
                        color: colorTuple.item1.bgColor!,
                        height: getPercentSize(mainHeight, 22),
                        width: getPercentSize(mainHeight, 22),
                        child: getTextWidget(
                          Theme.of(context).textTheme.titleSmall!,
                          notifier.result.isNotEmpty ? notifier.result : "?",
                          TextAlign.center,
                          getPercentSize(remainHeight, 4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 Keypad Section
            Container(
              height: keypadHeight,
              decoration: getDefaultDecoration(
                bgColor: colorTuple.item1.gridColor,
                borderColor: Theme.of(context).textTheme.titleSmall!.color,
                radius: getCommonRadius(context),
              ),
              alignment: Alignment.bottomCenter,
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: margin * 2,
                  right: margin * 2,
                  bottom: margin,
                ),
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: crossAxisSpacing,
                primary: false,
                children: keypad.map((e) {
                  if (e == "Clear") {
                    return CommonClearButton(
                      text: "Clear",
                      height: buttonHeight,
                      onTab: () => notifier.clearResult(),
                    );
                  } else if (e == "Back") {
                    return CommonBackButton(
                      height: buttonHeight,
                      onTab: () => notifier.backPress(),
                    );
                  } else {
                    return CommonNumberButton(
                      text: e,
                      totalHeight: remainHeight,
                      height: buttonHeight,
                      onTab: () => notifier.checkResult(e),
                      colorTuple: colorTuple,
                    );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
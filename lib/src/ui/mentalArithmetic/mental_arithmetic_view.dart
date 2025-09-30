import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_neumorphic_view.dart';
import 'package:mathsgames/src/ui/common/common_number_button.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/mentalArithmetic/mental_arithmetic_provider.dart';
import 'package:mathsgames/src/ui/mentalArithmetic/mental_arithmetic_question_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

class MentalArithmeticView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  MentalArithmeticView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List<String> list = const [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "-",
    "0",
    "Back",
    "Clear",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mentalArithmeticProvider(colorTuple.item2));
    final notifier = ref.read(mentalArithmeticProvider(colorTuple.item2).notifier);

    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;
    double height1 = getScreenPercentSize(context, 57);
    double height = getScreenPercentSize(context, 57) / 5.3;

    double crossAxisSpacing = getPercentSize(height, 30);
    var widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);
    double mainHeight = getMainHeight(context);

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Stack(
            children: [
              Column(
                children: [
                  // Question View
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: getPercentSize(mainHeight, 15),
                      ),
                      child: MentalArithmeticQuestionView(level: colorTuple.item2),
                    ),
                  ),

                  // Number Pad
                  Container(
                    height: height1,
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
                        right: (margin * 2),
                        left: (margin * 2),
                        bottom: getHorizontalSpace(context),
                      ),
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: crossAxisSpacing,
                      primary: false,
                      children: List.generate(list.length, (index) {
                        String e = list[index];
                        if (e == "Clear") {
                          return CommonClearButton(
                            text: "Clear",
                            height: height,
                            onTab: () => notifier.clearResult(),
                          );
                        } else if (e == "Back") {
                          return CommonBackButton(
                            onTab: () => notifier.backPress(),
                            height: height,
                          );
                        } else {
                          return CommonNumberButton(
                            text: e,
                            totalHeight: remainHeight,
                            height: height,
                            onTab: () => notifier.checkResult(e),
                            colorTuple: colorTuple,
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),

              // Answer & Score Animation
              Container(
                margin: EdgeInsets.only(top: getPercentSize(height1, 17)),
                child: CommonWrongAnswerAnimationView(
                  currentScore: state.currentScore.toInt(),
                  oldScore: 0, // Using 0 since oldScore doesn't exist in GameState
                  child: CommonNeumorphicView(
                    isLarge: true,
                    isMargin: false,
                    height: getPercentSize(height1, 12),
                    color: colorTuple.item1.bgColor!,
                    child: getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      notifier.result.isNotEmpty ? notifier.result : '?',
                      TextAlign.center,
                      getPercentSize(height1, 7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
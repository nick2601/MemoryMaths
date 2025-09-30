import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_provider.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_question_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_neumorphic_view.dart';
import '../common/common_vertical_button.dart';

class CorrectAnswerView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const CorrectAnswerView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  // Utility: get background color from colorTuple
  Color getBackGroundColor(BuildContext context) {
    return colorTuple.item1.bgColor ?? Theme.of(context).scaffoldBackgroundColor;
  }

  // Utility: get common decoration
  BoxDecoration getCommonDecoration(BuildContext context) {
    return BoxDecoration(
      color: colorTuple.item1.bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(16),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainHeight = getRemainHeight(context: context);
    final height1 = getScreenPercentSize(context, 54);
    final mainHeight = getMainHeight(context);

    final state = ref.watch(correctAnswerProvider(colorTuple.item2));
    final notifier = ref.read(correctAnswerProvider(colorTuple.item2).notifier);

    return DialogListener(
      gameCategoryType: GameCategoryType.CORRECT_ANSWER,
      level: colorTuple.item2,
      colorTuple: colorTuple,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.CORRECT_ANSWER,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.CORRECT_ANSWER,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.CORRECT_ANSWER,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.currentState != null)
                          CorrectAnswerQuestionView(
                            question: state.currentState!.question,
                            questionView: CommonWrongAnswerAnimationView(
                              currentScore: state.currentScore.toInt(),
                              oldScore: state.currentScore.toInt(), // No oldScore, use currentScore
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: getWidthPercentSize(context, 2),
                                ),
                                child: CommonNeumorphicView(
                                  isMargin: true,
                                  color: getBackGroundColor(context),
                                  width: getWidthPercentSize(context, 14),
                                  height: getWidthPercentSize(context, 14),
                                  child: getTextWidget(
                                    Theme.of(context).textTheme.titleSmall!,
                                    state.currentState != null ? "?" : "", // No result, show "?" or ""
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    height: height1,
                    decoration: getCommonDecoration(context),
                    alignment: Alignment.bottomCenter,
                    child: Builder(builder: (context) {
                      if (state.currentState == null) return const SizedBox();

                      final list = [
                        state.currentState!.firstAns,
                        state.currentState!.secondAns,
                        state.currentState!.thirdAns,
                        state.currentState!.fourthAns,
                      ];

                      list.shuffle();

                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: getPercentSize(height1, 10),
                        ),
                        child: Column(
                          children: List.generate(list.length, (index) {
                            final e = list[index];
                            return CommonVerticalButton(
                              text: e,
                              isNumber: true,
                              onTab: () {
                                notifier.checkResult(e);
                              },
                              colorTuple: colorTuple,
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
        isTopMargin: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_neumorphic_view.dart';
import 'package:mathsgames/src/ui/common/common_vertical_button.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import 'guess_sign_provider.dart';

class GuessSignView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const GuessSignView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  static const List<String> operators = ["/", "*", "+", "-"];

  Color getBackGroundColor(BuildContext context) {
    return colorTuple.item1.bgColor ?? Theme.of(context).scaffoldBackgroundColor;
  }

  BoxDecoration getCommonDecoration(BuildContext context) {
    return BoxDecoration(
      color: colorTuple.item1.bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(16),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    final state = ref.watch(guessSignProvider(colorTuple.item2));
    final current = state.currentState;

    if (current == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.GUESS_SIGN,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.GUESS_SIGN,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.GUESS_SIGN,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.GUESS_SIGN,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Column(
            children: [
              /// Question Row
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      current.firstDigit,
                      TextAlign.center,
                      getPercentSize(remainHeight, 4),
                    ),
                    SizedBox(width: getWidthPercentSize(context, 2)),
                    CommonWrongAnswerAnimationView(
                      currentScore: state.currentScore.toInt(),
                      oldScore: 0, // If you want to show previous score, you need to track it separately
                      child: CommonNeumorphicView(
                        color: getBackGroundColor(context),
                        isMargin: true,
                        width: getWidthPercentSize(context, 15),
                        height: getWidthPercentSize(context, 15),
                        child: getTextWidget(
                          Theme.of(context).textTheme.titleSmall!,
                          state.result.isNotEmpty
                              ? state.result
                              : "?",
                          TextAlign.center,
                          getPercentSize(remainHeight, 4),
                        ),
                      ),
                    ),
                    SizedBox(width: getWidthPercentSize(context, 2)),
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      current.secondDigit,
                      TextAlign.center,
                      getPercentSize(remainHeight, 4),
                    ),
                    SizedBox(width: getWidthPercentSize(context, 2)),
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      '=',
                      TextAlign.center,
                      getPercentSize(remainHeight, 4),
                    ),
                    SizedBox(width: getWidthPercentSize(context, 2)),
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      current.answer,
                      TextAlign.center,
                      getPercentSize(remainHeight, 4),
                    ),
                  ],
                ),
              ),

              /// Options
              Container(
                height: height1,
                decoration: getCommonDecoration(context),
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: getPercentSize(height1, 10),
                  ),
                  child: Column(
                    children: operators.map((op) {
                      return CommonVerticalButton(
                        text: op,
                        onTab: () {
                          ref
                              .read(guessSignProvider(colorTuple.item2).notifier)
                              .checkResult(op);
                        },
                        colorTuple: colorTuple,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        isTopMargin: false,
      ),
    );
  }
}

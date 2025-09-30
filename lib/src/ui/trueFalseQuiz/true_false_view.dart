import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/RandomOptionData.dart';
import 'package:mathsgames/src/data/models/true_false_model.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/common/common_button.dart';
import 'package:mathsgames/src/ui/common/common_main_widget.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/trueFalseQuiz/true_false_provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class TrueFalseView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const TrueFalseView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainHeight = getRemainHeight(context: context);
    final height1 = getScreenPercentSize(context, 54);
    final mainHeight = getMainHeight(context);

    // 🎮 watch game state
    final state = ref.watch(trueFalseProvider(colorTuple.item2));
    final notifier = ref.read(trueFalseProvider(colorTuple.item2).notifier);

    final current = state.currentState ?? TrueFalseModel(question: "", answer: "");

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.TRUE_FALSE,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.TRUE_FALSE,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.TRUE_FALSE,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.TRUE_FALSE,
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
                    child: Center(
                      child: getTextWidget(
                        Theme.of(context).textTheme.titleSmall!,
                        current.question ?? "",
                        TextAlign.center,
                        getPercentSize(remainHeight, 4),
                      ),
                    ),
                  ),
                  Container(
                    height: height1,
                    decoration: getDefaultDecoration(),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: getPercentSize(height1, 10),
                      ),
                      child: Column(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: List.generate(2, (index) {
                                String e = strFalse;
                                Color color = Colors.red;

                                if (index == 0) {
                                  e = strTrue;
                                  color = Colors.green;
                                }

                                return CommonButton(
                                  text: e,
                                  color: color,
                                  onTab: () {
                                    notifier.checkResult(e);
                                  },
                                );
                              }),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
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
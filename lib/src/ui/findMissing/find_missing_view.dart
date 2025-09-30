import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/find_missing_model.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/findMissing/find_missing_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class FindMissingView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const FindMissingView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

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

    final state = ref.watch(findMissingProvider(colorTuple.item2));
    final notifier = ref.read(findMissingProvider(colorTuple.item2).notifier);

    final currentQuestion = state.currentState;

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.FIND_MISSING,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.FIND_MISSING,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.FIND_MISSING,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.FIND_MISSING,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: currentQuestion == null
                      ? const CircularProgressIndicator()
                      : getTextWidget(
                    Theme.of(context).textTheme.titleSmall!,
                    currentQuestion.question ?? "",
                    TextAlign.center,
                    getPercentSize(remainHeight, 4),
                  ),
                ),
              ),
              Container(
                height: height1,
                decoration: getCommonDecoration(context),
                alignment: Alignment.bottomCenter,
                child: currentQuestion == null
                    ? const SizedBox()
                    : Container(
                  margin: EdgeInsets.symmetric(
                    vertical: getPercentSize(height1, 10),
                  ),
                  child: Column(
                    children: List.generate(
                      currentQuestion.optionList.length,
                          (index) {
                        String e = currentQuestion.optionList[index];
                        return CommonVerticalButton(
                          text: e,
                          isNumber: true,
                          onTab: () => notifier.checkResult(e),
                          colorTuple: colorTuple,
                        );
                      },
                    ),
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

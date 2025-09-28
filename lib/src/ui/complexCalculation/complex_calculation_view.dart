import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

import 'complex_calculation_provider.dart';

class ComplexCalculationView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const ComplexCalculationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complexCalculationProvider);
    final notifier = ref.read(complexCalculationProvider.notifier);

    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Column(
            children: [
              // Question Section
              Expanded(
                flex: 1,
                child: Center(
                  child: getTextWidget(
                    Theme.of(context).textTheme.titleSmall!,
                    state.currentState?.question ?? "",
                    TextAlign.center,
                    getPercentSize(remainHeight, 4),
                  ),
                ),
              ),

              // Options Section
              Container(
                height: height1,
                decoration: getDefaultDecoration(),
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: getPercentSize(height1, 10)),
                  child: Column(
                    children: List.generate(
                      state.currentState?.optionList.length ?? 0,
                          (index) {
                        String e = state.currentState!.optionList[index];
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

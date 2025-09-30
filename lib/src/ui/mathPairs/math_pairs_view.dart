import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/mathPairs/math_pairs_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/dialog_listener.dart';
import '../common/common_main_widget.dart';
import 'math_pairs_provider.dart';

class MathPairsView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathPairsView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mathPairsProvider(colorTuple.item2));

    double remainHeight = getRemainHeight(context: context);
    double mainHeight = getMainHeight(context);

    int crossAxisCount = 3;
    double height = getPercentSize(remainHeight, 75) / 5;

    double crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;

    final currentState = state.currentState;
    if (currentState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.MATH_PAIRS,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.MATH_PAIRS,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
          decoration: getDefaultDecoration(
            bgColor: colorTuple.item1.gridColor,
            borderColor: Theme.of(context).textTheme.titleSmall!.color,
            radius: getCommonRadius(context),
          ),
          child: Center(
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontalSpace(context),
                vertical: (getHorizontalSpace(context) * 2.5),
              ),
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: crossAxisSpacing,
              primary: false,
              children: List.generate(
                currentState.list.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getHorizontalSpace(context) / 1.5,
                    vertical: getHorizontalSpace(context) / 1.3,
                  ),
                  child: MathPairsButton(
                    height: height,
                    pair: currentState.list[index],
                    index: index,
                    level: colorTuple.item2,
                    colorTuple: Tuple2(
                      colorTuple.item1.primaryColor!,
                      colorTuple.item1.backgroundColor!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
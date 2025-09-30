import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/dialog_listener.dart';
import '../common/common_main_widget.dart';
import '../magicTriangle/magic_triangle_view.dart';
import 'math_grid_provider.dart';

class MathGridView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathGridView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mathGridProvider(colorTuple.item2));
    final notifier = ref.read(mathGridProvider(colorTuple.item2).notifier);

    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 3);
    }

    final currentState = state.currentState;

    if (currentState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DialogListener(
      colorTuple: colorTuple,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.MATH_GRID,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        showHint: false,
        gameCategoryType: GameCategoryType.MATH_GRID,
        colorTuple: colorTuple,
      ),
      gameCategoryType: GameCategoryType.MATH_GRID,
      level: colorTuple.item2,
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.MATH_GRID,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: getPercentSize(mainHeight, 9),
                      ),
                      child: Center(
                        child: getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                          currentState.currentAnswer.toString(),
                          TextAlign.center,
                          getPercentSize(remainHeight, 4),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height1,
                    decoration: getCommonDecoration(context, colorTuple.item1.gridColor!),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: getDefaultDecoration(
                        bgColor: colorTuple.item1.gridColor,
                        borderColor:
                        Theme.of(context).textTheme.titleSmall!.color,
                        radius: getCommonRadius(context),
                      ),
                      margin: EdgeInsets.all(getHorizontalSpace(context)),
                      child: GridView.builder(
                        padding: EdgeInsets.all(
                          getScreenPercentSize(context, 0.7),
                        ),
                        gridDelegate: (screenHeight < screenWidth)
                            ? SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                          childAspectRatio:
                          getScreenPercentSize(context, 0.3),
                        )
                            : const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                        ),
                        itemCount: currentState.listForSquare.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return MathGridButton(
                            gridModel: currentState.listForSquare[index],
                            index: index,
                            level: colorTuple.item2,
                            colorTuple: Tuple2(
                              colorTuple.item1.primaryColor!,
                              colorTuple.item1.backgroundColor!,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

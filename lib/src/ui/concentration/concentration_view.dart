import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/concentration/concentration_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../resizer/widget_utils.dart';
import 'concentration_provider.dart';

class ConcentrationView extends ConsumerStatefulWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const ConcentrationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  ConsumerState<ConcentrationView> createState() =>
      _ConcentrationViewState();
}

class _ConcentrationViewState extends ConsumerState<ConcentrationView> {
  bool isContinue = false;

  @override
  Widget build(BuildContext context) {
    final remainHeight = getRemainHeight(context: context);
    final mainHeight = getMainHeight(context);

    const crossAxisCount = 3;
    final height = getPercentSize(remainHeight, 65) / 5;
    final crossAxisSpacing = getPercentSize(height, 14);

    final widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    final aspectRatio = widthItem / height;

    // 🎮 Watch game state
    final state = ref.watch(
      concentrationProvider(widget.colorTuple.item2),
    );

    // Current set of cards (Pairs)
    final pairs = state.currentState?.list ?? <Pair>[];

    return DialogListener(
      colorTuple: widget.colorTuple,
      gameCategoryType: GameCategoryType.CONCENTRATION,
      level: widget.colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.CONCENTRATION,
          folder: widget.colorTuple.item1.folderName!,
          color: widget.colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.CONCENTRATION,
        colorTuple: widget.colorTuple,
        isTimer: false,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.CONCENTRATION,
        color: widget.colorTuple.item1.bgColor!,
        isTimer: false,
        primaryColor: widget.colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
          decoration: getDefaultDecoration(
            bgColor: widget.colorTuple.item1.backgroundColor,
            radius: getCommonRadius(context),
            borderColor: Theme.of(context).colorScheme.crossColor,
            borderWidth: 1.2,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: GridView.count(
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
                    children: List.generate(pairs.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: getHorizontalSpace(context) / 1.5,
                          vertical: getHorizontalSpace(context) / 2,
                        ),
                        child: ConcentrationButton(
                          height: height,
                          pair: pairs[index], // ✅ renamed
                          index: index,
                          isContinue: isContinue,
                          level: widget.colorTuple.item2, // ✅ pass level
                          colorTuple: Tuple2(
                            widget.colorTuple.item1.primaryColor!,
                            widget.colorTuple.item1.backgroundColor!,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Visibility(
                visible: !isContinue,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getHorizontalSpace(context),
                  ),
                  child: getButtonWidget(
                    context,
                    "Continue",
                    widget.colorTuple.item1.primaryColor!,
                        () => setState(() => isContinue = true),
                    textColor: Colors.black,
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
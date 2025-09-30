import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/calculator/calculator_provider.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_main_widget.dart';
import 'package:mathsgames/src/ui/common/common_neumorphic_view.dart';
import 'package:mathsgames/src/ui/common/common_number_button.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';
import '../../utility/global_constants.dart';

/// CalculatorView displays the Calculator game UI.
/// Sets up the grid of number buttons, question display, and answer input.
class CalculatorView extends StatelessWidget {
  /// Contains the gradient model and level for theming and game setup.
  final Tuple2<GradientModel, int> colorTuple;

  CalculatorView({required this.colorTuple});

  /// List of button labels for the calculator grid.
  final List<String> buttonLabels = [
    "7", "8", "9",
    "4", "5", "6",
    "1", "2", "3",
    "Clear", "0", "Back"
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;

    double gridHeight = getScreenPercentSize(context, 57);
    double buttonHeight = gridHeight / 5.3;

    double crossAxisSpacing = getPercentSize(buttonHeight, 30);

    double itemWidth = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = itemWidth / buttonHeight;

    double margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<CalculatorProvider>(
          create: (context) => CalculatorProvider(
            vsync: VsyncProvider.of(context),
            level: colorTuple.item2,
            context: context,
          ),
        ),
      ],
      child: DialogListener<CalculatorProvider>(
        gameCategoryType: GameCategoryType.CALCULATOR,
        colorTuple: colorTuple,
        level: colorTuple.item2,
        appBar: CommonAppBar<CalculatorProvider>(
          infoView: CommonInfoTextView<CalculatorProvider>(
            gameCategoryType: GameCategoryType.CALCULATOR,
            folder: colorTuple.item1.folderName!,
            color: colorTuple.item1.cellColor!,
          ),
          gameCategoryType: GameCategoryType.CALCULATOR,
          colorTuple: colorTuple,
          context: context,
        ),
        child: CommonMainWidget<CalculatorProvider>(
          gameCategoryType: GameCategoryType.CALCULATOR,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: getPercentSize(mainHeight, 3)),
                        child: Consumer<CalculatorProvider>(
                          builder: (context, calculatorProvider, child) {
                            return getTextWidget(
                              Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                              calculatorProvider.currentState.question,
                              TextAlign.center,
                              getPercentSize(remainHeight, 4),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: gridHeight,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: GridView.count(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          right: margin * 2,
                          left: margin * 2,
                          bottom: getHorizontalSpace(context),
                        ),
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: crossAxisSpacing,
                        primary: false,
                        children: List.generate(buttonLabels.length, (index) {
                          String label = buttonLabels[index];
                          if (label == "Clear") {
                            return CommonClearButton(
                              text: "Clear",
                              height: buttonHeight,
                              onTab: () => context.read<CalculatorProvider>().clearResult(),
                            );
                          } else if (label == "Back") {
                            return CommonBackButton(
                              onTab: () => context.read<CalculatorProvider>().backPress(),
                              height: buttonHeight,
                            );
                          } else {
                            return CommonNumberButton(
                              text: label,
                              totalHeight: remainHeight,
                              height: buttonHeight,
                              onTab: () => context.read<CalculatorProvider>().checkResult(label),
                              colorTuple: colorTuple,
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: getPercentSize(gridHeight, 17)),
                  child: Selector<CalculatorProvider, Tuple2<double, double>>(
                    selector: (p0, p1) => Tuple2(p1.currentScore, p1.oldScore),
                    builder: (context, tuple2, child) {
                      return CommonWrongAnswerAnimationView(
                        currentScore: tuple2.item1.toInt(),
                        oldScore: tuple2.item2.toInt(),
                        child: child!,
                      );
                    },
                    child: CommonNeumorphicView(
                      isLarge: true,
                      isMargin: false,
                      height: getPercentSize(gridHeight, 12),
                      color: getBackGroundColor(context),
                      child: Selector<CalculatorProvider, String>(
                        selector: (p0, p1) => p1.result,
                        builder: (context, result, child) {
                          return getTextWidget(
                            Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                            result.isNotEmpty ? result : '?',
                            TextAlign.center,
                            getPercentSize(gridHeight, 7),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
      ),
    );
  }
}

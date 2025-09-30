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
      child: Builder(
        builder: (providerContext) {
          return DialogListener<CalculatorProvider>(
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
              context: providerContext,
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
                              String e = buttonLabels[index];
                              if (e == "Clear") {
                                return CommonClearButton(
                                  text: "Clear",
                                  height: buttonHeight,
                                  onTab: () {
                                    Provider.of<CalculatorProvider>(providerContext, listen: false).clearResult();
                                  },
                                );
                              } else if (e == "Back") {
                                return CommonBackButton(
                                  onTab: () {
                                    Provider.of<CalculatorProvider>(providerContext, listen: false).backPress();
                                  },
                                  height: buttonHeight,
                                );
                              } else {
                                return CommonNumberButton(
                                  text: e,
                                  totalHeight: remainHeight,
                                  height: buttonHeight,
                                  onTab: () {
                                    Provider.of<CalculatorProvider>(providerContext, listen: false).checkResult(e);
                                  },
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
                      child: CommonWrongAnswerAnimationView(
                        currentScore: providerContext.watch<CalculatorProvider>().currentScore.toInt(),
                        oldScore: providerContext.watch<CalculatorProvider>().oldScore.toInt(),
                        child: CommonNeumorphicView(
                          isLarge: true,
                          isMargin: false,
                          height: getPercentSize(gridHeight, 12),
                          color: colorTuple.item1.bgColor!,
                          child: Consumer<CalculatorProvider>(
                            builder: (context, calculatorProvider, child) {
                              return getTextWidget(
                                Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                                calculatorProvider.result.isNotEmpty
                                    ? calculatorProvider.result
                                    : '?',
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
              context: providerContext,
              isTopMargin: false,
            ),
          );
        },
      ),
    );
  }
}

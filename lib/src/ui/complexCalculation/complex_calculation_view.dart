import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/complex_model.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/complexCalculation/complex_calculation_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

/// ComplexCalculationView displays the Complex Calculation game UI.
/// Sets up the question display and answer options.
class ComplexCalculationView extends StatelessWidget {
  /// Contains the gradient model and level for theming and game setup.
  final Tuple2<GradientModel, int> colorTuple;

  ComplexCalculationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<ComplexCalculationProvider>(
          create: (context) => ComplexCalculationProvider(
            vsync: VsyncProvider.of(context),
            level: colorTuple.item2,
            context: context,
          ),
        ),
      ],
      child: DialogListener<ComplexCalculationProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        level: colorTuple.item2,
        appBar: CommonAppBar<ComplexCalculationProvider>(
          infoView: CommonInfoTextView<ComplexCalculationProvider>(
            gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
            folder: colorTuple.item1.folderName!,
            color: colorTuple.item1.cellColor!,
          ),
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
          colorTuple: colorTuple,
          context: context,
        ),
        child: CommonMainWidget<ComplexCalculationProvider>(
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Center(
                        child:
                            Selector<ComplexCalculationProvider, ComplexModel>(
                          selector: (p0, p1) => p1.currentState,
                          builder: (context, calculatorProvider, child) {
                            return getTextWidget(
                              Theme.of(context).textTheme.titleSmall!,
                              calculatorProvider.question!,
                              TextAlign.center,
                              getPercentSize(remainHeight, 4),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Selector<ComplexCalculationProvider, ComplexModel>(
                        selector: (p0, p1) => p1.currentState,
                        builder: (context, currentState, child) {
                          final options = currentState.optionList;
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: getPercentSize(height1, 10),
                            ),
                            child: Column(
                              children: List.generate(options.length, (index) {
                                String option = options[index];
                                return CommonVerticalButton(
                                  text: option,
                                  isNumber: true,
                                  onTab: () {
                                    context
                                        .read<ComplexCalculationProvider>()
                                        .checkResult(option);
                                  },
                                  colorTuple: colorTuple,
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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

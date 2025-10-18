import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/concentration/concentration_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import 'concentration_provider.dart';

/// ConcentrationView displays the Concentration (Memory Pairs) game UI.
/// Sets up the grid of cards, continue button, and game logic.
class ConcentrationView extends StatelessWidget {
  /// Contains the gradient model and level for theming and game setup.
  final Tuple2<GradientModel, int> colorTuple;

  const ConcentrationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isContinue = false;
    final remainHeight = getRemainHeight(context: context);
    final mainHeight = getMainHeight(context);

    // Grid configuration
    const int crossAxisCount = 3;
    final double cardHeight = getPercentSize(remainHeight, 65) / 5;
    final double crossAxisSpacing = getPercentSize(cardHeight, 14);
    final double widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    final double aspectRatio = widthItem / cardHeight;

    return StatefulBuilder(
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            const VsyncProvider(),
            ChangeNotifierProvider<ConcentrationProvider>(
              create: (context) => ConcentrationProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                isTimer: false,
                // Changed back to false like old working code
                nextQuiz: () {
                  snapshot(() {
                    isContinue = false;
                  });
                },
                context: context,
              ),
            ),
          ],
          child: Consumer<ConcentrationProvider>(
            builder: (context, controller, child) =>
                DialogListener<ConcentrationProvider>(
              colorTuple: colorTuple,
              gameCategoryType: GameCategoryType.CONCENTRATION,
              level: colorTuple.item2,
              appBar: CommonAppBar<ConcentrationProvider>(
                hint: false,
                infoView: CommonInfoTextView<ConcentrationProvider>(
                  gameCategoryType: GameCategoryType.CONCENTRATION,
                  folder: colorTuple.item1.folderName!,
                  color: colorTuple.item1.cellColor!,
                ),
                gameCategoryType: GameCategoryType.CONCENTRATION,
                colorTuple: colorTuple,
                context: context,
                isTimer: false, // Changed back to false like old working code
              ),
              child: CommonMainWidget<ConcentrationProvider>(
                gameCategoryType: GameCategoryType.CONCENTRATION,
                color: colorTuple.item1.bgColor!,
                isTimer: false,
                // Changed back to false like old working code
                primaryColor: colorTuple.item1.primaryColor!,
                subChild: Container(
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        decoration: getCommonDecoration(context),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Container(
                                  child: Consumer<ConcentrationProvider>(
                                    builder: (context, provider, child) {
                                      return GridView.count(
                                        crossAxisCount: crossAxisCount,
                                        childAspectRatio: aspectRatio,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getHorizontalSpace(context),
                                          vertical: getHorizontalSpace(context),
                                        ),
                                        crossAxisSpacing: crossAxisSpacing,
                                        mainAxisSpacing: crossAxisSpacing,
                                        primary: false,
                                        children: List.generate(
                                          provider.mathPairsList.length,
                                          (index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: getHorizontalSpace(
                                                        context) /
                                                    1.5,
                                                vertical: getHorizontalSpace(
                                                        context) /
                                                    2,
                                              ),
                                              child: ConcentrationButton(
                                                height: cardHeight,
                                                mathPairs: provider
                                                    .mathPairsList[index],
                                                index: index,
                                                isContinue: isContinue,
                                                colorTuple: Tuple2(
                                                  colorTuple
                                                      .item1.primaryColor!,
                                                  colorTuple
                                                      .item1.backgroundColor!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
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
                                  colorTuple.item1.primaryColor,
                                  () {
                                    setState(() {
                                      isContinue = true;
                                    });
                                  },
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                context: context,
                isTopMargin: false,
              ),
            ),
          ),
        );
      },
    );
  }
}

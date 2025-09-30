import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/squareRoot/square_root_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class SquareRootView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const SquareRootView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainHeight = getRemainHeight(context: context);
    final height1 = getScreenPercentSize(context, 54);
    final mainHeight = getMainHeight(context);

    final gameState = ref.watch(squareRootProvider(colorTuple.item2));
    final notifier = ref.read(squareRootProvider(colorTuple.item2).notifier);

    // Add null safety check
    if (gameState.currentState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.SQUARE_ROOT,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.SQUARE_ROOT,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Stack(
            children: [
              Column(
                children: [
                  /// Question Row
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.icRoot,
                          height: getPercentSize(remainHeight, 6),
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).textTheme.titleSmall!.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        getTextWidget(
                          Theme.of(context).textTheme.titleSmall!,
                          gameState.currentState!.question,
                          TextAlign.center,
                          getPercentSize(remainHeight, 4),
                        ),
                      ],
                    ),
                  ),

                  /// Answer Options
                  Container(
                    height: height1,
                    decoration: getDefaultDecoration(
                      bgColor: colorTuple.item1.gridColor,
                      borderColor: Theme.of(context).textTheme.titleSmall!.color,
                      radius: getCommonRadius(context),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Builder(
                      builder: (context) {
                        final list = [
                          gameState.currentState!.firstAns,
                          gameState.currentState!.secondAns,
                          gameState.currentState!.thirdAns,
                          gameState.currentState!.fourthAns,
                        ];

                        list.shuffle(); // Use list.shuffle() instead of shuffle(list)

                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: getPercentSize(height1, 10),
                          ),
                          child: Column(
                            children: List.generate(list.length, (index) {
                              final e = list[index];
                              return CommonVerticalButton(
                                text: e,
                                isNumber: true,
                                onTab: () {
                                  notifier.checkResult(e);
                                },
                                colorTuple: colorTuple,
                              );
                            }),
                          )
                        );
                      },
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

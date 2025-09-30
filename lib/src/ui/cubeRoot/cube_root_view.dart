import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/cube_root.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';
import 'cube_root_provider.dart';

class CubeRootView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const CubeRootView({
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

    // ✅ watch state from provider
    final state = ref.watch(cubeRootProvider(colorTuple.item2));
    final notifier = ref.read(cubeRootProvider(colorTuple.item2).notifier);

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.CUBE_ROOT,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.CUBE_ROOT,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.CUBE_ROOT,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.CUBE_ROOT,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Column(
            children: [
              // ✅ Question display
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      '∛',
                      TextAlign.start,
                      getPercentSize(remainHeight, 6),
                    ),
                    if (state.currentState != null)
                      getTextWidget(
                        Theme.of(context).textTheme.titleSmall!,
                        state.currentState!.question,
                        TextAlign.center,
                        getPercentSize(remainHeight, 4),
                      ),
                  ],
                ),
              ),

              // ✅ Answer options
              Container(
                height: height1,
                decoration: getCommonDecoration(context),
                alignment: Alignment.bottomCenter,
                child: Builder(builder: (context) {
                  final current = state.currentState;
                  if (current == null) return const SizedBox();

                  final list = [
                    current.firstAns,
                    current.secondAns,
                    current.thirdAns,
                    current.fourthAns,
                  ];
                  list.shuffle();

                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: getPercentSize(height1, 10)),
                    child: Column(
                      children: List.generate(list.length, (index) {
                        final e = list[index];
                        return CommonVerticalButton(
                          text: e,
                          isNumber: true,
                          onTab: () => notifier.checkResult(e),
                          colorTuple: colorTuple,
                        );
                      }),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        isTopMargin: false,
      ),
    );
  }
}

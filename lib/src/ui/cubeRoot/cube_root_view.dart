import 'package:flutter/material.dart';

import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../data/models/cube_root.dart';
import '../../data/models/random_find_missing_data.dart';
import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';
import 'cube_root_provider.dart';

class CubeRootView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const CubeRootView({
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
        ChangeNotifierProvider<CubeRootProvider>(
            create: (context) => CubeRootProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<CubeRootProvider>(
        colorTuple: colorTuple,

        appBar: CommonAppBar<CubeRootProvider>(
            infoView: CommonInfoTextView<CubeRootProvider>(
                gameCategoryType: GameCategoryType.CUBE_ROOT,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.CUBE_ROOT,
            colorTuple: colorTuple,
            context: context),

        gameCategoryType: GameCategoryType.CUBE_ROOT,
        level: colorTuple.item2,
        child: CommonMainWidget<CubeRootProvider>(
          gameCategoryType: GameCategoryType.CUBE_ROOT,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
            child: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(AppAssets.icCubeRootIcon,height: getPercentSize(remainHeight, 6),
                              //   color: Theme
                              //       .of(context)
                              //       .textTheme
                              //       .subtitle2!.color,
                              // ),

                              getTextWidget(
                                  Theme.of(context).textTheme.titleSmall!,
                                  '∛',
                                  TextAlign.start,
                                  getPercentSize(remainHeight, 6)),

                              // SvgPicture.asset(
                              //   AppAssets.icRoot,
                              //   height: getPercentSize(remainHeight, 6),
                              //   color: Theme.of(context)
                              //       .textTheme
                              //       .subtitle2!
                              //       .color,
                              // ),
                              Selector<CubeRootProvider, CubeRoot>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder:
                                      (context, calculatorProvider, child) {
                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        calculatorProvider.question,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {
                          return Selector<CubeRootProvider, CubeRoot>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                // Pre-shuffle the list once outside the builder to prevent animation lag
                                List<String> list = [
                                  currentState.firstAns,
                                  currentState.secondAns,
                                  currentState.thirdAns,
                                  currentState.fourthAns,
                                ]..shuffle(); // Use built-in shuffle instead of custom function

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: getPercentSize(height1, 10)),
                                  child: Column(
                                    children:
                                        List.generate(list.length, (index) {
                                      String e = list[index];
                                      return CommonVerticalButton(
                                          text: e,
                                          isNumber: true,
                                          onTab: () {
                                            context
                                                .read<CubeRootProvider>()
                                                .checkResult(e);
                                          },
                                          colorTuple: colorTuple);
                                    }),
                                  ),
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
      ),
    );
  }
}

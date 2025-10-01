import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/data/models/square_root.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/squareRoot/square_root_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';
import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class SquareRootView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const SquareRootView({
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
        ChangeNotifierProvider<SquareRootProvider>(
            create: (context) => SquareRootProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<SquareRootProvider>(
        colorTuple: colorTuple,

        appBar: CommonAppBar<SquareRootProvider>(
            infoView: CommonInfoTextView<SquareRootProvider>(
                gameCategoryType: GameCategoryType.SQUARE_ROOT,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.SQUARE_ROOT,
            colorTuple: colorTuple,
            context: context),

        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        level: colorTuple.item2,

        child: CommonMainWidget<SquareRootProvider>(
          gameCategoryType: GameCategoryType.SQUARE_ROOT,
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
                              SvgPicture.asset(
                                AppAssets.icRoot,
                                height: getPercentSize(remainHeight, 6),
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                              ),
                              Selector<SquareRootProvider, SquareRoot>(
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
                          return Selector<SquareRootProvider, SquareRoot>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                // Pre-shuffle the list once to prevent animation lag
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
                                                .read<SquareRootProvider>()
                                                .checkResult(e);
                                          },
                                          colorTuple: colorTuple);
                                    }),
                                  ),
                                );
                              });

                          // return ListView.builder(
                          //   itemCount: list.length,
                          //
                          //   itemBuilder: (context, index) {
                          //   return Container(
                          //     height: btnHeight,
                          //     decoration: getDefaultDecoration(
                          //       bgColor: colorTuple.item1.backgroundColor
                          //     ),
                          //   );
                          // },);
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

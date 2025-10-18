import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/find_missing_model.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/findMissing/find_missing_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class FindMissingView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  FindMissingView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List<String> list = [
    "/",
    "*",
    "+",
    "-",
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<FindMissingProvider>(
            create: (context) => FindMissingProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<FindMissingProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.FIND_MISSING,
        level: colorTuple.item2,
        appBar: CommonAppBar<FindMissingProvider>(
            infoView: CommonInfoTextView<FindMissingProvider>(
                gameCategoryType: GameCategoryType.FIND_MISSING,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.FIND_MISSING,
            colorTuple: colorTuple,
            context: context),
        child: CommonMainWidget<FindMissingProvider>(
          gameCategoryType: GameCategoryType.FIND_MISSING,
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
                          child: Center(
                            child: Selector<FindMissingProvider,
                                    FindMissingQuizModel>(
                                selector: (p0, p1) => p1.currentState,
                                builder: (context, calculatorProvider, child) {
                                  return getTextWidget(
                                      Theme.of(context).textTheme.titleSmall!,
                                      calculatorProvider.question!,
                                      TextAlign.center,
                                      getPercentSize(remainHeight, 4));
                                }),
                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {
                          return Selector<FindMissingProvider,
                                  FindMissingQuizModel>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                print("valueG===true");

                                final list = currentState.optionList;

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
                                                .read<FindMissingProvider>()
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

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';

import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/complexCalculation/complex_calculation_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class ComplexCalculationView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  ComplexCalculationView({
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
        ChangeNotifierProvider<ComplexCalculationProvider>(
            create: (context) => ComplexCalculationProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<ComplexCalculationProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        level: colorTuple.item2,
        appBar: CommonAppBar<ComplexCalculationProvider>(
            infoView: CommonInfoTextView<ComplexCalculationProvider>(
                gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<ComplexCalculationProvider>(
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
            child: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Center(
                            child: Selector<ComplexCalculationProvider,
                                    ComplexModel>(
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
                          return Selector<ComplexCalculationProvider,
                                  ComplexModel>(
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
                                                .read<
                                                    ComplexCalculationProvider>()
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
        // child: getCommonWidget(
        //     context: context,
        //     isTopMargin: false,
        //     child: Column(
        //       children: <Widget>[
        //         Expanded(
        //           child: Center(
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Selector<ComplexCalculationProvider, ComplexModel>(
        //                     selector: (p0, p1) => p1.currentState,
        //                     builder: (context, calculatorProvider, child) {
        //                       return getTextWidget(
        //                           Theme
        //                               .of(context)
        //                               .textTheme
        //                               .subtitle2!,
        //                           calculatorProvider
        //                               .question!,
        //                           TextAlign.center,
        //                           getPercentSize(
        //                               remainHeight, 4));
        //                     }),
        //
        //
        //               ],
        //             ),
        //           ),
        //           flex: 1,
        //         ),
        //         Selector<ComplexCalculationProvider, ComplexModel>(
        //             selector: (p0, p1) => p1.currentState,
        //             builder: (context, currentState, child) {
        //
        //               final list=currentState.optionList;
        //               return GridView.count(
        //                 crossAxisCount: _crossAxisCount,
        //                 childAspectRatio: _aspectRatio,
        //                 shrinkWrap: true,
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: getHorizontalSpace(context),
        //                     vertical: getHorizontalSpace(context)),
        //                 crossAxisSpacing: _crossAxisSpacing,
        //                 mainAxisSpacing: _crossAxisSpacing,
        //                 primary: false,
        //
        //                 children: List.generate(list.length, (index) {
        //                   String e = list[index];
        //                   return CommonNumberButton(
        //                     is4Matrix: true,
        //                     text: e,
        //                     totalHeight: remainHeight,
        //                     height: height,
        //                     onTab: () {
        //                       context.read<ComplexCalculationProvider>().checkResult(e);
        //                     },
        //                     colorTuple: colorTuple,
        //                   );
        //                 }),
        //               );
        //             }),
        //       ],
        //     ),
        //     subChild: CommonInfoTextView<ComplexCalculationProvider>(
        //         gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        //         folder: colorTuple.item1.folderName!,
        //         color: colorTuple.item1.cellColor!)),
      ),
    );
  }
}

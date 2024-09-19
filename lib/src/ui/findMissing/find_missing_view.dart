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

import '../../utility/Constants.dart';
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
                                      Theme.of(context).textTheme.subtitle2!,
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
        //                 Selector<FindMissingProvider, FindMissingQuizModel>(
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
        //                 // SizedBox(width: getWidthPercentSize(context, 2)),
        //                 // Selector<FindMissingProvider, Tuple2<double, double>>(
        //                 //   selector: (p0, p1) =>
        //                 //       Tuple2(p1.currentScore, p1.oldScore),
        //                 //   builder: (context, tuple2, child) {
        //                 //     return CommonWrongAnswerAnimationView(
        //                 //       currentScore: tuple2.item1.toInt(),
        //                 //       oldScore: tuple2.item2.toInt(),
        //                 //       child: child!,
        //                 //     );
        //                 //   },
        //                 //   child: CommonNeumorphicView(
        //                 //     color: colorTuple.item1.cellColor!,
        //                 //     width: getWidthPercentSize(context, 13),
        //                 //     height: getWidthPercentSize(context, 13),
        //                 //     child: Selector<FindMissingProvider, String>(
        //                 //       selector: (p0, p1) => p1.result,
        //                 //       builder: (context, result, child) {
        //                 //         return getTextWidget(
        //                 //             Theme
        //                 //                 .of(context)
        //                 //                 .textTheme
        //                 //                 .subtitle2!.copyWith(color: colorTuple.item1.primaryColor),
        //                 //             (result.length > 0)?result:"?",
        //                 //             TextAlign.center,
        //                 //             getPercentSize(
        //                 //                 remainHeight, 4));
        //                 //       },
        //                 //     ),
        //                 //   ),
        //                 // ),
        //                 // SizedBox(width: getWidthPercentSize(context, 2)),
        //                 // Selector<FindMissingProvider, Sign>(
        //                 //     selector: (p0, p1) => p1.currentState,
        //                 //     builder: (context, calculatorProvider, child) {
        //                 //       return getTextWidget(
        //                 //           Theme
        //                 //               .of(context)
        //                 //               .textTheme
        //                 //               .subtitle2!,
        //                 //           calculatorProvider
        //                 //               .secondDigit,
        //                 //           TextAlign.center,
        //                 //           getPercentSize(
        //                 //               remainHeight, 4));
        //                 //     }),
        //                 // SizedBox(width: getWidthPercentSize(context, 2)),
        //                 //
        //
        //                 // getTextWidget(
        //                 //     Theme
        //                 //         .of(context)
        //                 //         .textTheme
        //                 //         .subtitle2!,
        //                 //     '=',
        //                 //     TextAlign.center,
        //                 //     getPercentSize(
        //                 //         remainHeight, 4)),
        //
        //
        //                 // SizedBox(width: getWidthPercentSize(context, 2)),
        //                 //
        //                 // Selector<FindMissingProvider, Sign>(
        //                 //     selector: (p0, p1) => p1.currentState,
        //                 //     builder: (context, calculatorProvider, child) {
        //                 //       return getTextWidget(
        //                 //           Theme
        //                 //               .of(context)
        //                 //               .textTheme
        //                 //               .subtitle2!,
        //                 //           calculatorProvider.answer,
        //                 //           TextAlign.center,
        //                 //           getPercentSize(
        //                 //               remainHeight, 4));
        //                 //     }),
        //               ],
        //             ),
        //           ),
        //           flex: 1,
        //         ),
        //         Selector<FindMissingProvider, FindMissingQuizModel>(
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
        //                       context.read<FindMissingProvider>().checkResult(e);
        //                     },
        //                     colorTuple: colorTuple,
        //                   );
        //                 }),
        //               );
        //               // return GridView(
        //               //   gridDelegate:
        //               //   SliverGridDelegateWithFixedCrossAxisCount(
        //               //       crossAxisCount: 2),
        //               //   padding: const EdgeInsets.only(bottom: 24),
        //               //   shrinkWrap: true,
        //               //   physics: NeverScrollableScrollPhysics(),
        //               //   children: [
        //               //     ...[
        //               //       currentState.firstAns,
        //               //       currentState.secondAns,
        //               //       currentState.thirdAns,
        //               //       currentState.fourthAns,
        //               //     ].map(
        //               //           (e) {
        //               //         return CommonNumberButton(
        //               //           text: e,
        //               //           onTab: () {
        //               //             context
        //               //                 .read<FindMissingProvider>()
        //               //                 .checkResult(e);
        //               //           },
        //               //           colorTuple: Tuple2(colorTuple.item1,colorTuple.item2),
        //               //           fontSize: 48,
        //               //         );
        //               //       },
        //               //     )
        //               //   ],
        //               // );
        //             }),
        //         // Builder(builder: (context) {
        //         //   return GridView.count(
        //         //     crossAxisCount: _crossAxisCount,
        //         //     childAspectRatio: _aspectRatio,
        //         //     shrinkWrap: true,
        //         //     padding: EdgeInsets.symmetric(
        //         //         horizontal: getHorizontalSpace(context),
        //         //         vertical: getHorizontalSpace(context)),
        //         //     crossAxisSpacing: _crossAxisSpacing,
        //         //     mainAxisSpacing: _crossAxisSpacing,
        //         //     primary: false,
        //         //
        //         //     children: List.generate(list.length, (index) {
        //         //       String e = list[index];
        //         //       return CommonNumberButton( is4Matrix: true,
        //         //         text: e,
        //         //         totalHeight: remainHeight,
        //         //         height: height,
        //         //         onTab: () {
        //         //           context.read<FindMissingProvider>().checkResult(e);
        //         //         },
        //         //         colorTuple: colorTuple,
        //         //       );
        //         //     }),
        //         //   );
        //         //
        //         //
        //         // }),
        //       ],
        //     ),
        //     subChild: CommonInfoTextView<FindMissingProvider>(
        //         gameCategoryType: GameCategoryType.FIND_MISSING,
        //         folder: colorTuple.item1.folderName!,
        //
        //         color: colorTuple.item1.cellColor!)),
      ),
    );
  }
}

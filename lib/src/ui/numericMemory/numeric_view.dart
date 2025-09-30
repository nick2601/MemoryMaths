import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/numericMemory/numeric_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import 'numeric_provider.dart';

class NumericMemoryView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const NumericMemoryView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = true;

    bool isContinue = false;
    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;
    double height1 = getScreenPercentSize(context, 57);
    double height = getPercentSize(remainHeight, 70) / 5;

    double _crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    double mainHeight = getMainHeight(context);

    return StatefulBuilder(builder: (context, snapshot) {
      if (isFirstTime) {
        Future.delayed(
          Duration(seconds: 2),
          () {
            snapshot(() {
              isContinue = true;
              isFirstTime = false;
            });
          },
        );
      }
      print("hello===true");
      return MultiProvider(
        providers: [
          const VsyncProvider(),
          ChangeNotifierProvider<NumericMemoryProvider>(
              create: (context) => NumericMemoryProvider(
                  vsync: VsyncProvider.of(context),
                  level: colorTuple.item2,
                  isTimer: false,
                  nextQuiz: () {
                    snapshot(() {
                      isContinue = false;
                    });
                    print("isContinue====$isContinue");
                    Future.delayed(
                      Duration(seconds: 2),
                      () {
                        snapshot(() {
                          isContinue = true;
                        });
                      },
                    );

                    // print("isContinue====$isContinue");
                    // snapshot((){
                    //   isContinue = false;
                    // });
                  },
                  context: context))
        ],
        child: DialogListener<NumericMemoryProvider>(
          colorTuple: colorTuple,
          gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
          level: colorTuple.item2,
          nextQuiz: () {
            print("isNewData===true");
            // snapshot(() {
            //   isContinue = false;
            // });
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     snapshot(() {
            //       isContinue = true;
            //     });
            //   },
            // );
          },

          appBar: CommonAppBar<NumericMemoryProvider>(
              hint: false,
              infoView: CommonInfoTextView<NumericMemoryProvider>(
                  gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
                  folder: colorTuple.item1.folderName!,
                  color: colorTuple.item1.cellColor!),
              gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
              colorTuple: colorTuple,
              context: context,
              isTimer: false),

          child: CommonMainWidget<NumericMemoryProvider>(
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            color: colorTuple.item1.bgColor!,
            isTimer: false,
            primaryColor: colorTuple.item1.primaryColor!,
            subChild: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
                  child: Container(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    bottom: getPercentSize(mainHeight, 10)),

                                child: Selector<NumericMemoryProvider,
                                        NumericMemoryPair>(
                                    selector: (p0, p1) => p1.currentState,
                                    builder: (context, currentState, child) {
                                      return Center(
                                        child: getTextWidget(
                                            Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            currentState.question.toString(),
                                            TextAlign.center,
                                            getPercentSize(remainHeight, 5)),
                                      );
                                    }),
                              ),
                            ),
                            Container(
                              height: height1,
                              decoration: getCommonDecoration(context),
                              alignment: Alignment.bottomCenter,
                              child: Consumer<NumericMemoryProvider>(
                                  builder: (context, provider, child) {
                                return GridView.count(
                                  crossAxisCount: _crossAxisCount,
                                  childAspectRatio: _aspectRatio,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSpace(context),
                                      vertical: getHorizontalSpace(context)),
                                  crossAxisSpacing: _crossAxisSpacing,
                                  mainAxisSpacing: _crossAxisSpacing,
                                  primary: false,
                                  children: List.generate(
                                      provider.currentState.list.length,
                                      (index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              getHorizontalSpace(context) / 1.5,
                                          vertical:
                                              getHorizontalSpace(context) /
                                                  1.5),
                                      child: NumericMemoryButton(
                                        height: height,
                                        mathPairs: provider.currentState,
                                        index: index,
                                        function: () {
                                          if (provider.currentState.list[index]
                                                  .key ==
                                              provider.currentState.answer) {
                                            provider.currentState.list[index]
                                                .isCheck = true;
                                          } else {
                                            provider.currentState.list[index]
                                                .isCheck = false;
                                          }
                                          setState(() {
                                            isContinue = false;
                                          });
                                          context
                                              .read<NumericMemoryProvider>()
                                              .checkResult(
                                                  provider.currentState
                                                      .list[index].key!,
                                                  index);
                                        },
                                        isContinue: isContinue,
                                        colorTuple: Tuple2(
                                            colorTuple.item1.primaryColor!,
                                            colorTuple.item1.backgroundColor!),
                                      ),
                                    );
                                  }),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            context: context,
            isTopMargin: false,
          ),
          // child: getCommonWidget(
          //   context: context,
          //   isTopMargin: false,
          //   child: StatefulBuilder(builder: (context, setState) {
          //     return Column(
          //       children: <Widget>[
          //         Expanded(
          //           flex: 1,
          //           child: Selector<NumericMemoryProvider, NumericMemoryPair>(
          //               selector: (p0, p1) => p1.currentState,
          //               builder: (context, currentAnswer, child) {
          //                 return Center(
          //                   child: getTextWidget(
          //                       Theme.of(context)
          //                           .textTheme
          //                           .subtitle2!
          //                           .copyWith(fontWeight: FontWeight.bold),
          //                       currentAnswer.question.toString(),
          //                       TextAlign.center,
          //                       getPercentSize(remainHeight, 5)),
          //                 );
          //               }),
          //         ),
          //         Consumer<NumericMemoryProvider>(
          //             builder: (context, provider, child) {
          //           return GridView.count(
          //             crossAxisCount: _crossAxisCount,
          //             childAspectRatio: _aspectRatio,
          //             shrinkWrap: true,
          //             padding: EdgeInsets.symmetric(
          //                 horizontal: getHorizontalSpace(context) / 2,
          //                 vertical: getHorizontalSpace(context)),
          //             crossAxisSpacing: _crossAxisSpacing,
          //             mainAxisSpacing: _crossAxisSpacing,
          //             primary: false,
          //             children: List.generate(provider.currentState.list.length,
          //                 (index) {
          //               return NumericMemoryButton(
          //                 height: height,
          //                 mathPairs: provider.currentState,
          //                 index: index,
          //                 function: () {
          //                   if (provider.currentState.list[index].key ==
          //                       provider.currentState.answer) {
          //                     provider.currentState.list[index].isCheck = true;
          //                   } else {
          //                     provider.currentState.list[index].isCheck = false;
          //                   }
          //                   setState(() {
          //                     isContinue = false;
          //                   });
          //                   context.read<NumericMemoryProvider>().checkResult(
          //                       provider.currentState.list[index].key!, index);
          //                 },
          //                 isContinue: isContinue,
          //                 colorTuple: Tuple2(colorTuple.item1.primaryColor!,
          //                     colorTuple.item1.primaryColor!),
          //               );
          //             }),
          //           );
          //         }),
          //       ],
          //     );
          //   }),
          //   subChild: CommonInfoTextView<NumericMemoryProvider>(
          //       folder: colorTuple.item1.folderName!,
          //       gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
          //       color: colorTuple.item1.cellColor!),
          // ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/RandomOptionData.dart';

import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';

import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/trueFalseQuiz/true_false_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../data/models/true_false_model.dart';
import '../../utility/Constants.dart';
import '../common/common_button.dart';
import '../common/common_main_widget.dart';

class TrueFalseView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  TrueFalseView({
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
        ChangeNotifierProvider<TrueFalseProvider>(
            create: (context) => TrueFalseProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<TrueFalseProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.TRUE_FALSE,
        level: colorTuple.item2,
        appBar: CommonAppBar<TrueFalseProvider>(
            infoView: CommonInfoTextView<TrueFalseProvider>(
                gameCategoryType: GameCategoryType.TRUE_FALSE,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.TRUE_FALSE,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<TrueFalseProvider>(
          gameCategoryType: GameCategoryType.TRUE_FALSE,
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
                            child: Selector<TrueFalseProvider, TrueFalseModel>(
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
                          return Selector<TrueFalseProvider, TrueFalseModel>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                print("valueG===true");

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: getPercentSize(height1, 10)),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: List.generate(2, (index) {
                                            String e = strFalse;

                                            Color color = Colors.red;

                                            if (index == 0) {
                                              color = Colors.green;
                                              e = strTrue;
                                            }
                                            return CommonButton(
                                              text: e,
                                              color: color,
                                              onTab: () {
                                                context
                                                    .read<TrueFalseProvider>()
                                                    .checkResult(e);
                                              },
                                            );
                                          }),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(),
                                        flex: 1,
                                      ),
                                    ],
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
        //                 Selector<TrueFalseProvider, TrueFalseModel>(
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
        //                               remainHeight, 5));
        //                     }),
        //
        //               ],
        //             ),
        //           ),
        //           flex: 1,
        //         ),
        //         Selector<TrueFalseProvider, TrueFalseModel>(
        //             selector: (p0, p1) => p1.currentState,
        //             builder: (context, currentState, child) {
        //
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
        //                 children: List.generate(2, (index) {
        //                   String e = strFalse;
        //
        //                   Color color =Colors.red;
        //
        //                   if(index==0){
        //                     color =Colors.green;
        //                     e = strTrue;
        //                   }
        //                   return CommonButton(
        //                     is4Matrix: true,
        //                     text: e,
        //                     totalHeight: remainHeight,
        //                     height: height,
        //                     onTab: () {
        //                       String answer = strFalse;
        //                       if(index==0){
        //
        //                         answer = strTrue;
        //                       }
        //
        //                       context.read<TrueFalseProvider>().checkResult(answer);
        //                     },
        //                     color: color,
        //                   );
        //                 }),
        //               );
        //
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
        //         //           context.read<TrueFalseProvider>().checkResult(e);
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
        //     subChild: CommonInfoTextView<TrueFalseProvider>(
        //         gameCategoryType: GameCategoryType.TRUE_FALSE,
        //         folder: colorTuple.item1.folderName!,
        //
        //         color: colorTuple.item1.cellColor!)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/RandomFindMissingData.dart';
import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_question_view.dart';
import 'package:mathsgames/src/ui/correctAnswer/correct_answer_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_neumorphic_view.dart';
import '../common/common_vertical_button.dart';

class CorrectAnswerView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const CorrectAnswerView({
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
        ChangeNotifierProvider<CorrectAnswerProvider>(
            create: (context) => CorrectAnswerProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<CorrectAnswerProvider>(
        gameCategoryType: GameCategoryType.CORRECT_ANSWER,
        level: colorTuple.item2,
        colorTuple: colorTuple,
        appBar: CommonAppBar<CorrectAnswerProvider>(
            infoView: CommonInfoTextView<CorrectAnswerProvider>(
                gameCategoryType: GameCategoryType.CORRECT_ANSWER,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.CORRECT_ANSWER,
            colorTuple: colorTuple,
            context: context),
        child: CommonMainWidget<CorrectAnswerProvider>(
          gameCategoryType: GameCategoryType.CORRECT_ANSWER,
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
                              Selector<CorrectAnswerProvider, CorrectAnswer>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder: (context, currentState, child) {
                                    return CorrectAnswerQuestionView(
                                      question: currentState.question,
                                      questionView: Selector<
                                          CorrectAnswerProvider,
                                          Tuple2<double, double>>(
                                        selector: (p0, p1) => Tuple2(
                                            p1.currentScore, p1.oldScore),
                                        builder: (context, tuple2, child) {
                                          return CommonWrongAnswerAnimationView(
                                            currentScore: tuple2.item1.toInt(),
                                            oldScore: tuple2.item2.toInt(),
                                            child: child!,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: getWidthPercentSize(
                                                  context, 2)),
                                          child: CommonNeumorphicView(
                                            isMargin: true,
                                            color: getBackGroundColor(context),
                                            width: getWidthPercentSize(
                                                context, 14),
                                            height: getWidthPercentSize(
                                                context, 14),
                                            child: Selector<
                                                    CorrectAnswerProvider,
                                                    String>(
                                                selector: (p0, p1) => p1.result,
                                                builder:
                                                    (context, result, child) {
                                                  return getTextWidget(
                                                      Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!,
                                                      result == ""
                                                          ? "?"
                                                          : result,
                                                      TextAlign.center,
                                                      getPercentSize(
                                                          remainHeight, 4));
                                                }),
                                          ),
                                        ),
                                      ),
                                    );
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
                          return Selector<CorrectAnswerProvider, CorrectAnswer>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                print("valueG===true");

                                final list = [
                                  currentState.firstAns,
                                  currentState.secondAns,
                                  currentState.thirdAns,
                                  currentState.fourthAns,
                                ];

                                shuffle(list);

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
                                                .read<CorrectAnswerProvider>()
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

        // getCommonWidget(context: context,
        //   isTopMargin: true,
        //   child: Column(
        //
        //   children: <Widget>[
        //
        //     Expanded(flex: 1,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Selector<CorrectAnswerProvider, CorrectAnswer>(
        //               selector: (p0, p1) => p1.currentState,
        //               builder: (context, currentState, child) {
        //                 return CorrectAnswerQuestionView(
        //                   question: currentState.question,
        //                   questionView: Selector<CorrectAnswerProvider,
        //                       Tuple2<double, double>>(
        //                     selector: (p0, p1) =>
        //                         Tuple2(p1.currentScore, p1.oldScore),
        //                     builder: (context, tuple2, child) {
        //                       return CommonWrongAnswerAnimationView(
        //                         currentScore: tuple2.item1.toInt(),
        //                         oldScore: tuple2.item2.toInt(),
        //                         child: child!,
        //                       );
        //                     },
        //                     child: CommonNeumorphicView(
        //                       color: colorTuple.item1.cellColor!,
        //                       width: getWidthPercentSize(context, 13),
        //                       height: getWidthPercentSize(context, 13),
        //                       child: Selector<CorrectAnswerProvider,
        //                           String>(
        //                           selector: (p0, p1) => p1.result,
        //                           builder: (context, result, child) {
        //                             return getTextWidget(
        //                                 Theme
        //                                     .of(context)
        //                                     .textTheme
        //                                     .subtitle2!.copyWith(color: colorTuple.item1.primaryColor),
        //                                 result == "" ? "?" : result,
        //                                 TextAlign.center,
        //                                 getPercentSize(
        //                                     remainHeight, 4));
        //
        //
        //                           }),
        //                     ),
        //                   ),
        //                 );
        //               }),
        //         ],
        //       ),
        //     ),
        //     Selector<CorrectAnswerProvider, CorrectAnswer>(
        //         selector: (p0, p1) => p1.currentState,
        //         builder: (context, currentState, child) {
        //
        //           final list=[ currentState.firstAns,
        //             currentState.secondAns,
        //             currentState.thirdAns,
        //             currentState.fourthAns,];
        //           return GridView.count(
        //             crossAxisCount: _crossAxisCount,
        //             childAspectRatio: _aspectRatio,
        //             shrinkWrap: true,
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: getHorizontalSpace(context),
        //                 vertical: getHorizontalSpace(context)),
        //             crossAxisSpacing: _crossAxisSpacing,
        //             mainAxisSpacing: _crossAxisSpacing,
        //             primary: false,
        //
        //             children: List.generate(list.length, (index) {
        //               String e = list[index];
        //               return CommonNumberButton(
        //                 is4Matrix: true,
        //                 text: e,
        //                 totalHeight: remainHeight,
        //                 height: height,
        //                 onTab: () {
        //                   context.read<CorrectAnswerProvider>().checkResult(e);
        //                 },
        //                 colorTuple: colorTuple,
        //               );
        //             }),
        //           );
        //
        //         }),
        //   ],
        // ), subChild: CommonInfoTextView<CorrectAnswerProvider>(
        //       folder: colorTuple.item1.folderName!,
        //
        //       gameCategoryType: GameCategoryType.CORRECT_ANSWER,color: colorTuple.item1.cellColor!),),
      ),
    );
  }
}

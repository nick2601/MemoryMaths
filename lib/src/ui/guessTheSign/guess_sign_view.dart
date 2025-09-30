import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/common_neumorphic_view.dart';
import 'package:mathsgames/src/ui/common/common_vertical_button.dart';
import 'package:mathsgames/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/guessTheSign/guess_sign_provider.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';

class GuessSignView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  GuessSignView({
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

    // Shuffle only once at the beginning, not on every rebuild
    List<String> shuffledList = List.from(list)..shuffle();

    print("value===1");
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<GuessSignProvider>(
            create: (context) => GuessSignProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<GuessSignProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.GUESS_SIGN,
        level: colorTuple.item2,
        appBar: CommonAppBar<GuessSignProvider>(
            infoView: CommonInfoTextView<GuessSignProvider>(
                gameCategoryType: GameCategoryType.GUESS_SIGN,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.GUESS_SIGN,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<GuessSignProvider>(
          gameCategoryType: GameCategoryType.GUESS_SIGN,
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
                              Selector<GuessSignProvider, Sign>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder: (context, provider, child) {
                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        provider.firstDigit,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),
                              SizedBox(width: getWidthPercentSize(context, 2)),
                              Selector<GuessSignProvider,
                                  Tuple2<double, double>>(
                                selector: (p0, p1) =>
                                    Tuple2(p1.currentScore, p1.oldScore),
                                builder: (context, tuple2, child) {
                                  return CommonWrongAnswerAnimationView(
                                    currentScore: tuple2.item1.toInt(),
                                    oldScore: tuple2.item2.toInt(),
                                    child: child!,
                                  );
                                },
                                child: CommonNeumorphicView(
                                  color: getBackGroundColor(context),
                                  isMargin: true,
                                  width: getWidthPercentSize(context, 15),
                                  height: getWidthPercentSize(context, 15),
                                  child: Selector<GuessSignProvider, String>(
                                    selector: (p0, p1) => p1.result,
                                    builder: (context, result, child) {
                                      return getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!,
                                          (result.length > 0) ? result : "?",
                                          TextAlign.center,
                                          getPercentSize(remainHeight, 4));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: getWidthPercentSize(context, 2)),
                              Selector<GuessSignProvider, Sign>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder: (context, provider, child) {
                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        provider.secondDigit,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),
                              SizedBox(width: getWidthPercentSize(context, 2)),
                              getTextWidget(
                                  Theme.of(context).textTheme.titleSmall!,
                                  '=',
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 4)),
                              SizedBox(width: getWidthPercentSize(context, 2)),
                              Selector<GuessSignProvider, Sign>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder: (context, provider, child) {
                                    print("valueG===true");

                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        provider.answer,
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
                        child: Selector<GuessSignProvider, Sign>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, provider, child) {
                              // Use the pre-shuffled list instead of shuffling on every rebuild
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: getPercentSize(height1, 10)),
                                child: Column(
                                  children:
                                      List.generate(shuffledList.length, (index) {
                                    String e = shuffledList[index];
                                    return CommonVerticalButton(
                                        text: e,
                                        onTab: () {
                                          context
                                              .read<GuessSignProvider>()
                                              .checkResult(e);
                                        },
                                        colorTuple: colorTuple);
                                  }),
                                ),
                              );
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

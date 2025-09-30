import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/mathGrid/math_grid_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';

class MathGridView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathGridView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;

    print("screenSize ====$screenWidth-----$screenHeight");
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 3);
      print("width ====$width");
    }

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathGridProvider>(
            create: (context) => MathGridProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<MathGridProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<MathGridProvider>(
            infoView: CommonInfoTextView<MathGridProvider>(
                gameCategoryType: GameCategoryType.MATH_GRID,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            hint: false,
            gameCategoryType: GameCategoryType.MATH_GRID,
            colorTuple: colorTuple,
            context: context),

        gameCategoryType: GameCategoryType.MATH_GRID,
        level: colorTuple.item2,

        child: CommonMainWidget<MathGridProvider>(
          gameCategoryType: GameCategoryType.MATH_GRID,
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
                          margin: EdgeInsets.only(
                              bottom: getPercentSize(mainHeight, 9)),
                          child: Center(
                            child: Selector<MathGridProvider, int>(
                                selector: (p0, p1) =>
                                    p1.currentState.currentAnswer,
                                builder: (context, currentAnswer, child) {
                                  return getTextWidget(
                                      Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                      currentAnswer.toString(),
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
                        child: Consumer<MathGridProvider>(
                            builder: (context, listForSquare, child) {
                          return Container(
                            decoration: getDefaultDecoration(
                                bgColor: colorTuple.item1.gridColor,
                                borderColor: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                                radius: getCommonRadius(context)),
                            margin: EdgeInsets.all(getHorizontalSpace(context)),
                            child: GridView.builder(
                                padding: EdgeInsets.all(
                                    getScreenPercentSize(context, 0.7)),
                                gridDelegate: (screenHeight < screenWidth)
                                    ? SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 9,
                                        childAspectRatio:
                                            getScreenPercentSize(context, 0.3),
                                      )
                                    : SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 9,
                                      ),
                                itemCount: listForSquare
                                    .currentState.listForSquare.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return MathGridButton(
                                    gridModel: listForSquare
                                        .currentState.listForSquare[index],
                                    index: index,
                                    colorTuple: Tuple2(
                                        colorTuple.item1.primaryColor!,
                                        colorTuple.item1.backgroundColor!),
                                  );
                                }),
                          );
                        }),

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

        // child: getCommonWidget(context: context,
        //   isTopMargin: true,
        //   child: Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: Selector<MathGridProvider, int>(
        //           selector: (p0, p1) =>
        //           p1.currentState.currentAnswer,
        //           builder: (context, currentAnswer, child) {
        //             return getTextWidget(
        //                 Theme
        //                     .of(context)
        //                     .textTheme
        //                     .subtitle2!.copyWith(fontWeight: FontWeight.bold),
        //                 currentAnswer.toString(),
        //                 TextAlign.center,
        //                 getPercentSize(
        //                     remainHeight, 4));
        //           }),
        //     ),
        //     Container(
        //       margin: EdgeInsets.symmetric(horizontal: (getHorizontalSpace(context)/2)),
        //
        //       child: ClipRRect(
        //
        //         borderRadius: BorderRadius.circular(radius),
        //         child: Container(
        //
        //           alignment: Alignment.center,
        //
        //
        //           decoration: getDefaultDecorationWithGradient(colors:
        //
        //           LinearGradient(
        //                 colors: [ lighten(colorTuple.item1.primaryColor!,0.05),darken(colorTuple.item1.primaryColor!,0.05)],
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //               )
        //           ),
        //
        //
        //           child: Consumer<MathGridProvider>(
        //               builder: (context, listForSquare, child) {
        //                 return Container(
        //                   child: GridView.builder(
        //                       gridDelegate:
        //                       (screenHeight < screenWidth)? SliverGridDelegateWithFixedCrossAxisCount(
        //                           crossAxisCount: 9,
        //
        //                         childAspectRatio: getScreenPercentSize(context, 0.3),
        //                       ):SliverGridDelegateWithFixedCrossAxisCount(
        //                         crossAxisCount: 9,
        //                       ),
        //                       itemCount: listForSquare
        //                           .currentState.listForSquare.length,
        //                       shrinkWrap: true,
        //
        //                       physics: NeverScrollableScrollPhysics(),
        //                       itemBuilder: (BuildContext context, int index) {
        //                         return MathGridButton(
        //                           gridModel: listForSquare.currentState.listForSquare[index],
        //                           index: index,
        //                           colorTuple: Tuple2(colorTuple.item1.primaryColor!,colorTuple.item1.primaryColor!),
        //                         );
        //                       }),
        //                 );
        //               }),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: getPercentSize(remainHeight, 2.5),)
        //   ],
        // ), subChild:      CommonInfoTextView<MathGridProvider>(
        //       folder: colorTuple.item1.folderName!,
        //
        //       gameCategoryType: GameCategoryType.MATH_GRID,color: colorTuple.item1.cellColor!),),
      ),
    );
  }
}

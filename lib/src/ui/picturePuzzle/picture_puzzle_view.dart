import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_button.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/global_constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';

class PicturePuzzleView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  PicturePuzzleView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Clear",
    "0",
    "Back"
  ];

  @override
  Widget build(BuildContext context) {
    // double remainHeight =getRemainHeight(context: context);
    // int _crossAxisCount = 3;
    // double height = getPercentSize(remainHeight, 75) / 5.5;
    //
    // double _crossAxisSpacing = getPercentSize(height, 12);
    // var widthItem = (getWidthPercentSize(context, 100) -
    //     ((_crossAxisCount - 1) * _crossAxisSpacing)) /
    //     _crossAxisCount;
    //
    // double _aspectRatio = widthItem / height;
    //
    // double mainHeight = getMainHeight(context);

    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;

    double height1 = getScreenPercentSize(context, 42);
    double height = height1 / 4.5;
    double radius = getPercentSize(height, 35);

    double _crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<PicturePuzzleProvider>(
            create: (context) => PicturePuzzleProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<PicturePuzzleProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<PicturePuzzleProvider>(
            hint: false,
            infoView: CommonInfoTextView<PicturePuzzleProvider>(
                gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
            colorTuple: colorTuple,
            context: context),

        gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
        level: colorTuple.item2,

        child: CommonMainWidget<PicturePuzzleProvider>(
          gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: getPercentSize(remainHeight, 2),
                  ),
                  Expanded(
                    flex: 1,
                    child: Selector<PicturePuzzleProvider, PicturePuzzle>(
                        selector: (p0, p1) => p1.currentState,
                        builder: (context, provider, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.list.mapIndexed((index, list) {
                              return Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (margin * 2)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: list.shapeList.map((subList) {
                                      return PicturePuzzleButton(
                                        picturePuzzleShape: subList,
                                        shapeColor:
                                            colorTuple.item1.primaryColor!,
                                        colorTuple: Tuple2(
                                            colorTuple.item1.cellColor!,
                                            colorTuple.item1.primaryColor!),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),

                  Container(
                    height: height1,
                    decoration: getCommonDecoration(context),
                    alignment: Alignment.bottomCenter,
                    child: Builder(builder: (context) {
                      return Center(
                        child: GridView.count(
                          crossAxisCount: _crossAxisCount,
                          childAspectRatio: _aspectRatio,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            right: (margin * 2),
                            left: (margin * 2),
                          ),
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _crossAxisSpacing,
                          primary: false,
                          // padding: EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                          children: List.generate(list.length, (index) {
                            String e = list[index];
                            if (e == "Clear") {
                              return CommonClearButton(
                                  text: "Clear",
                                  btnRadius: radius,
                                  height: height,
                                  onTab: () {
                                    context
                                        .read<PicturePuzzleProvider>()
                                        .clearResult();
                                  });
                            } else if (e == "Back") {
                              return CommonBackButton(
                                onTab: () {
                                  context
                                      .read<PicturePuzzleProvider>()
                                      .backPress();
                                },
                                height: height,
                                btnRadius: radius,
                              );
                            } else {
                              return CommonNumberButton(
                                text: e,
                                totalHeight: remainHeight,
                                height: height,
                                btnRadius: radius,
                                onTab: () {
                                  context
                                      .read<PicturePuzzleProvider>()
                                      .checkGameResult(e);
                                },
                                colorTuple: colorTuple,
                              );
                            }
                          }),
                        ),
                      );
                    }),
                  ),
                  // Builder(builder: (context) {
                  //   return GridView.count(
                  //     crossAxisCount: _crossAxisCount,
                  //     childAspectRatio: _aspectRatio,
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: getHorizontalSpace(
                  //             context),
                  //         vertical: getHorizontalSpace(
                  //             context)),
                  //     crossAxisSpacing: _crossAxisSpacing,
                  //     mainAxisSpacing: _crossAxisSpacing,
                  //     primary: false,
                  //     children:
                  //     List.generate(list.length, (index) {
                  //       String e = list[index];
                  //       if (e == "Clear") {
                  //         return CommonClearButton(
                  //             text: "Clear",
                  //             height: height,
                  //             onTab: () {
                  //               context
                  //                   .read<PicturePuzzleProvider>()
                  //                   .clearResult();
                  //             });
                  //       } else if (e == "Back") {
                  //         return CommonBackButton(
                  //           onTab: () {
                  //             context.read<
                  //                 PicturePuzzleProvider>()
                  //                 .backPress();
                  //           },
                  //           height: height,
                  //         );
                  //       } else {
                  //         return
                  //           CommonNumberButton(
                  //             text: e,
                  //             isDarken: false,
                  //             totalHeight: remainHeight,
                  //             height: height,
                  //             colorTuple: colorTuple,
                  //             onTab: () {
                  //               context.read<PicturePuzzleProvider>().checkGameResult(e);
                  //             },
                  //           );
                  //       }
                  //     }),
                  //   );
                  // }),
                ],
              ),
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
        // child: getCommonWidget(context: context,isTopMargin: true, child: Column(
        //   children: <Widget>[
        //
        //     SizedBox(height: getPercentSize(remainHeight, 2),),
        //     Expanded(
        //       flex: 1,
        //       child: Selector<PicturePuzzleProvider, PicturePuzzle>(
        //           selector: (p0, p1) => p1.currentState,
        //           builder: (context, provider, child) {
        //             return Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: provider.list.mapIndexed((index, list) {
        //                 return Expanded(
        //                   flex: 1,
        //                   child: Padding(
        //                     padding: EdgeInsets.symmetric(
        //                         // vertical:0),
        //                         vertical: index == 3 ? 6 : 12),
        //                     child: Row(
        //                       crossAxisAlignment:
        //                       CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: list.shapeList.map((subList) {
        //                         return PicturePuzzleButton(
        //                           picturePuzzleShape: subList,
        //                           shapeColor: colorTuple.item1.primaryColor!,
        //                           colorTuple: Tuple2(
        //                               colorTuple.item1.cellColor!,colorTuple.item1.primaryColor!
        //                           ),
        //                         );
        //                       }).toList(),
        //                     ),
        //                   ),
        //                 );
        //               }).toList(),
        //             );
        //           }),
        //     ),
        //
        //     Builder(builder: (context) {
        //       return GridView.count(
        //         crossAxisCount: _crossAxisCount,
        //         childAspectRatio: _aspectRatio,
        //         shrinkWrap: true,
        //         padding: EdgeInsets.symmetric(
        //             horizontal: getHorizontalSpace(
        //                 context),
        //             vertical: getHorizontalSpace(
        //                 context)),
        //         crossAxisSpacing: _crossAxisSpacing,
        //         mainAxisSpacing: _crossAxisSpacing,
        //         primary: false,
        //         children:
        //         List.generate(list.length, (index) {
        //           String e = list[index];
        //           if (e == "Clear") {
        //             return CommonClearButton(
        //                 text: "Clear",
        //                 height: height,
        //                 onTab: () {
        //                   context
        //                       .read<PicturePuzzleProvider>()
        //                       .clearResult();
        //                 });
        //           } else if (e == "Back") {
        //             return CommonBackButton(
        //               onTab: () {
        //                 context.read<
        //                     PicturePuzzleProvider>()
        //                     .backPress();
        //               },
        //               height: height,
        //             );
        //           } else {
        //             return
        //               CommonNumberButton(
        //               text: e,
        //                 isDarken: false,
        //                 totalHeight: remainHeight,
        //                   height: height,
        //               colorTuple: colorTuple,
        //               onTab: () {
        //                 context.read<PicturePuzzleProvider>().checkGameResult(e);
        //               },
        //             );
        //           }
        //         }),
        //       );
        //     }),
        //   ],
        // ), subChild:  CommonInfoTextView<PicturePuzzleProvider>(
        //     folder: colorTuple.item1.folderName!,
        //
        //     gameCategoryType: GameCategoryType.PICTURE_PUZZLE,color: colorTuple.item1.cellColor!),),
      ),
    );
  }
}

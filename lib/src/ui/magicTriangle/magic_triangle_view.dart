import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_3x3.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_4x4.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_3x3.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_4x4.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

BoxDecoration getCommonDecoration(BuildContext context, Color bgColor) {
  return BoxDecoration(
    color: bgColor,
    borderRadius: BorderRadius.circular(16),
  );
}

class MagicTriangleView extends ConsumerWidget {
  final double padding = 0;
  final double radius = 30;
  final Tuple2<GradientModel, int> colorTuple1;

  const MagicTriangleView({
    Key? key,
    required this.colorTuple1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(magicTriangleProvider(colorTuple1.item2));
    final Tuple2<Color, Color> colorTuple =
    Tuple2(colorTuple1.item1.primaryColor!, colorTuple1.item1.cellColor!);

    double height1 = getScreenPercentSize(context, 58);
    double mainHeight = getMainHeight(context);

    final bgColor = colorTuple1.item1.bgColor ?? Theme.of(context).scaffoldBackgroundColor;

    return DialogListener(
      colorTuple: colorTuple1,
      gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
      level: colorTuple1.item2,
      appBar: CommonAppBar(
        showHint: false,
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
          folder: colorTuple1.item1.folderName!,
          color: colorTuple1.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        colorTuple: colorTuple1,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        color: bgColor,
        primaryColor: colorTuple1.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: getPercentSize(mainHeight, 9)),
                  child: Center(
                    child: getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      state.currentState?.answer.toString() ?? "",
                      TextAlign.center,
                      getPercentSize(mainHeight, 10),
                    ),
                  ),
                ),
              ),
              Container(
                height: height1,
                decoration: getCommonDecoration(context, bgColor),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              state.currentState?.is3x3 == true
                                  ? Triangle3x3(
                                radius: radius,
                                padding: padding,
                                triangleHeight: height1,
                                triangleWidth: constraints.maxWidth,
                                colorTuple: colorTuple,
                                level: colorTuple1.item2,
                              )
                                  : Triangle4x4(
                                radius: radius,
                                padding: padding,
                                triangleHeight: constraints.maxWidth,
                                triangleWidth: constraints.maxWidth,
                                colorTuple: colorTuple,
                                level: colorTuple1.item2,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: getPercentSize(height1, 3)),
                    state.currentState?.is3x3 == true
                        ? TriangleInput3x3(
                      colorTuple: colorTuple,
                      level: colorTuple1.item2,
                    )
                        : TriangleInput4x4(
                      colorTuple: colorTuple,
                      level: colorTuple1.item2,
                    ),
                    SizedBox(height: getPercentSize(height1, 3)),
                  ],
                ),
              ),
            ],
          ),
        ),
        isTopMargin: false,
      ),
    );
  }
}

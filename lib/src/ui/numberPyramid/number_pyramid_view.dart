import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/common/common_main_widget.dart';
import 'package:mathsgames/src/ui/common/common_number_button.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_button.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class NumberPyramidView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple1;

  NumberPyramidView({
    Key? key,
    required this.colorTuple1,
  }) : super(key: key);

  final List<String> list = const [
    "7", "8", "9",
    "4", "5", "6",
    "1", "2", "3",
    "Done", "0", "Back"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(numberPyramidProvider(colorTuple1.item2));
    final notifier = ref.read(numberPyramidProvider(colorTuple1.item2).notifier);

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

    Tuple2<Color, Color> colorTuple = Tuple2(
      colorTuple1.item1.primaryColor!,
      colorTuple1.item1.primaryColor!,
    );

    double space = 0.8;
    double verticalSpace = 0.6;

    // Add null safety check
    if (state.currentState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DialogListener(
      colorTuple: colorTuple1,
      gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
      level: colorTuple1.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
          folder: colorTuple1.item1.folderName!,
          color: colorTuple1.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
        colorTuple: colorTuple1,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
        color: colorTuple1.item1.bgColor!,
        primaryColor: colorTuple1.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 40)),
          child: Column(
            children: <Widget>[
              SizedBox(height: getPercentSize(remainHeight, 6)),
              // Pyramid layout
              Expanded(
                flex: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Top cell
                          PyramidNumberButton(
                            numPyramidCellModel: state.currentState!.list[27],
                            isLeftRadius: true,
                            isRightRadius: true,
                            height: constraints.maxWidth,
                            buttonHeight: remainHeight,
                            colorTuple: colorTuple,
                            level: colorTuple1.item2,
                          ),
                          SizedBox(height: verticalSpace),
                          // Second row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PyramidNumberButton(
                                numPyramidCellModel: state.currentState!.list[26],
                                isLeftRadius: true,
                                height: constraints.maxWidth,
                                buttonHeight: remainHeight,
                                colorTuple: colorTuple,
                                level: colorTuple1.item2,
                              ),
                              SizedBox(width: space),
                              PyramidNumberButton(
                                numPyramidCellModel: state.currentState!.list[25],
                                isRightRadius: true,
                                height: constraints.maxWidth,
                                buttonHeight: remainHeight,
                                colorTuple: colorTuple,
                                level: colorTuple1.item2,
                              ),
                            ],
                          ),
                          // Add more rows as needed...
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: getPercentSize(remainHeight, 2)),
              // Number pad
              Container(
                height: height1,
                decoration: getDefaultDecoration(
                  bgColor: colorTuple1.item1.gridColor,
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: getCommonRadius(context),
                ),
                alignment: Alignment.bottomCenter,
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
                  children: List.generate(list.length, (index) {
                    String e = list[index];
                    if (e == "Done") {
                      return CommonClearButton(
                        text: "Done",
                        height: height,
                        btnRadius: radius,
                        onTab: () => notifier.pyramidBoxInputValue(e),
                      );
                    } else if (e == "Back") {
                      return CommonBackButton(
                        btnRadius: radius,
                        onTab: () => notifier.pyramidBoxInputValue(e),
                        height: height,
                      );
                    } else {
                      return CommonNumberButton(
                        text: e,
                        totalHeight: remainHeight,
                        height: height,
                        btnRadius: radius,
                        onTab: () => notifier.pyramidBoxInputValue(e),
                        colorTuple: colorTuple1,
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
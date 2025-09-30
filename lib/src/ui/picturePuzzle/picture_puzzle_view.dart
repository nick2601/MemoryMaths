import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/common/common_back_button.dart';
import 'package:mathsgames/src/ui/common/common_clear_button.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/picturePuzzle/picture_puzzle_button.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';

class PicturePuzzleView extends ConsumerWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const PicturePuzzleView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List<String> keypad = const [
    "7", "8", "9",
    "4", "5", "6",
    "1", "2", "3",
    "Clear", "0", "Back"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainHeight = getRemainHeight(context: context);
    final mainHeight = getMainHeight(context);

    const _crossAxisCount = 3;
    final height1 = getScreenPercentSize(context, 42);
    final height = height1 / 4.5;
    final radius = getPercentSize(height, 35);

    final _crossAxisSpacing = getPercentSize(height, 20);
    final widthItem = (getWidthPercentSize(context, 100) -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    final _aspectRatio = widthItem / height;
    final margin = getHorizontalSpace(context);

    // Access state with just level parameter
    final state = ref.watch(picturePuzzleProvider(colorTuple.item2));
    final notifier = ref.read(picturePuzzleProvider(colorTuple.item2).notifier);

    if (state.currentState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DialogListener(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
      level: colorTuple.item2,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
          folder: colorTuple.item1.folderName!,
          color: colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
        colorTuple: colorTuple,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
        color: colorTuple.item1.bgColor!,
        primaryColor: colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
          child: Column(
            children: [
              SizedBox(height: getPercentSize(remainHeight, 2)),
              // Puzzle grid
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.currentState!.list.mapIndexed((rowIndex, row) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: row.shapeList.map((shape) {
                            return PicturePuzzleButton(
                              picturePuzzleShape: shape,
                              shapeColor: colorTuple.item1.primaryColor!,
                              colorTuple: Tuple2(
                                colorTuple.item1.cellColor!,
                                colorTuple.item1.primaryColor!,
                              ),
                              level: colorTuple.item2,
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Keypad
              Container(
                height: height1,
                decoration: getDefaultDecoration(
                  bgColor: colorTuple.item1.gridColor,
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: getCommonRadius(context),
                ),
                alignment: Alignment.bottomCenter,
                child: GridView.count(
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: _aspectRatio,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: margin * 2),
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _crossAxisSpacing,
                  primary: false,
                  children: keypad.map((e) {
                    if (e == "Clear") {
                      return CommonClearButton(
                        text: "Clear",
                        btnRadius: radius,
                        height: height,
                        onTab: () => notifier.clearResult(),
                      );
                    } else if (e == "Back") {
                      return CommonBackButton(
                        btnRadius: radius,
                        height: height,
                        onTab: () => notifier.backPress(),
                      );
                    } else {
                      return CommonNumberButton(
                        text: e,
                        totalHeight: remainHeight,
                        height: height,
                        btnRadius: radius,
                        colorTuple: colorTuple,
                        onTab: () => notifier.checkGameResult(e),
                      );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
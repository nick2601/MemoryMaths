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

class NumericMemoryView extends StatefulWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const NumericMemoryView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  State<NumericMemoryView> createState() => _NumericMemoryViewState();
}

class _NumericMemoryViewState extends State<NumericMemoryView>
    with TickerProviderStateMixin {
  bool isFirstTime = true;
  bool isContinue = false;
  Timer? _initialTimer;
  Timer? _nextQuizTimer;
  NumericMemoryProvider? _provider;

  @override
  void initState() {
    super.initState();
    // Start the initial delay timer
    _startInitialTimer();
  }

  void _startInitialTimer() {
    _initialTimer?.cancel();
    _initialTimer = Timer(Duration(seconds: 3), () { // Increased from 2 to 3 seconds
      if (mounted) {
        setState(() {
          isContinue = true;
          isFirstTime = false;
        });
      }
    });
  }

  void _handleNextQuiz() {
    if (!mounted) return;

    setState(() {
      isContinue = false;
    });

    _nextQuizTimer?.cancel();
    _nextQuizTimer = Timer(Duration(seconds: 3), () { // Increased from 2 to 3 seconds
      if (mounted) {
        setState(() {
          isContinue = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _initialTimer?.cancel();
    _nextQuizTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<NumericMemoryProvider>(
          create: (context) {
            _provider = NumericMemoryProvider(
              vsync: this, // Use the StatefulWidget's TickerProvider
              level: widget.colorTuple.item2,
              isTimer: false,
              nextQuiz: _handleNextQuiz,
              context: context,
            );
            return _provider!;
          },
        ),
      ],
      child: Consumer<NumericMemoryProvider>(
        builder: (context, controller, child) {
          return DialogListener<NumericMemoryProvider>(
            colorTuple: widget.colorTuple,
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            level: widget.colorTuple.item2,
            nextQuiz: () {},
            appBar: CommonAppBar<NumericMemoryProvider>(
              hint: false,
              infoView: CommonInfoTextView<NumericMemoryProvider>(
                gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
                folder: widget.colorTuple.item1.folderName!,
                color: widget.colorTuple.item1.cellColor!,
              ),
              gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
              colorTuple: widget.colorTuple,
              context: context,
              isTimer: false,
            ),
            child: CommonMainWidget<NumericMemoryProvider>(
              gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
              color: widget.colorTuple.item1.bgColor!,
              levelNo: controller.levelNo, // Dynamic level from provider
              provider: controller, // Provider reference for level updates
              isTimer: false,
              primaryColor: widget.colorTuple.item1.primaryColor!,
              subChild: Container(
                margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: getPercentSize(mainHeight, 10),
                            ),
                            child: Consumer<NumericMemoryProvider>(
                              builder: (context, controller, child) {
                                return Center(
                                  child: getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    controller.currentState.question.toString(),
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 5),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: height1,
                          decoration: getCommonDecoration(context),
                          alignment: Alignment.bottomCenter,
                          child: Consumer<NumericMemoryProvider>(
                            builder: (context, controller, child) {
                              return GridView.count(
                                crossAxisCount: _crossAxisCount,
                                childAspectRatio: _aspectRatio,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSpace(context),
                                  vertical: getHorizontalSpace(context),
                                ),
                                crossAxisSpacing: _crossAxisSpacing,
                                mainAxisSpacing: _crossAxisSpacing,
                                primary: false,
                                children: List.generate(
                                  controller.currentState.list.length,
                                  (index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: getHorizontalSpace(context) / 1.5,
                                        vertical: getHorizontalSpace(context) / 1.5,
                                      ),
                                      child: NumericMemoryButton(
                                        height: height,
                                        mathPairs: controller.currentState,
                                        index: index,
                                        function: () {
                                          // Only process if buttons are interactive and game not over
                                          if (!isContinue || controller.dialogType == DialogType.over) {
                                            return;
                                          }

                                          if (controller.currentState.list[index].key ==
                                              controller.currentState.answer) {
                                            controller.currentState.list[index].isCheck = true;
                                          } else {
                                            controller.currentState.list[index].isCheck = false;
                                          }

                                          setState(() {
                                            isContinue = false;
                                          });

                                          controller.checkResult(
                                            controller.currentState.list[index].key!,
                                            index,
                                          );
                                        },
                                        isContinue: isContinue,
                                        colorTuple: Tuple2(
                                          widget.colorTuple.item1.primaryColor!,
                                          widget.colorTuple.item1.backgroundColor!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              context: context,
              isTopMargin: false,
            ),
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_app_bar.dart';
import 'package:mathsgames/src/ui/common/common_info_text_view.dart';
import 'package:mathsgames/src/ui/common/dialog_listener.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/numericMemory/numeric_button.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import 'numeric_provider.dart';

class NumericMemoryView extends ConsumerStatefulWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const NumericMemoryView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  ConsumerState<NumericMemoryView> createState() =>
      _NumericMemoryViewState();
}

class _NumericMemoryViewState extends ConsumerState<NumericMemoryView> {
  bool isContinue = false;

  @override
  void initState() {
    super.initState();
    // Initial delay before enabling taps
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isContinue = true);
      }
    });
  }

  void _lockAndUnlock() {
    setState(() => isContinue = false);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => isContinue = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainHeight = getRemainHeight(context: context);
    const crossAxisCount = 3;
    final height1 = getScreenPercentSize(context, 57);
    final height = getPercentSize(remainHeight, 70) / 5;
    final crossAxisSpacing = getPercentSize(height, 14);
    final widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    final aspectRatio = widthItem / height;
    final mainHeight = getMainHeight(context);

    final level = widget.colorTuple.item2;
    final provider = numericMemoryProvider(level);

    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    // Add null safety check
    if (state.currentState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DialogListener(
      colorTuple: widget.colorTuple,
      gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
      level: level,
      nextQuiz: _lockAndUnlock,
      appBar: CommonAppBar(
        infoView: CommonInfoTextView(
          gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
          folder: widget.colorTuple.item1.folderName!,
          color: widget.colorTuple.item1.cellColor!,
        ),
        gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
        colorTuple: widget.colorTuple,
        isTimer: false,
      ),
      child: CommonMainWidget(
        gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
        color: widget.colorTuple.item1.bgColor!,
        primaryColor: widget.colorTuple.item1.primaryColor!,
        isTopMargin: false,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Column(
            children: [
              // Question text
              Expanded(
                flex: 1,
                child: Container(
                  margin:
                  EdgeInsets.only(bottom: getPercentSize(mainHeight, 10)),
                  child: Center(
                    child: getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      state.currentState!.question.toString(),
                      TextAlign.center,
                      getPercentSize(remainHeight, 5),
                    ),
                  ),
                ),
              ),
              // Grid of answers
              Container(
                height: height1,
                decoration: getDefaultDecoration(
                  bgColor: widget.colorTuple.item1.gridColor,
                  borderColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: getCommonRadius(context),
                ),
                alignment: Alignment.bottomCenter,
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: aspectRatio,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: getHorizontalSpace(context),
                    vertical: getHorizontalSpace(context),
                  ),
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: crossAxisSpacing,
                  primary: false,
                  children: List.generate(
                    state.currentState!.options.length,
                        (index) {
                      final item = state.currentState!.options[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: getHorizontalSpace(context) / 1.5,
                          vertical: getHorizontalSpace(context) / 1.5,
                        ),
                        child: NumericMemoryButton(
                          height: height,
                          mathPairs: state.currentState!,
                          index: index,
                          isContinue: isContinue,
                          colorTuple: Tuple2(
                            widget.colorTuple.item1.primaryColor!,
                            widget.colorTuple.item1.backgroundColor!,
                          ),
                          onTap: () {
                            // Update the state immutably using copyWith
                            final updatedOptions = [...state.currentState!.options];
                            if (item.key == state.currentState!.answer) {
                              updatedOptions[index] = item.copyWith(isCheck: true);
                            } else {
                              updatedOptions[index] = item.copyWith(isCheck: false);
                            }

                            _lockAndUnlock();
                            notifier.checkResult(item.key, index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
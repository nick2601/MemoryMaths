import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/quick_calculation.dart';
import '../../utility/global_constants.dart';

class QuickCalculationQuestionView extends StatefulWidget {
  final QuickCalculation currentState;
  final QuickCalculation nextCurrentState;
  final QuickCalculation? previousCurrentState;

  const QuickCalculationQuestionView({
    Key? key,
    required this.currentState,
    required this.nextCurrentState,
    required this.previousCurrentState,
  }) : super(key: key);

  @override
  _QuickCalculationQuestionViewState createState() =>
      _QuickCalculationQuestionViewState();
}

class _QuickCalculationQuestionViewState
    extends State<QuickCalculationQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
  }

  @override
  void didUpdateWidget(QuickCalculationQuestionView oldWidget) {
    if (oldWidget.currentState != widget.currentState) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!,
              widget.currentState.question,
              TextAlign.center,
              getPercentSize(getRemainHeight(context: context), 4)),
        ),

        // AnimatedBuilder(
        //   animation: _animation,
        //   builder: (context, child) {
        //     return Align(
        //       alignment: _animation.value,
        //       child:  getTextWidget(
        //           Theme
        //               .of(context)
        //               .textTheme
        //               .subtitle2!,
        //           widget.currentState.question,
        //           TextAlign.center,
        //           getPercentSize(
        //               getRemainHeight(context: context),4)),
        //
        //
        //     );
        //   },
        // ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: FadeTransition(
        //     opacity: _opacityAnimationOut,
        //     child: getTextWidget(
        //         Theme
        //             .of(context)
        //             .textTheme
        //             .subtitle2!,
        //         widget.previousCurrentState?.question ?? "",
        //         TextAlign.center,
        //         getPercentSize(
        //             getRemainHeight(context: context),4)),
        //
        //
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: FadeTransition(
        //     opacity: _opacityAnimationIn,
        //     child:  getTextWidget(
        //         Theme
        //             .of(context)
        //             .textTheme
        //             .caption!.copyWith(color: Colors.grey),
        //         widget.nextCurrentState.question,
        //         TextAlign.center,
        //         getPercentSize(
        //             getRemainHeight(context: context),2)),
        //
        //
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

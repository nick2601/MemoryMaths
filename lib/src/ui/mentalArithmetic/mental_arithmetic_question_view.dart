import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/mental_arithmetic.dart';

import '../../utility/global_constants.dart';

class MentalArithmeticQuestionView extends StatefulWidget {
  final MentalArithmetic currentState;
  final bool shouldStartAnimation; // Add this prop to control animation timing
  final VoidCallback? onAnimationCompleted; // Add callback for animation completion

  const MentalArithmeticQuestionView({
    Key? key,
    required this.currentState,
    this.shouldStartAnimation = true, // Default to true for backward compatibility
    this.onAnimationCompleted,
  }) : super(key: key);

  @override
  _MentalArithmeticQuestionViewState createState() =>
      _MentalArithmeticQuestionViewState();
}

class _MentalArithmeticQuestionViewState
    extends State<MentalArithmeticQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  late Animation<AlignmentGeometry> _animation1;
  late final Animation<double> _opacityAnimationOut;
  late final Animation<double> _opacityAnimationIn;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000), // Increased from 1500ms to 3000ms for easier memorization
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (index < 3) {
            index++;
            _controller.forward(from: 0);
          } else {
            // Call the callback function when the animation sequence completes
            widget.onAnimationCompleted?.call();
          }
        }
      });

    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.centerRight,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.8,
          curve: Curves.ease,
        ),
      ),
    );

    _animation1 = Tween<AlignmentGeometry>(
      begin: Alignment.center,
      end: Alignment.centerLeft,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _opacityAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        0.8,
        curve: Curves.ease,
      ),
    ));

    _opacityAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        1.0,
        curve: Curves.ease,
      ),
    ));

    // Only start animation if shouldStartAnimation is true (game is ready)
    if (widget.shouldStartAnimation) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(MentalArithmeticQuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle state changes - only restart animation for new questions, not dialog state changes
    if (oldWidget.currentState != widget.currentState) {
      // Reset animation state for new question
      index = 0;
      _controller.forward(from: 0.0);
    }

    // Handle animation permission changes
    if (oldWidget.shouldStartAnimation != widget.shouldStartAnimation) {
      if (widget.shouldStartAnimation) {
        // Only start animation if it's a genuinely new question (index is 0)
        // Don't restart animation just because dialog was dismissed
        if (index == 0) {
          _controller.forward(from: 0.0);
        }
      } else {
        // Stop animation if dialog appears
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: _animation.value,
              child: Opacity(
                opacity: _opacityAnimationIn.value,
                child: getTextWidget(
                    Theme.of(context).textTheme.titleSmall!,
                    index != 3 ? widget.currentState.questionList[index] : "",
                    TextAlign.center,
                    getPercentSize(getRemainHeight(context: context), 3.5)),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) {
            return Align(
              alignment: _animation1.value,
              child: Opacity(
                opacity: _opacityAnimationOut.value,
                child: getTextWidget(
                    Theme.of(context).textTheme.titleSmall!,
                    index == 0
                        ? ""
                        : widget.currentState.questionList[index - 1],
                    TextAlign.center,
                    getPercentSize(getRemainHeight(context: context), 3.5)),
                // child: Text(
                //   index == 0 ? "" : widget.currentState.questionList[index - 1],
                //   style: TextStyle(
                //     fontSize: 30.0,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

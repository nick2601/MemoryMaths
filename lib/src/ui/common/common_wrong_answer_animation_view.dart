import 'dart:math';
import 'package:flutter/material.dart';

/// A sine wave curve used for smooth shake effect.
class SineCurve extends Curve {
  final double count;

  const SineCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}

/// Widget to animate "wrong answer" by shaking horizontally.
class CommonWrongAnswerAnimationView extends StatefulWidget {
  final int currentScore;
  final int oldScore;
  final Widget child;

  const CommonWrongAnswerAnimationView({
    Key? key,
    required this.currentScore,
    required this.oldScore,
    required this.child,
  }) : super(key: key);

  @override
  State<CommonWrongAnswerAnimationView> createState() =>
      _CommonWrongAnswerAnimationViewState();
}

class _CommonWrongAnswerAnimationViewState
    extends State<CommonWrongAnswerAnimationView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const SineCurve(count: 3)),
    );
  }

  @override
  void didUpdateWidget(CommonWrongAnswerAnimationView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation only when score decreases
    if (oldWidget.currentScore != widget.currentScore &&
        widget.oldScore > widget.currentScore) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      child: widget.child, // child passed outside builder (optimization)
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value * 4, 0), // Shake offset
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
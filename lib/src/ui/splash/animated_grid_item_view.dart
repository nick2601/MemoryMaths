import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedGridItemView extends StatefulWidget {
  final int duration; // delay before animation starts (ms)

  const AnimatedGridItemView({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedGridItemView> createState() => _AnimatedGridItemViewState();
}

class _AnimatedGridItemViewState extends State<AnimatedGridItemView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimationIn;
  late Animation<double> _rotateAnimationOut;

  late final List<String> _randomNumbers;

  @override
  void initState() {
    super.initState();

    // ✅ Ensure consistent randomization per widget lifecycle
    _randomNumbers = List<String>.from(
      ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
    )..shuffle();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // ✅ First half: rotate in (0 → 90°), freeze at 90°
    _rotateAnimationIn = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: pi / 2)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ConstantTween(pi / 2),
        weight: 50,
      ),
    ]).animate(_controller);

    // ✅ Second half: freeze at 90°, rotate out (-90° → 0)
    _rotateAnimationOut = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(pi / 2),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -pi / 2, end: 0.0)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 50,
      ),
    ]).animate(_controller);

    // ✅ Delayed start
    Future.delayed(Duration(milliseconds: widget.duration), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white24.withOpacity(0.25),
      fontFamily: "Poppins",
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    final decoration = BoxDecoration(
      color: Colors.black.withOpacity(0.05),
      border: Border.all(color: Colors.white24, width: 1),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        // First side
        AnimatedBuilder(
          animation: _rotateAnimationIn,
          child: Container(
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(_randomNumbers[0], style: textStyle),
          ),
          builder: (context, child) {
            return Transform(
              transform: Matrix4.rotationY(_rotateAnimationIn.value),
              alignment: Alignment.center,
              child: child,
            );
          },
        ),

        // Second side
        AnimatedBuilder(
          animation: _rotateAnimationOut,
          child: Container(
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(_randomNumbers[1], style: textStyle),
          ),
          builder: (context, child) {
            return Transform(
              transform: Matrix4.rotationY(_rotateAnimationOut.value),
              alignment: Alignment.center,
              child: child,
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
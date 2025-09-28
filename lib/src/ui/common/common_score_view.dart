import 'package:flutter/material.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CommonScoreView extends StatefulWidget {
  final int currentScore;
  final int oldScore;

  const CommonScoreView({
    Key? key,
    required this.currentScore,
    required this.oldScore,
  }) : super(key: key);

  @override
  State<CommonScoreView> createState() => _CommonScoreViewState();
}

class _CommonScoreViewState extends State<CommonScoreView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> inAnimation;
  late final Animation<Offset> outAnimation;
  late final Animation<double> _opacityIn;
  late final Animation<double> _opacityOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    inAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    outAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _opacityIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _opacityOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void didUpdateWidget(CommonScoreView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentScore != widget.currentScore) {
      _controller.forward(from: 0.0);
    }
  }

  Widget _buildScoreText(int score, TextStyle? style, double size) {
    return getTextWidget(
      style ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      score.toString(),
      TextAlign.center,
      size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;
    final double height = getScreenPercentSize(context, 6);
    final double fontSize = getPercentSize(height, 40);

    return Stack(
      alignment: Alignment.center,
      children: [
        SlideTransition(
          position: inAnimation,
          child: FadeTransition(
            opacity: _opacityIn,
            child: _buildScoreText(widget.currentScore, textStyle, fontSize),
          ),
        ),
        SlideTransition(
          position: outAnimation,
          child: FadeTransition(
            opacity: _opacityOut,
            child: _buildScoreText(widget.oldScore, textStyle, fontSize),
          ),
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
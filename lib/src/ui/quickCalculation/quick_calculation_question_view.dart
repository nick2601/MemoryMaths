import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/quick_calculation.dart';

import '../../utility/Constants.dart';

class QuickCalculationQuestionView extends StatefulWidget {
  final QuickCalculation currentState;
  final QuickCalculation? nextCurrentState;
  final QuickCalculation? previousCurrentState;

  const QuickCalculationQuestionView({
    Key? key,
    required this.currentState,
    required this.nextCurrentState,
    required this.previousCurrentState,
  }) : super(key: key);

  @override
  State<QuickCalculationQuestionView> createState() =>
      _QuickCalculationQuestionViewState();
}

class _QuickCalculationQuestionViewState
    extends State<QuickCalculationQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _fadeOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
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
    final remainHeight = getRemainHeight(context: context);

    return Stack(
      alignment: Alignment.center,
      children: [
        // 🔹 Previous Question (fades out, smaller & grey)
        if (widget.previousCurrentState != null)
          Align(
            alignment: Alignment.centerLeft,
            child: FadeTransition(
              opacity: _fadeOut,
              child: getTextWidget(
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                widget.previousCurrentState!.question,
                TextAlign.center,
                getPercentSize(remainHeight, 3),
              ),
            ),
          ),

        // 🔹 Current Question (main focus, fades in)
        FadeTransition(
          opacity: _fadeIn,
          child: getTextWidget(
            Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            widget.currentState.question,
            TextAlign.center,
            getPercentSize(remainHeight, 4),
          ),
        ),

        // 🔹 Next Question (preview, faded grey, smaller)
        if (widget.nextCurrentState != null)
          Align(
            alignment: Alignment.bottomRight,
            child: FadeTransition(
              opacity: _fadeIn,
              child: getTextWidget(
                Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
                widget.nextCurrentState!.question,
                TextAlign.center,
                getPercentSize(remainHeight, 2.5),
              ),
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
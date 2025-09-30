import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../app/game_provider.dart';

class CommonLinearPercentIndicator<T extends GameProvider>
    extends StatelessWidget {
  final double lineHeight;
  final LinearGradient linearGradient;
  final Color backgroundColor;

  CommonLinearPercentIndicator({
    this.lineHeight = 5.0,
    required this.linearGradient,
    this.backgroundColor = Colors.black12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: StepProgressIndicator(
    //     totalSteps: model.totalTime,
    //     currentStep: model.currentTime,
    //     size: lineHeight,
    //     padding: 0,
    //     unselectedColor: backgroundColor,
    //     roundedEdges: Radius.circular(10),
    //     selectedGradientColor: linearGradient,
    //   ),
    //
    // );

    return Container(
      child: LinearPercentIndicator(
        padding: EdgeInsets.zero,
        lineHeight: lineHeight,
        percent: 1,
        // percent:model.currentTime/model.totalTime,
        animateFromLastPercent: true,
        animation: true,
        linearGradient: linearGradient,
        backgroundColor: backgroundColor,
      ),
    );

    // print("model====${model.animation.value}");
    // return AnimatedBuilder(
    //   animation: model.animation,
    //   builder: (context, child) {
    //     double v=model.animation.value;
    //     // double v=0.07695600000000002;
    //     double vtotal=1;
    //     double settotal=100;
    //     int percentage = ((settotal*v)/vtotal).toInt();
    //
    //     print("model111====${model.animation.value}===$percentage");
    //
    //     return Container(
    //       height: lineHeight,
    //       color: backgroundColor,
    //       child: Transform(
    //         transform: Matrix4.diagonal3Values(model.animation.value, 1.0, 1.0),
    //         child: Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             gradient: linearGradient,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

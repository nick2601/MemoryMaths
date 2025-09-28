import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/app/time_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../core/app_constant.dart';
import '../app/game_provider.dart';

class CommonLinearPercentIndicator extends ConsumerWidget {
  final double lineHeight;
  final LinearGradient linearGradient;
  final Color backgroundColor;
  final GameCategoryType gameCategoryType;

  const CommonLinearPercentIndicator({
    this.lineHeight = 5.0,
    required this.linearGradient,
    this.backgroundColor = Colors.black12,
    required this.gameCategoryType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current game state from TimeNotifier
    final state = ref.watch(timeProvider(gameCategoryType.index));

    // Avoid division by zero
    final percent = (state.totalTime > 0)
        ? state.currentTime / state.totalTime
        : 0.0;

    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      lineHeight: lineHeight,
      percent: percent.clamp(0.0, 1.0),
      animateFromLastPercent: true,
      animation: true,
      linearGradient: linearGradient,
      backgroundColor: backgroundColor,
    );
  }
}

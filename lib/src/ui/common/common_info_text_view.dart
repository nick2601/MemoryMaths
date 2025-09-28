import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import '../app/game_provider.dart';
import '../resizer/widget_utils.dart';

class CommonInfoTextView extends ConsumerWidget {
  final GameCategoryType gameCategoryType;
  final Color color;
  final String folder;

  const CommonInfoTextView({
    required this.gameCategoryType,
    required this.color,
    required this.folder,
    Key? key,
  }) : super(key: key);

  Color increaseColorLightness(Color color, double increment) {
    final hslColor = HSLColor.fromColor(color);
    final newValue = min(max(hslColor.lightness + increment, 0.0), 1.0);
    return hslColor.withLightness(newValue).toColor();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(gameProvider(gameCategoryType).notifier);

    return Container(
      margin: EdgeInsets.only(right: getScreenPercentSize(context, 1)),
      child: getDefaultIconWidget(
        context,
        icon: AppAssets.infoIcon,
        folder: folder,
        function: () => notifier.showInfoDialog(),
      ),
    );
  }
}
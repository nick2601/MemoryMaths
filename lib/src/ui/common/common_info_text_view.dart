import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:provider/provider.dart';
import '../app/game_provider.dart';

class CommonInfoTextView<T extends GameProvider> extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Color color;
  final String folder;

  Color increaseColorLightness(Color color, double increment) {
    var hslColor = HSLColor.fromColor(color);
    var newValue = min(max(hslColor.lightness + increment, 0.0), 1.0);
    return hslColor.withLightness(newValue).toColor();
  }

  const CommonInfoTextView({
    required this.gameCategoryType,
    required this.color,
    required this.folder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: getScreenPercentSize(context, 1)),

      child: Consumer<T>(builder: (context, provider, child) {
        return getDefaultIconWidget(context,
            icon: AppAssets.infoIcon, folder: folder, function: () {
          provider.showInfoDialog();
        });
      }),
      // child: getDefaultIconWidget(context,
      //     folder: folder,
      //     icon: AppAssets.infoIcon,
      //     function: () {
      //       context.read<T>().showInfoDialog();
      //     }),
      // child: SvgPicture.asset(
      //
      //   getFolderName(context, folder)+ AppAssets.infoIcon,height: getScreenPercentSize(context, 2.5),width: getScreenPercentSize(context, 2.5),),
    );
  }
}

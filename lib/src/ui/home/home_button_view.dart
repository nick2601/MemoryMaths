import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/dashboard.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../dashboard/dashboard_provider.dart';

class HomeButtonView extends ConsumerWidget {
  final VoidCallback onTab;
  final String title;
  final String icon;
  final int score;
  final GameCategoryType? gameCategoryType;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;
  final Tuple2<Dashboard, double> tuple2;

  const HomeButtonView({
    Key? key,
    required this.title,
    required this.tuple2,
    required this.icon,
    required this.score,
    required this.colorTuple,
    required this.onTab,
    required this.opacity,
    this.gameCategoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider); // 🎨 Watch theme
    final dashboard = ref.watch(dashboardProvider);

    double height = getScreenPercentSize(context, 30);
    double iconHeight = getPercentSize(height, 24);
    double remainHeight = height - (getPercentSize(height, 17) * 2);

    return CommonTabAnimationView(
      onTab: onTab,
      isDelayed: true,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: getDefaultDecoration(
              bgColor: tuple2.item1.bgColor,
              radius: getPercentSize(height, 8),
            ),
            margin: EdgeInsets.only(top: getPercentSize(height, 12)),
            padding: EdgeInsets.only(
              top: getPercentSize(height, 20),
              bottom: getPercentSize(height, 6),
            ),
            child: Column(
              children: [
                /// Title
                getTextWidget(
                  Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  title,
                  TextAlign.center,
                  getPercentSize(remainHeight, 11),
                ),

                /// Score section
                Opacity(
                  opacity: (gameCategoryType == GameCategoryType.DUAL_GAME)
                      ? 0
                      : 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(getPercentSize(remainHeight, 95)),
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: getPercentSize(remainHeight, 12),
                      horizontal: getWidthPercentSize(context, 13),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: getPercentSize(remainHeight, 4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            AppAssets.icTrophy,
                            width: getPercentSize(height, 8),
                            height: getPercentSize(height, 8),
                          ),
                        ),
                        SizedBox(width: getWidthPercentSize(context, 1.5)),

                        /// ✅ Watch score from dashboardProvider
                        AutoSizeText(
                          score.toString(),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: getPercentSize(remainHeight, 10),
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                        // If you want to use provider value directly:
                        // AutoSizeText(
                        //   dashboard.overallScore.toString(),
                        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        //         fontSize: getPercentSize(remainHeight, 10),
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //   maxLines: 2,
                        // ),
                      ],
                    ),
                  ),
                ),

                /// Play button
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: getDefaultDecoration(
                      bgColor: tuple2.item1.primaryColor,
                      radius: getPercentSize(height, 4),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: getWidthPercentSize(context, 5),
                    ),
                    child: Center(
                      child: getTextWidget(
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        'Play',
                        TextAlign.center,
                        getPercentSize(remainHeight, 9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Game icon
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              icon,
              height: iconHeight,
            ),
          ),
        ],
      ),
    );
  }
}
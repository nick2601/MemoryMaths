import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';

class DashboardButtonView extends StatelessWidget {
  final Function onTab;
  final Animation<Offset> position;
  final Dashboard dashboard;
  final double margin;

  const DashboardButtonView({
    Key? key,
    required this.position,
    required this.onTab,
    required this.dashboard,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = FetchPixels.getPixelWidth( );
    double height = getWidthPercentSize(context, 42);
    double circle = getPercentSize(height, 42);
    double iconSize = getPercentSize(circle, 62);

    print(
        "dashboard-----${AppAssets.assetFolderPath + dashboard.folder + AppAssets.homeIcon}");
    // print(
    //     "themeProvider---${themeProvider.folderName}---${themeMode}");
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return CommonTabAnimationView(
          onTab: onTab,
          isDelayed: true,
          child: SlideTransition(
            position: position,
            child: Container(
              height: height,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      '${getFolderName(context, dashboard.folder)}${AppAssets.homeCellBg}',
                      // '${getCurrentThemePath(value.themeMode)}${dashboard.bgIcon}',
                      height: height,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getWidthPercentSize(context, 6),
                        ),
                        Container(
                          height: circle,
                          width: circle,
                          decoration: getDefaultDecoration(
                              bgColor: Colors.white,
                              radius: getPercentSize(circle, 24)),
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.assetFolderPath +
                                  dashboard.folder +
                                  AppAssets.homeIcon,
                              width: iconSize,
                              height: iconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: getWidthPercentSize(context, 4.5)),
                        getTextWidget(
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            dashboard.title,
                            TextAlign.center,
                            getPercentSize(height, 12))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

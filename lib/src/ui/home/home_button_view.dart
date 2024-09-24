import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/common_tab_animation_view.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/dashboard.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../dashboard/dashboard_provider.dart';

class HomeButtonView extends StatelessWidget {
  final Function onTab;
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
  Widget build(BuildContext context) {
    // double height = getWidthPercentSize(context, 42);
    // double subHeight = getPercentSize(height, 50);
    // double circle = getPercentSize(subHeight, 70);
    // double iconSize = getPercentSize(circle, 50);
    double height = getScreenPercentSize(context, 30);
    double iconHeight = getPercentSize(height, 24);
    double remainHeight = height - (getPercentSize(height, 17) * 2);

    return CommonTabAnimationView(
      onTab: onTab,
      isDelayed: true,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: getDefaultDecoration(
                    bgColor: tuple2.item1.bgColor,
                    radius: getPercentSize(height, 8)),
                margin: EdgeInsets.only(top: getPercentSize(height, 12)),
                padding: EdgeInsets.only(
                    top: getPercentSize(height, 20),
                    bottom: getPercentSize(height, 6)),
                child: Column(
                  children: [
                    getTextWidget(
                        Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        title,
                        TextAlign.center,
                        getPercentSize(remainHeight, 11)),
                    Opacity(
                      opacity: (gameCategoryType == GameCategoryType.DUAL_GAME)
                          ? 0
                          : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                getPercentSize(remainHeight, 95))),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                            ]),
                        margin: EdgeInsets.symmetric(
                            vertical: getPercentSize(remainHeight, 12),
                            horizontal: getWidthPercentSize(context, 13)),
                        padding: EdgeInsets.symmetric(
                            vertical: getPercentSize(remainHeight, 4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.icTrophy,
                                width: getPercentSize(height, 8),
                                height: getPercentSize(height, 8),
                              ),
                            ),
                            SizedBox(
                              width: getWidthPercentSize(context, 1.5),
                            ),
                            Consumer<DashboardProvider>(
                                builder: (context, model, child) =>
                                    AutoSizeText(
                                      score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: getPercentSize(
                                                  remainHeight, 10),
                                              fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                    )
                                // getTextWidget(
                                //     Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                                //     model.overallScore.toString(),
                                //     TextAlign.center,
                                //     getPercentSize(
                                //         subHeight, 18)),
                                ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      decoration: getDefaultDecoration(
                          bgColor: tuple2.item1.primaryColor,
                          radius: getPercentSize(height, 4)),
                      child: Center(
                        child: getTextWidget(
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            'Play',
                            TextAlign.center,
                            getPercentSize(remainHeight, 9)),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: getWidthPercentSize(context, 5),
                      ),
                    ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  icon,
                  height: iconHeight,
                ),
              ),
            ],
          );
          // return Container(
          //   margin: EdgeInsets.symmetric(
          //       vertical: getScreenPercentSize(context, 1)),
          //   child: Container(
          //       alignment: Alignment.center,
          //       height: height,
          //       // decoration: getDefaultDecoration(
          //       //     radius: radius, bgColor: tuple2.item1.bgColor),
          //       child: Stack(
          //         children: [
          //           Container(
          //             height: height,
          //             width: double.infinity,
          //             child: SvgPicture.asset(
          //               '${getFolderName(context,tuple2.item1.folder)}${AppAssets.subCellBg}',
          //               // '${getCurrentThemePath(value.themeMode)}${tuple2.item1.subBgIcon}',
          //               height: height,
          //               width: double.infinity,
          //               fit: BoxFit.fill,
          //             ),
          //           ),
          //
          //           Padding(
          //             padding: EdgeInsets.symmetric(
          //                 horizontal: getWidthPercentSize(context, 5),
          //                 vertical: getPercentSize(height, 10)),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Container(
          //                       height: circle,
          //                       width: circle,
          //                       decoration: getDefaultDecoration(
          //                           bgColor: Colors.white,
          //                           radius: getPercentSize(circle, 24)),
          //                       child: Center(
          //                         child: SvgPicture.asset(
          //                           icon,
          //                           width: iconSize,
          //                           height: iconSize,
          //                         ),
          //                       ),
          //                     ),
          //
          //                     // getShadowCircle(
          //                     //     widget: Center(
          //                     //       child: SvgPicture.asset(
          //                     //         icon,
          //                     //         width: iconSize,
          //                     //         height: iconSize,
          //                     //       ),
          //                     //     ),
          //                     //     size: circle,
          //                     //     color:
          //                     //     Theme.of(context).scaffoldBackgroundColor),
          //                     SizedBox(
          //                         width: getWidthPercentSize(context, 3.5)),
          //                     getTextWidget(
          //                         Theme.of(context)
          //                             .textTheme
          //                             .subtitle2!
          //                             .copyWith(
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.bold),
          //                         title,
          //                         TextAlign.center,
          //                         getPercentSize(subHeight, 22))
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: getPercentSize(height, 10),
          //                 ),
          //                 Row(
          //                   children: [
          //
          //
          //                     Expanded(
          //                       child: Visibility(
          //                         visible: (gameCategoryType != GameCategoryType.DUAL_GAME),
          //                         child: Row(
          //                           children: [
          //                             getTextWidget(
          //                                 Theme.of(context)
          //                                     .textTheme
          //                                     .bodyText2!
          //                                     .copyWith(
          //                                     color: Colors.black,
          //                                     fontWeight: FontWeight.w600),
          //                                 'Score',
          //                                 TextAlign.center,
          //                                 getPercentSize(subHeight, 16)),
          //
          //                             SizedBox(
          //                               width: getWidthPercentSize(context, 2.5),
          //                             ),
          //
          //                             Container(
          //
          //
          //                               child: Stack(
          //                                 children: [
          //                                   Positioned.fill(child:   SvgPicture.asset(
          //                                     AppAssets.assetFolderPath+tuple2.item1.folder + AppAssets.scoreBg,
          //                                     height: double.infinity,
          //                                   ),),
          //                                   Padding(
          //                                     padding:  EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2.1),
          //                                         vertical: getPercentSize(height, 5)),                                     child: Row(
          //                                     mainAxisAlignment:
          //                                     MainAxisAlignment.center,
          //                                     crossAxisAlignment:
          //                                     CrossAxisAlignment.center,
          //                                     children: [
          //                                       Center(
          //                                         child: SvgPicture.asset(
          //                                           AppAssets.icTrophy,
          //                                           width:
          //                                           getPercentSize(height, 10),
          //                                           height:
          //                                           getPercentSize(height, 10),
          //                                         ),
          //                                       ),
          //                                       SizedBox(
          //                                         width: getWidthPercentSize(context, 1.5),
          //                                       ),
          //                                       Consumer<DashboardProvider>(
          //                                           builder: (context, model, child) =>
          //                                               AutoSizeText(
          //                                                 score.toString(),
          //                                                 style:  Theme.of(context).textTheme.subtitle1!.copyWith(
          //                                                     color:
          //                                                     Colors.white,
          //                                                     fontSize: getPercentSize(subHeight, 16)),
          //                                                 maxLines: 2,
          //                                               )
          //                                         // getTextWidget(
          //                                         //     Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
          //                                         //     model.overallScore.toString(),
          //                                         //     TextAlign.center,
          //                                         //     getPercentSize(
          //                                         //         subHeight, 18)),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   ),
          //                                 ],
          //                               ),
          //                               // child: Row(
          //                               //   mainAxisAlignment: MainAxisAlignment.center,
          //                               //   crossAxisAlignment: CrossAxisAlignment.center,
          //                               //   children: [
          //                               //     Center(
          //                               //       child: SvgPicture.asset(
          //                               //         AppAssets.icTrophy,
          //                               //         width: getPercentSize(subHeight, 25),
          //                               //         height: getPercentSize(subHeight, 25),
          //                               //       ),
          //                               //     ),
          //                               //     SizedBox(width: getWidthPercentSize(context,1.5),),
          //                               //     Consumer<DashboardProvider>(
          //                               //       builder: (context, model, child) =>   getTextWidget(
          //                               //           Theme.of(context).textTheme.subtitle1!
          //                               //               .copyWith(color: Colors.white),model.overallScore.toString(),
          //                               //           TextAlign.center,getPercentSize(subHeight, 18)),
          //                               //     ),
          //                               //   ],
          //                               // ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       flex: 1,
          //                     ),
          //
          //                     SvgPicture.asset(
          //                       AppAssets.assetFolderPath+   tuple2.item1.folder + AppAssets.nextIcon,
          //                       width: getPercentSize(subHeight, 56),
          //                       height: getPercentSize(subHeight, 56),
          //                     ),
          //
          //
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //           // Align(
          //           //   alignment: Alignment.topRight,
          //           //   child: Transform(
          //           //     transform: Matrix4.identity().scaled(5.0)
          //           //       ..translate(-17.0, -15.0),
          //           //     child: SvgPicture.asset(
          //           //       icon,
          //           //       color: Colors.black.withOpacity(opacity),
          //           //     ),
          //           //   ),
          //           // ),
          //         ],
          //       )),
          // );
        },
      ),
    );
  }
}

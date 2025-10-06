import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/home/home_button_view.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../utility/global_constants.dart';

class HomeView extends StatefulWidget {
  final Tuple2<Dashboard, double> tuple2;

  HomeView({
    Key? key,
    required this.tuple2,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation bgColorTween;
  late Animation<double> elevationTween;
  late Animation<double> subtitleVisibilityTween;
  late Animation<double> radiusTween;
  late Animation<double> heightTween;
  late Animation<TextStyle> textStyleTween;
  late Animation<double> outlineImageBottomPositionTween;
  late Animation<double> fillImageBottomPositionTween;
  late Animation<double> outlineImageRightPositionTween;
  late Animation<double> fillImageRightPositionTween;
  late bool isGamePageOpen;
  Tuple2<Dashboard, double>? tuple2;

  @override
  void initState() {
    super.initState();
    tuple2 = widget.tuple2;
    isGamePageOpen = false;

    // Initialize animations with fixed values (no Theme.of(context) here)
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    bgColorTween =
        ColorTween(begin: Colors.black, end: Color(0xFF212121)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    elevationTween = Tween(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    subtitleVisibilityTween = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );
    radiusTween = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    heightTween = Tween(begin: 183.0 + tuple2!.item2, end: 56.0 + tuple2!.item2)
        .animate(animationController);
    textStyleTween = TextStyleTween(
        begin: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          fontFamily: DyslexicTheme.dyslexicFont,
        ),
        end: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: DyslexicTheme.dyslexicFont,
        )).animate(animationController);

    outlineImageBottomPositionTween =
        Tween(begin: 56.0, end: 56.0).animate(animationController);
    outlineImageRightPositionTween =
        Tween(begin: -40.0, end: -150.0).animate(animationController);
    fillImageBottomPositionTween =
        Tween(begin: 54.0, end: 136.0).animate(animationController);
    fillImageRightPositionTween =
        Tween(begin: -54.0, end: -240.0).animate(animationController);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double margin = getHorizontalSpace(context);

    setStatusBarColor(theme.scaffoldBackgroundColor);

    int _crossAxisCount = 2;
    double height = getScreenPercentSize(context, 30);

    double _crossAxisSpacing = getPercentSize(height, 10);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    return Scaffold(
      appBar: getNoneAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getScreenPercentSize(context, 2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getDefaultIconWidget(context,
                          icon: AppAssets.backIcon,
                          folder: tuple2!.item1.folder, function: () {
                        if (kIsWeb) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pop();
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      }),
                      Expanded(
                        child: getScoreWidget(context, isCenter: true),
                        flex: 1,
                      ),
                      getSettingWidget(context, function: () {
                        setState(() {
                          if (theme.brightness == Brightness.dark) {
                            tuple2!.item1.bgColor = Color(0xFF383838);
                          } else {
                            tuple2!.item1.bgColor = theme.colorScheme.surface;
                          }
                        });
                      })
                    ],
                  ),
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        padding: EdgeInsets.only(bottom: getHorizontalSpace(context)),
                        children: [
                          SizedBox(
                            height: getScreenPercentSize(context, 4),
                          ),
                          AnimatedBuilder(
                            animation: heightTween,
                            builder: (context, child) {
                              return Container(
                                height: heightTween.value,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: heightTween.value,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            theme.colorScheme.primary.withValues(alpha: 0.8),
                                            theme.colorScheme.primary,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(radiusTween.value),
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: outlineImageRightPositionTween,
                                      builder: (context, child) {
                                        return Positioned(
                                          bottom: outlineImageBottomPositionTween.value,
                                          right: outlineImageRightPositionTween.value,
                                          child: SvgPicture.asset(
                                            tuple2!.item1.outlineIcon,
                                            height: getPercentSize(heightTween.value, 35),
                                            colorFilter: ColorFilter.mode(
                                              theme.colorScheme.onPrimary.withValues(alpha: 0.1),
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    AnimatedBuilder(
                                      animation: fillImageRightPositionTween,
                                      builder: (context, child) {
                                        return Positioned(
                                          bottom: fillImageBottomPositionTween.value,
                                          right: fillImageRightPositionTween.value,
                                          child: SvgPicture.asset(
                                            tuple2!.item1.outlineIcon,
                                            height: getPercentSize(heightTween.value, 25),
                                            colorFilter: ColorFilter.mode(
                                              theme.colorScheme.onPrimary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getWidthPercentSize(context, 5),
                                        vertical: getScreenPercentSize(context, 3),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          AnimatedBuilder(
                                            animation: textStyleTween,
                                            builder: (context, child) {
                                              return Text(
                                                tuple2!.item1.title,
                                                style: textStyleTween.value.copyWith(
                                                  color: theme.colorScheme.onPrimary,
                                                  fontFamily: DyslexicTheme.dyslexicFont,
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: getScreenPercentSize(context, 1)),
                                          AnimatedBuilder(
                                            animation: subtitleVisibilityTween,
                                            builder: (context, child) {
                                              return Opacity(
                                                opacity: subtitleVisibilityTween.value,
                                                child: Text(
                                                  tuple2!.item1.subtitle,
                                                  style: TextStyle(
                                                    fontSize: getScreenPercentSize(context, 2),
                                                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                                                    fontFamily: DyslexicTheme.dyslexicFont,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: getScreenPercentSize(context, 3)),
                          Consumer<DashboardProvider>(
                            builder: (context, provider, child) {
                              final games = provider.getGameByPuzzleType(tuple2!.item1.puzzleType);

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _crossAxisCount,
                                  childAspectRatio: _aspectRatio,
                                  crossAxisSpacing: _crossAxisSpacing,
                                  mainAxisSpacing: _crossAxisSpacing,
                                ),
                                itemCount: games.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final e = games[index];
                                  return HomeButtonView(
                                    title: e.name,
                                    icon: e.icon,
                                    tuple2: tuple2!,
                                    score: e.scoreboard.highestScore,
                                    colorTuple: tuple2!.item1.colorTuple,
                                    opacity: tuple2!.item1.opacity,
                                    gameCategoryType: e.gameCategoryType,
                                    onTab: () {
                                      if (e.gameCategoryType == GameCategoryType.DUAL_GAME) {
                                        // If you have a duel dialog, plug it here; otherwise navigate
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          KeyUtil.level,
                                          ModalRoute.withName(KeyUtil.home),
                                          arguments: Tuple2(e, tuple2!.item1),
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      } else {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          KeyUtil.level,
                                          ModalRoute.withName(KeyUtil.home),
                                          arguments: Tuple2(e, tuple2!.item1),
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

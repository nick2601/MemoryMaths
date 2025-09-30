import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/home/home_button_view.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../data/models/game_category.dart';
import '../../utility/Constants.dart';
import '../app/coin_provider.dart';
import '../app/theme_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class HomeView extends ConsumerStatefulWidget {
  final Tuple2<Dashboard, double> tuple2;

  const HomeView({
    Key? key,
    required this.tuple2,
  }) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late bool isGamePageOpen;
  Tuple2<Dashboard, double>? tuple2;

  @override
  void initState() {
    super.initState();
    tuple2 = widget.tuple2;
    isGamePageOpen = false;

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final coins = ref.watch(coinProvider);

    final dashboardNotifier = ref.read(dashboardProvider.notifier);
    final games =
    dashboardNotifier.getGameByPuzzleType(tuple2!.item1.puzzleType);

    double margin = getHorizontalSpace(context);
    setStatusBarColor(Theme.of(context).scaffoldBackgroundColor);

    int crossAxisCount = 2;
    double height = getScreenPercentSize(context, 30);
    double crossAxisSpacing = getPercentSize(height, 10);
    var widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double aspectRatio = widthItem / height;

    return Scaffold(
      appBar: getNoneAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getScreenPercentSize(context, 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getDefaultIconWidget(
                        context,
                        icon: AppAssets.backIcon,
                        folder: tuple2!.item1.folder,
                        function: () {
                          if (kIsWeb) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pop();
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      const Spacer(),
                      getSettingWidget(context, function: () {
                        setState(() {
                          tuple2 = Tuple2(
                            tuple2!.item1.copyWith(
                              bgColor: themeMode == ThemeMode.dark
                                  ? "#383838".toColor()
                                  : KeyUtil.bgColorList[tuple2!.item1.position],
                            ),
                            tuple2!.item2,
                          );
                        });
                      }),
                    ],
                  ),
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        padding: EdgeInsets.only(
                          bottom: getHorizontalSpace(context),
                        ),
                        children: [
                          getHeaderWidget(
                            context,
                            tuple2!.item1.title,
                            tuple2!.item1.subtitle,
                          ),
                          SizedBox(height: getVerticalSpace(context)),
                          GridView.count(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: aspectRatio,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: crossAxisSpacing,
                            mainAxisSpacing: crossAxisSpacing,
                            padding: EdgeInsets.only(
                              top: getScreenPercentSize(context, 4),
                            ),
                            children: games.map((e) {
                              return HomeButtonView(
                                title: e.name,
                                icon: e.icon,
                                tuple2: tuple2!,
                                score: e.scoreboard.highestScore,
                                colorTuple: tuple2!.item1.colorTuple,
                                opacity: tuple2!.item1.opacity,
                                gameCategoryType: e.gameCategoryType,
                                onTab: () {
                                  if (e.gameCategoryType ==
                                      GameCategoryType.DUAL_GAME) {
                                    showDuelDialog(themeMode, context);
                                  } else {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      KeyUtil.level,
                                      ModalRoute.withName(KeyUtil.home),
                                      arguments: Tuple2<GameCategory, Dashboard>(
                                          e, tuple2!.item1),
                                    );
                                  }
                                },
                              );
                            }).toList(),
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

  Widget getSettingWidget(BuildContext context,
      {required VoidCallback function}) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: function,
    );
  }

  Widget getHeaderWidget(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  void showDuelDialog(ThemeMode themeMode, BuildContext context) {
    double margin = getScreenPercentSize(context, 1.5);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: margin),
                    getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                      "Select Difficulty",
                      TextAlign.center,
                      getScreenPercentSize(context, 2),
                    ),
                    Divider(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      thickness: 1,
                    ),
                    getCell('Easy', true, easyQuiz, themeMode),
                    getCell('Medium', false, mediumQuiz, themeMode),
                    getCell('Hard', false, hardQuiz, themeMode),
                    SizedBox(height: margin),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getCell(String s, bool isSelect, int type, ThemeMode themeMode) {
    double cellHeight = getScreenPercentSize(context, 10);
    return InkWell(
      child: Container(
        width: getWidthPercentSize(context, 60),
        height: cellHeight,
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            SizedBox(
              height: cellHeight,
              width: double.infinity,
              child: SvgPicture.asset(
                // ✅ normalize folder + asset path
                '${getFolderName(context, tuple2!.item1.folder)}/${AppAssets.subCellBg}'
                    .replaceAll('//', '/'),
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: getTextWidget(
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                s,
                TextAlign.center,
                getPercentSize(cellHeight, 25),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        GradientModel model = GradientModel()
          ..primaryColor = tuple2!.item1.primaryColor
          ..gridColor = tuple2!.item1.gridColor
          ..cellColor = themeMode == ThemeMode.dark
              ? "#383838".toColor()
              : tuple2!.item1.bgColor
          ..folderName = tuple2!.item1.folder
          ..bgColor = tuple2!.item1.bgColor
          ..backgroundColor = tuple2!.item1.backgroundColor;

        Navigator.pushNamed(
          context,
          KeyUtil.dualGame,
          arguments: Tuple2(model, type),
        ).then((value) {
          isGamePageOpen = false;
        });
      },
    );
  }
}
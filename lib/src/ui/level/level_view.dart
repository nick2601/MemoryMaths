import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../data/models/game_category.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class LevelView extends ConsumerStatefulWidget {
  final Tuple2<GameCategory, Dashboard> tuple2;

  const LevelView({
    Key? key,
    required this.tuple2,
  }) : super(key: key);

  @override
  ConsumerState<LevelView> createState() => _LevelViewState();
}

class _LevelViewState extends ConsumerState<LevelView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isGamePageOpen = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<bool> _requestPop() async {
    animationController.dispose();
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
    return false;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tuple2 = widget.tuple2;

    // ✅ Watch theme provider (Riverpod)
    final themeNotifier = ref.watch(themeProvider);

    final margin = getHorizontalSpace(context);
    const crossAxisCount = 3;
    final height = getWidthPercentSize(context, 100) / 4;

    final crossAxisSpacing = getScreenPercentSize(context, 3.5);
    final widthItem = (getWidthPercentSize(context, 100) -
        ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    final aspectRatio = widthItem / height;

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getScreenPercentSize(context, 2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getDefaultIconWidget(
                    context,
                    icon: AppAssets.backIcon,
                    folder: tuple2.item2.folder,
                    function: _requestPop,
                  ),
                  SizedBox(width: getWidthPercentSize(context, 1.5)),
                  Expanded(
                    child: getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      tuple2.item1.name,
                      TextAlign.center,
                      getScreenPercentSize(context, 2.5),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: Container(
                  decoration: getDefaultDecoration(
                    bgColor: tuple2.item2.bgColor,
                    radius: getCommonRadius(context),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: getScreenPercentSize(context, 3),
                    horizontal: getWidthPercentSize(context, 3),
                  ),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    shrinkWrap: true,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: crossAxisSpacing,
                    padding: EdgeInsets.symmetric(
                      vertical: getScreenPercentSize(context, 2.3),
                      horizontal: margin * 1.3,
                    ),
                    children: List.generate(defaultLevelSize, (index) {
                      final animation = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval(
                            (1 / defaultLevelSize) * index,
                            1.0,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      );
                      animationController.forward();

                      return buildAnimatedItem(
                        context,
                        index,
                        animation,
                        InkWell(
                          onTap: () {
                            final model = GradientModel()
                              ..primaryColor = tuple2.item2.primaryColor
                              ..gridColor = tuple2.item2.gridColor
                              ..cellColor =
                              getBgColor(ref.read(themeProvider.notifier), tuple2.item2.bgColor)
                              ..folderName = tuple2.item2.folder
                              ..bgColor = tuple2.item2.bgColor
                              ..backgroundColor =
                                  tuple2.item2.backgroundColor;

                            Navigator.pushNamed(
                              context,
                              tuple2.item1.routePath,
                              arguments: Tuple2(model, index + 1),
                            ).then((_) {
                              isGamePageOpen = false;
                            });
                          },
                          child: Container(
                            height: height,
                            decoration: getDefaultDecoration(
                              radius: getPercentSize(height, 20),
                              borderColor: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color,
                              bgColor: Theme.of(context)
                                  .scaffoldBackgroundColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OriginalSurfer",
                                  ),
                                  '${index + 1}',
                                  TextAlign.center,
                                  getPercentSize(height, 28),
                                ),
                                SizedBox(
                                    height: getPercentSize(height, 5)),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        getPercentSize(height, 95)),
                                    color: tuple2.item2.backgroundColor,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                    getWidthPercentSize(context, 4),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: getPercentSize(height, 4),
                                  ),
                                  child: Center(
                                    child: getTextWidget(
                                      Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      'Level',
                                      TextAlign.center,
                                      getPercentSize(height, 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
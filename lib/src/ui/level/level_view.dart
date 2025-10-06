import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../data/models/game_category.dart';
import '../../utility/global_constants.dart';
import '../app/theme_provider.dart';

class LevelView extends StatefulWidget {
  final Tuple2<GameCategory, Dashboard> tuple2;

  LevelView({
    Key? key,
    required this.tuple2,
  }) : super(key: key);

  @override
  State<LevelView> createState() => _LevelViewState();
}

class _LevelViewState extends State<LevelView> with TickerProviderStateMixin {
  late bool isGamePageOpen;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    isGamePageOpen = false;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    setState(() {});
  }

  Future<bool> _requestPop() {
    if (animationController != null) {
      animationController!.dispose();
    }

    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
    return new Future.value(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double margin = getHorizontalSpace(context);
    final theme = Theme.of(context);

    int _crossAxisCount = 3;
    double height = getWidthPercentSize(context, 100) / 4;

    double _crossAxisSpacing = getScreenPercentSize(context, 3.5);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getScreenPercentSize(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getDefaultIconWidget(context,
                        icon: AppAssets.backIcon,
                        folder: widget.tuple2.item2.folder,
                        function: _requestPop),
                    SizedBox(
                      width: getWidthPercentSize(context, 1.5),
                    ),
                    Expanded(
                      child: getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                          widget.tuple2.item1.name,
                          TextAlign.center,
                          getScreenPercentSize(context, 2.5)),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: Container(
                    decoration: getDefaultDecoration(
                        bgColor: widget.tuple2.item2.bgColor,
                        radius: getCommonRadius(context)),
                    margin: EdgeInsets.symmetric(
                        vertical: getScreenPercentSize(context, 3),
                        horizontal: getWidthPercentSize(context, 3)),
                    child: GridView.count(
                      crossAxisCount: _crossAxisCount,
                      childAspectRatio: _aspectRatio,
                      shrinkWrap: true,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _crossAxisSpacing,
                      primary: false,
                      padding: EdgeInsets.symmetric(
                          vertical: getScreenPercentSize(context, 2.3),
                          horizontal: (margin * 1.3)),
                      children: List.generate(defaultLevelSize, (index) {
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval(
                                (1 / defaultLevelSize) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        animationController!.forward();
                        return buildAnimatedItem(
                            context,
                            index,
                            animation,
                            InkWell(
                              child: Container(
                                height: height,
                                decoration: getDefaultDecoration(
                                    radius: getPercentSize(height, 20),
                                    borderColor: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color,
                                    bgColor:
                                        Theme.of(context).scaffoldBackgroundColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    getTextWidget(
                                        Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "OriginalSurfer"),
                                        '${(index + 1)}',
                                        TextAlign.center,
                                        getPercentSize(height, 28)),
                                    SizedBox(
                                      height: getPercentSize(height, 5),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                getPercentSize(height, 95))),
                                        color: widget
                                            .tuple2.item2.backgroundColor,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              getWidthPercentSize(context, 4)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: getPercentSize(height, 4)),
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
                                            getPercentSize(height, 15)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                GradientModel model = new GradientModel();
                                model.primaryColor =
                                    widget.tuple2.item2.primaryColor;
                                model.gridColor = widget.tuple2.item2.gridColor;

                                model.cellColor = getBgColor(
                                    themeProvider, widget.tuple2.item2.bgColor);
                                model.folderName = widget.tuple2.item2.folder;
                                model.bgColor = widget.tuple2.item2.bgColor;
                                model.backgroundColor =
                                    widget.tuple2.item2.backgroundColor;

                                Navigator.pushNamed(
                                  context,
                                  widget.tuple2.item1.routePath,
                                  arguments: Tuple2(model, (index + 1)),
                                ).then((value) {
                                  isGamePageOpen = false;
                                });
                              },
                            ));
                      }),
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedItem(
          BuildContext context, int index, Animation<double> animation, Widget widget) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: widget,
        ),
      );
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_button_view.dart';
import 'dashboard_provider.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import '../app/theme_provider.dart';
import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    final margin = getHorizontalSpace(context);
    final verticalSpace = getScreenPercentSize(context, 3);

    final dashboardState = ref.watch(dashboardProvider); // Used for dashboard data
    final dashboardNotifier = ref.read(dashboardProvider.notifier); // Used for actions
    final themeState = ref.watch(themeProvider); // Used for theme changes

    setStatusBarColor(Theme.of(context).scaffoldBackgroundColor);

    return WillPopScope(
      onWillPop: () async {
        exitApp();
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
          appBar: getNoneAppBar(context),
          body: SafeArea(
            bottom: true,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: getVerticalSpace(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: getScoreWidget(
                              context,
                              ref,
                              color: Theme.of(context).textTheme.titleSmall?.color,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              // Use dashboardNotifier for any settings logic if needed
                              dashboardNotifier.openSettings(); // Example usage
                              Navigator.pushNamed(context, KeyUtil.settings);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: getVerticalSpace(context)),
                      getHeaderWidget(
                        context,
                        'Memory Math',
                        'Train Your Brain, Improve Your Math Skills',
                      ),
                      SizedBox(height: FetchPixels.getPixelHeight(120)),
                      Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                KeyUtil.dashboardItems.length,
                                (i) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: verticalSpace,
                                  ),
                                  child: DashboardButtonView(
                                    dashboard: _getItem(i, themeState), // themeState used for color
                                    position: i.isEven
                                        ? _offsetLeftEnter
                                        : _offsetRightEnter,
                                    margin: margin,
                                    onTab: () {
                                      // Use dashboardState for navigation logic if needed
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        KeyUtil.home,
                                        ModalRoute.withName(KeyUtil.dashboard),
                                        arguments: Tuple2(
                                          _getItem(i, themeState),
                                          MediaQuery.of(context).padding.top,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dashboard getItem(int i, ThemeMode themeMode) {
    var model = KeyUtil.dashboardItems[i];
    // If bgColor is final, use copyWith or similar
    if (themeMode == ThemeMode.dark) {
      return model.copyWith(bgColor: "#383838".toColor());
    } else {
      return model.copyWith(bgColor: KeyUtil.bgColorList[i]);
    }
  }

  Dashboard _getItem(int i, ThemeMode themeMode) => getItem(i, themeMode);

  Widget getHeaderWidget(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

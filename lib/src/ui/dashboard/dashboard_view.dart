import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/theme_wrapper.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../app/theme_provider.dart';
import '../resizer/fetch_pixels.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;
  late bool isHomePageOpen;

  @override
  void initState() {
    super.initState();

    isHomePageOpen = false;
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  Dashboard getItem(int index, ThemeProvider themeProvider) {
    Dashboard dashboard = KeyUtil.dashboardItems[index];
    final theme = Theme.of(context);

    if (theme.brightness == Brightness.dark) {
      dashboard.bgColor = Color(0xFF383838);
    } else {
      dashboard.bgColor = theme.colorScheme.surface;
    }
    return dashboard;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ThemeWrapper.dyslexicScreen(
          isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          child: _buildDashboard(themeProvider),
        );
      },
    );
  }

  Widget _buildDashboard(ThemeProvider themeProvider) {
    FetchPixels(context);
    final theme = Theme.of(context);

    double margin = getHorizontalSpace(context);
    double verticalSpace = getScreenPercentSize(context, 3);

    setStatusBarColor(theme.scaffoldBackgroundColor);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          exitApp();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: theme.brightness,
        ),
        child: Scaffold(
          backgroundColor: Colors.grey[50], // Light background
          appBar: AppBar(
            toolbarHeight: 44,
            elevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 12,
            title: Text(
              'Dashboard',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
            ),
            actions: [
              // Score / Trophy compact widget from global constants
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Center(child: getScoreWidget(context)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: getSettingWidget(context),
              ),
            ],
            iconTheme: IconThemeData(
              color: Colors.black87,
            ),
          ),
          body: SafeArea(
            bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Simple text header without blue container
                Padding(
                  padding: EdgeInsets.fromLTRB(margin, 20, margin, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Memory Maths',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Montserrat-Bold',
                            ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Train Your Brain, Improve Your Math Skill',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                              fontFamily: 'Montserrat-Regular',
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Expanded(
                  child:
                      _buildCategoryList(themeProvider, margin, verticalSpace),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(
      ThemeProvider themeProvider, double margin, double verticalSpace) {
    final theme = Theme.of(context);

    // Vibrant color palette for dashboard items
    final List<List<Color>> gradients = [
      [Color(0xFF6A11CB), Color(0xFF2575FC)], // Purple to Blue
      [Color(0xFFFF416C), Color(0xFFFF4B2B)], // Pink to Orange
      [Color(0xFF11998E), Color(0xFF38EF7D)], // Teal to Green
      [Color(0xFFFF8008), Color(0xFFFFC837)], // Orange to Yellow
      [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Purple to Indigo
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: margin),
      itemCount: KeyUtil.dashboardItems.length,
      itemBuilder: (context, index) {
        final dashboard = KeyUtil.dashboardItems[index];
        final Animation<Offset> animation =
            index % 2 == 0 ? _offsetLeftEnter : _offsetRightEnter;
        final gradientPair = gradients[index % gradients.length];

        return SlideTransition(
            position: animation,
            child: Padding(
              padding: EdgeInsets.only(bottom: verticalSpace),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    KeyUtil.home,
                    ModalRoute.withName(KeyUtil.dashboard),
                    arguments: Tuple2(getItem(index, themeProvider),
                        MediaQuery.of(context).padding.top),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: gradientPair[0].withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0, // We'll use custom shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.brightness == Brightness.dark
                                ? theme.colorScheme.surface
                                : Colors.white,
                            theme.brightness == Brightness.dark
                                ? theme.colorScheme.surface
                                : gradientPair[0].withValues(alpha: 0.03),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background decorative elements
                          Positioned(
                            right: -20,
                            bottom: -20,
                            child: Opacity(
                              opacity: 0.08,
                              child: SvgPicture.asset(
                                dashboard.outlineIcon,
                                height: 120,
                                colorFilter: ColorFilter.mode(
                                  gradientPair[0],
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),

                          // Main content
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: gradientPair,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: gradientPair[0]
                                            .withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      dashboard.icon,
                                      height: 42,
                                      colorFilter: ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dashboard.title,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat-Bold',
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        dashboard.subtitle,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                          fontFamily: 'Montserrat-Regular',
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        gradientPair[0].withValues(alpha: 0.7),
                                        gradientPair[1].withValues(alpha: 0.7),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: gradientPair[0]
                                            .withValues(alpha: 0.2),
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 30,
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
              ),
            ));
      },
    );
  }
}

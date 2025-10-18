import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/theme_wrapper.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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

  // Initialize animations with default values to prevent LateInitializationError
  Animation bgColorTween = AlwaysStoppedAnimation(Colors.blue);
  Animation<double> elevationTween = AlwaysStoppedAnimation(20.0);
  Animation<double> subtitleVisibilityTween = AlwaysStoppedAnimation(0.0);
  Animation<double> radiusTween = AlwaysStoppedAnimation(40.0);
  Animation<double> heightTween = AlwaysStoppedAnimation(140.0);
  Animation<TextStyle> textStyleTween =
      AlwaysStoppedAnimation(const TextStyle());
  Animation<double> outlineImageBottomPositionTween =
      AlwaysStoppedAnimation(20.0);
  Animation<double> fillImageBottomPositionTween = AlwaysStoppedAnimation(15.0);
  Animation<double> outlineImageRightPositionTween =
      AlwaysStoppedAnimation(20.0);
  Animation<double> fillImageRightPositionTween = AlwaysStoppedAnimation(15.0);
  bool isGamePageOpen = false;
  Tuple2<Dashboard, double>? tuple2;

  @override
  void initState() {
    super.initState();
    tuple2 = widget.tuple2;
    isGamePageOpen = false;

    // Initialize animations after first frame when Theme is available
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initializeAnimations();
      animationController.forward();
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  void _initializeAnimations() {
    final theme = Theme.of(context);

    bgColorTween = ColorTween(
      begin: tuple2!.item1.bgColor,
      end: theme.scaffoldBackgroundColor,
    ).animate(animationController);

    elevationTween = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    subtitleVisibilityTween = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    radiusTween = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    heightTween = Tween<double>(begin: 140.0, end: 100.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // Fix the TextStyle lerping by using explicit TextStyles with same inherit value
    // and including all necessary properties to avoid "jumps" during animation
    final TextStyle beginStyle = TextStyle(
      inherit: false,
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      fontSize: theme.textTheme.headlineLarge?.fontSize ?? 32.0,
      fontFamily: 'OpenDyslexic',
      // Using accessible font
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.2,
      backgroundColor: Colors.transparent,
      decorationColor: Colors.transparent,
      decorationThickness: 0.0,
    );

    final TextStyle endStyle = TextStyle(
      inherit: false,
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      fontSize: theme.textTheme.headlineMedium?.fontSize ?? 28.0,
      fontFamily: 'OpenDyslexic',
      // Using accessible font
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.2,
      backgroundColor: Colors.transparent,
      decorationColor: Colors.transparent,
      decorationThickness: 0.0,
    );

    textStyleTween = TextStyleTween(
      begin: beginStyle,
      end: endStyle,
    ).animate(animationController);

    // Image position animations
    outlineImageBottomPositionTween =
        Tween<double>(begin: 20.0, end: 10.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    fillImageBottomPositionTween = Tween<double>(begin: 15.0, end: 5.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    outlineImageRightPositionTween =
        Tween<double>(begin: 20.0, end: 10.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    fillImageRightPositionTween = Tween<double>(begin: 15.0, end: 5.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ThemeWrapper.dyslexicScreen(
          isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          child: _buildHomeView(),
        );
      },
    );
  }

  Widget _buildHomeView() {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        toolbarHeight: 44,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 12,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
        ),
        actions: [
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section with game info
              _buildHeader(),

              // Game buttons grid
              _buildGameGrid(dashboardProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          height: heightTween.value,
          decoration: BoxDecoration(
            color: Colors.transparent, // Make header background transparent
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radiusTween.value),
              bottomRight: Radius.circular(radiusTween.value),
            ),
          ),
          child: Stack(
            children: [
              // Background elements are now more prominent
              _buildBackgroundElements(),

              // Header content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Game title
                    AnimatedDefaultTextStyle(
                      style: textStyleTween.value ??
                          theme.textTheme.headlineLarge!,
                      duration: Duration(milliseconds: 300),
                      child: Text(tuple2?.item1.title ?? ''),
                    ),

                    // Subtitle with fade animation
                    AnimatedOpacity(
                      opacity: subtitleVisibilityTween.value,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        tuple2?.item1.subtitle ?? '',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Add decorative elements based on game type
        if (tuple2?.item1.outlineIcon != null)
          Positioned(
            right: outlineImageRightPositionTween.value,
            bottom: outlineImageBottomPositionTween.value,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.1, // Reduced opacity for better visibility
                  child: SvgPicture.asset(
                    tuple2!.item1.outlineIcon,
                    height: 120,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .colorScheme
                          .onSurface, // Use theme color
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildGameGrid(DashboardProvider dashboardProvider) {
    // Get games for the current puzzle type
    final games =
        dashboardProvider.getGameByPuzzleType(tuple2!.item1.puzzleType);
    final theme = Theme.of(context);

    // Colors for our vibrant design
    final List<Color> gradientColors = [
      Color(0xFF6A11CB), // Rich purple
      Color(0xFF2575FC), // Bright blue
      Color(0xFFFF416C), // Vibrant pink
      Color(0xFFFF4B2B), // Bright orange
      Color(0xFF11998E), // Teal
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        // Pick a color from our list based on index
        final baseColor = gradientColors[index % gradientColors.length];

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500 + (index * 100)),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            // Clamp the value to ensure it's always between 0.0 and 1.0
            final clampedValue = value.clamp(0.0, 1.0);

            return Transform.translate(
                offset: Offset(0, 20 * (1 - clampedValue)),
                child: Opacity(
                    opacity: clampedValue,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Card(
                        elevation: 3 * clampedValue,
                        shadowColor: baseColor.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                baseColor.withValues(alpha: 0.05),
                                baseColor.withValues(alpha: 0.15),
                              ],
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: baseColor.withValues(alpha: 0.1),
                            highlightColor: baseColor.withValues(alpha: 0.05),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                KeyUtil.level,
                                arguments: Tuple2(game, tuple2!.item1),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: 'game_icon_${game.id}',
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            baseColor,
                                            baseColor.withValues(alpha: 0.7),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: baseColor.withValues(
                                                alpha: 0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          game.icon,
                                          height: 36,
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn),
                                        ),
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
                                          game.name,
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat-Bold',
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.emoji_events_outlined,
                                              color: baseColor.withValues(
                                                  alpha: 0.9),
                                              size: 18,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'High Score: ${game.scoreboard.highestScore}',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: baseColor.withValues(
                                                alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Play Now',
                                            style: theme.textTheme.labelSmall
                                                ?.copyWith(
                                              color: baseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Material(
                                    color: baseColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          KeyUtil.level,
                                          arguments:
                                              Tuple2(game, tuple2!.item1),
                                        );
                                      },
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.play_circle_fill_rounded,
                                            color: baseColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )));
          },
        );
      },
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mathsgames/src/core/theme_wrapper.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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
    // Don't dispose here - let the dispose() method handle it
    // if (animationController != null) {
    //   animationController!.dispose();
    // }

    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
    return Future.value(false);
  }

  @override
  void dispose() {
    // Safely dispose the animation controller only if it exists and hasn't been disposed
    if (animationController != null && !animationController!.isCompleted) {
      animationController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ThemeWrapper.gameScreen(
          isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          child: _buildLevelView(),
        );
      },
    );
  }

  Widget _buildLevelView() {
    final theme = Theme.of(context);
    double margin = getHorizontalSpace(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _requestPop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50], // Light background
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 44,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _requestPop(),
            color: Colors.black87,
          ),
          title: Text(
            widget.tuple2.item1.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Center(child: getScoreWidget(context)),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: Column(
          children: [
            // Game info header with gradient background
            _buildGameHeader(theme),

            // Level selection with categories
            Expanded(
              child: _buildLevelList(theme, margin),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameHeader(ThemeData theme) {
    // Generate vibrant gradient based on game type
    final List<Color> headerGradient = _getGradientForGame();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: headerGradient,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: headerGradient[0].withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'game_title_${widget.tuple2.item1.id}',
            child: Text(
              widget.tuple2.item1.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat-Bold',
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose your level and start playing!',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontFamily: 'Montserrat-Regular',
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _buildStatContainer(headerGradient[0], Icons.grid_view_rounded, '30 Levels'),
              SizedBox(width: 16),
              _buildStatContainer(headerGradient[0], Icons.timer_outlined, '3 Minutes/Level'),
              SizedBox(width: 16),
              _buildStatContainer(headerGradient[0], Icons.emoji_events_outlined, 'Score: ${widget.tuple2.item1.scoreboard.highestScore}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatContainer(Color baseColor, IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientForGame() {
    // Generate vibrant gradient based on game category type
    switch (widget.tuple2.item1.gameCategoryType) {
      case GameCategoryType.CALCULATOR:
      case GameCategoryType.SQUARE_ROOT:
      case GameCategoryType.CUBE_ROOT:
        return [Color(0xFF6A11CB), Color(0xFF2575FC)]; // Purple to Blue

      case GameCategoryType.GUESS_SIGN:
      case GameCategoryType.CORRECT_ANSWER:
      case GameCategoryType.COMPLEX_CALCULATION:
        return [Color(0xFFFF416C), Color(0xFFFF4B2B)]; // Pink to Orange

      case GameCategoryType.MATH_PAIRS:
      case GameCategoryType.MAGIC_TRIANGLE:
      case GameCategoryType.NUMBER_PYRAMID:
        return [Color(0xFF11998E), Color(0xFF38EF7D)]; // Teal to Green

      case GameCategoryType.MENTAL_ARITHMETIC:
      case GameCategoryType.QUICK_CALCULATION:
      case GameCategoryType.FIND_MISSING:
        return [Color(0xFFFF8008), Color(0xFFFFC837)]; // Orange to Yellow

      default:
        return [Color(0xFF8E2DE2), Color(0xFF4A00E0)]; // Purple to Indigo
    }
  }

  Widget _buildLevelList(ThemeData theme, double margin) {
    // 30 levels grouped into Beginner, Intermediate, Advanced

    // Create level groups: Beginner (1-10), Intermediate (11-20), Advanced (21-30)
    List<Map<String, dynamic>> levelGroups = [
      {
        'title': 'Beginner',
        'subtitle': 'Perfect for newcomers',
        'levels': List.generate(10, (i) => i + 1),
        'gradient': [Color(0xFF00B4DB), Color(0xFF0083B0)],
        'icon': Icons.school_rounded
      },
      {
        'title': 'Intermediate',
        'subtitle': 'For experienced players',
        'levels': List.generate(10, (i) => i + 11),
        'gradient': [Color(0xFFFF8008), Color(0xFFFFC837)],
        'icon': Icons.auto_graph_rounded
      },
      {
        'title': 'Advanced',
        'subtitle': 'Challenge yourself',
        'levels': List.generate(10, (i) => i + 21),
        'gradient': [Color(0xFFFF416C), Color(0xFFFF4B2B)],
        'icon': Icons.military_tech_rounded
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: levelGroups.length,
      itemBuilder: (context, groupIndex) {
        final group = levelGroups[groupIndex];
        final List<Color> gradient = group['gradient'];

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + (groupIndex * 100)),
          curve: Curves.easeOutQuart,
          builder: (context, value, child) {
            // Clamp the value to ensure it's always between 0.0 and 1.0
            final clampedValue = value.clamp(0.0, 1.0);

            return Transform.translate(
              offset: Offset(0, 30 * (1 - clampedValue)),
              child: Opacity(
                opacity: clampedValue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10, top: groupIndex > 0 ? 20 : 10),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            group['icon'],
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            group['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      group['subtitle'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 16),
                    _buildLevelGrid(group['levels'], gradient, theme),
                    groupIndex < levelGroups.length - 1
                        ? Divider(height: 40, thickness: 1, indent: 20, endIndent: 20)
                        : SizedBox(height: 20),
                  ],
                ),
              )
            );
          },
        );
      },
    );
  }

  Widget _buildLevelGrid(List<int> levels, List<Color> gradient, ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        return _buildLevelCard(level, theme, gradient);
      },
    );
  }

  Widget _buildLevelCard(int level, ThemeData theme, List<Color> gradient) {
    return GestureDetector(
      onTap: () => _navigateToGame(level),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300 + (level * 30)),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.7 + (0.3 * value),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    gradient[0],
                    gradient[1],
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: gradient[0].withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      level.toString(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ));
        },
      ),
    );
  }

  void _navigateToGame(int level) {
    final gameCategory = widget.tuple2.item1;
    final dashboard = widget.tuple2.item2;

    print('Navigating to: ${gameCategory.routePath} with level: $level');
    print('Dashboard properties: folder=${dashboard.folder}, primaryColor=${dashboard.primaryColor}');

    // Create gradient model with proper properties from Dashboard - matching old code structure
    final gradientModel = GradientModel();

    // Set properties exactly as the old working code did
    gradientModel.primaryColor = dashboard.primaryColor;
    gradientModel.gridColor = dashboard.gridColor;
    gradientModel.bgColor = dashboard.bgColor;
    gradientModel.backgroundColor = dashboard.backgroundColor;
    gradientModel.folderName = dashboard.folder; // Note: Dashboard.folder -> GradientModel.folderName

    // Set cellColor using theme-aware approach like the old code
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    gradientModel.cellColor = _getBgColor(themeProvider, dashboard.bgColor);

    // Set colors array for gradient display
    gradientModel.colors = [
      dashboard.primaryColor,
      dashboard.primaryColor.withValues(alpha: 0.8),
    ];

    print('GradientModel created with: primaryColor=${gradientModel.primaryColor}, folderName=${gradientModel.folderName}');

    // Navigate to the specific game with level and gradient - matching old code structure
    Navigator.pushNamed(
      context,
      gameCategory.routePath,
      arguments: Tuple2(gradientModel, level),
    ).then((value) {
      // Reset game page state after returning from game
      setState(() {
        isGamePageOpen = false;
      });
    });
  }

  // Helper method to get background color based on theme (from old code)
  Color _getBgColor(ThemeProvider themeProvider, Color originalColor) {
    // Return appropriate color based on theme mode
    if (themeProvider.themeMode == ThemeMode.dark) {
      return Theme.of(context).colorScheme.surface;
    } else {
      return originalColor;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/splash/animated_grid_item_view.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

/// Splash screen with Material 3 design and dyslexic-friendly features
/// Features high contrast colors, readable fonts, and calming visual elements
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations for smoother transitions
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _fadeController.forward();
    _scaleController.forward();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    // Check authentication status after splash delay
    Future.delayed(Duration(seconds: 3)).then((value) {
      _checkAuthAndNavigate();
    });
  }

  /// Check authentication status and navigate to appropriate screen
  Future<void> _checkAuthAndNavigate() async {
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Check if user is already logged in
    await authProvider.checkAuthStatus();

    if (!mounted) return;

    // Navigate based on authentication status
    if (authProvider.isAuthenticated) {
      // User is logged in, go to dashboard
      Navigator.pushReplacementNamed(context, KeyUtil.dashboard);
    } else {
      // User not logged in, go to login screen
      Navigator.pushReplacementNamed(context, KeyUtil.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: theme.colorScheme.surface,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            // Material 3 compatible gradient using theme colors
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerHighest,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.6, 1.0],
            ),
          ),
          child: AnimatedBuilder(
            animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App icon with Material 3 card design
                      Card(
                        elevation: 8,
                        child: Container(
                          padding: EdgeInsets.all(32),
                          child: SvgPicture.asset(
                            AppAssets.splashIcon,
                            height: getScreenPercentSize(context, 18),
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: getScreenPercentSize(context, 4)),

                      // App title with Material 3 typography
                      Text(
                        'Memory Math',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: getScreenPercentSize(context, 1.5)),

                      // Subtitle with Material 3 typography
                      Text(
                        'Learn • Practice • Improve',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          letterSpacing: 0.8,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: getScreenPercentSize(context, 6)),

                      // Material 3 loading indicator
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary,
                          ),
                          backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }
}

class GridItemView extends StatelessWidget {
  final double verticalLine;
  final int index;
  final int horizontalLine;

  const GridItemView({
    Key? key,
    required this.index,
    required this.horizontalLine,
    required this.verticalLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((horizontalLine / 2 - 1) <= index && (horizontalLine / 2 + 1) > index) {
      int tempIndex = (horizontalLine / 2 - 1) == index ? 0 : 1;
      return SizedBox(
        height: verticalLine,
        child: Row(
          children: [
            ...list[tempIndex]
                .map((e) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 0.5),
                        ),
                        child: (e == "<" || e == ">")
                            ? Text(
                                e,
                                style: TextStyle(
                                  color: Colors.white24.withValues(alpha: 0.25),
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                e,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28,
                                  fontFamily: "Poppins",
                                ),
                              ),
                      ),
                    ))
                .toList()
          ],
        ),
      );
    } else {
      int tempIndex = ((horizontalLine / 2 - 1) <= index &&
              (horizontalLine / 2 + 1) > index)
          ? index - 2
          : index;
      return SizedBox(
        height: verticalLine,
        child: Row(
          children: [
            ...list2[tempIndex]
                .map((e) => e.item1 == "."
                    ? Expanded(
                        child: AnimatedGridItemView(
                        duration: e.item2,
                      ))
                    : Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white24, width: 0.1),
                          ),
                          child: Text(
                            e.item1,
                            style: TextStyle(
                              color: Colors.white24.withValues(alpha: 0.5),
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ))
                .toList()
          ],
        ),
      );
    }
  }
}

var list = [
  ["M", "A", "T", "H", "<", ">"],
  ["M", "A", "T", "R", "I", "X"],
];

var list2 = [
  [
    Tuple2("+", 0),
    Tuple2("0", 0),
    Tuple2("8", 0),
    Tuple2("1", 0),
    Tuple2("7", 0),
    Tuple2("*", 0)
  ],
  [
    Tuple2("3", 0),
    Tuple2("%", 0),
    Tuple2("5", 0),
    Tuple2("0", 0),
    Tuple2("+", 0),
    Tuple2("=", 0),
  ],
  [
    Tuple2("*", 0),
    Tuple2("3", 400),
    Tuple2("~", 0),
    Tuple2("4", 0),
    Tuple2("-", 0),
    Tuple2("2", 0),
  ],
  [
    Tuple2("-", 0),
    Tuple2("6", 0),
    Tuple2("=", 0),
    Tuple2("7", 1600),
    Tuple2("~", 0),
    Tuple2("9", 0),
  ],
  [
    Tuple2("+", 0),
    Tuple2("~", 0),
    Tuple2("8", 0),
    Tuple2("+", 0),
    Tuple2("4", 0),
    Tuple2("*", 0),
  ],
  [
    Tuple2("3", 0),
    Tuple2("%", 0),
    Tuple2("5", 0),
    Tuple2("0", 0),
    Tuple2("+", 0),
    Tuple2("=", 0),
  ],
  [
    Tuple2("*", 0),
    Tuple2("1", 0),
    Tuple2("~", 0),
    Tuple2("4", 0),
    Tuple2("-", 0),
    Tuple2("2", 0),
  ],
  [
    Tuple2("3", 0),
    Tuple2("%", 0),
    Tuple2("5", 0),
    Tuple2("0", 0),
    Tuple2("+", 0),
    Tuple2("=", 0),
  ],
  [
    Tuple2("*", 0),
    Tuple2("1", 0),
    Tuple2("~", 0),
    Tuple2("6", 2600),
    Tuple2("-", 0),
    Tuple2("2", 0),
  ],
  [
    Tuple2("-", 0),
    Tuple2("6", 0),
    Tuple2("=", 0),
    Tuple2("2", 0),
    Tuple2("~", 0),
    Tuple2("9", 0),
  ],
  [
    Tuple2("/", 0),
    Tuple2("1", 3200),
    Tuple2("~", 0),
    Tuple2("4", 0),
    Tuple2("6", 0),
    Tuple2("%", 0),
  ],
  [
    Tuple2("~", 0),
    Tuple2("2", 0),
    Tuple2("5", 0),
    Tuple2("*", 0),
    Tuple2("+", 0),
    Tuple2("5", 0),
  ],
  [
    Tuple2("6", 0),
    Tuple2("+", 0),
    Tuple2("7", 0),
    Tuple2("/", 0),
    Tuple2("6", 0),
    Tuple2("-", 0),
  ],
  [
    Tuple2("3", 0),
    Tuple2("%", 0),
    Tuple2("4", 0),
    Tuple2("~", 0),
    Tuple2("*", 0),
    Tuple2("2", 0),
  ],
  [
    Tuple2("1", 0),
    Tuple2("/", 0),
    Tuple2("3", 0),
    Tuple2("7", 0),
    Tuple2("-", 0),
    Tuple2("2", 0),
  ],
  [
    Tuple2("-", 0),
    Tuple2("8", 0),
    Tuple2("=", 0),
    Tuple2("%", 0),
    Tuple2("/", 0),
    Tuple2("7", 0),
  ],
  [
    Tuple2("9", 0),
    Tuple2("~", 0),
    Tuple2("=", 0),
    Tuple2("2", 0),
    Tuple2("*", 0),
    Tuple2("7", 0),
  ],
];

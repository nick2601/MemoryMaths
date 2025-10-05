import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/rate_dialog_view.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../core/app_assets.dart';
import 'app/auth_provider.dart';
import 'app/theme_provider.dart';
import 'app/coin_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common_alert_dialog.dart';
import 'reports/user_report_view.dart';
import 'reports/user_report_provider.dart';
import 'app/accessibility_provider.dart';

/// SettingScreen provides user configurable options for the app.
///
/// This screen allows users to customize:
/// - Theme (dark/light mode)
/// - Sound settings
/// - Vibration settings
/// - Accessibility options
/// - View performance reports
/// - Reset user data
/// - Access support options (feedback, rate, share)
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingScreen();
  }
}

class _SettingScreen extends State<SettingScreen> {
  /// Handles back navigation with platform-specific behavior
  void backClicks() {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  /// Value notifiers for app settings
  ValueNotifier<bool> soundOn = ValueNotifier(false);
  ValueNotifier<bool> darkMode = ValueNotifier(false);
  ValueNotifier<bool> vibrateOn = ValueNotifier(false);

  /// Loading indicator for report generation
  bool _isGeneratingReport = false;

  /// Loading indicator for reset operation
  bool _isResetting = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getSpeakerVol();
  }

  /// Initializes app settings from SharedPreferences
  Future<void> getSpeakerVol() async {
    soundOn.value = await getSound();
    vibrateOn.value = await getVibration();
    Future.delayed(Duration.zero, () {
      darkMode.value = Theme.of(context).brightness != Brightness.light;
    });
  }

  double fontTitleSize = 30;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    int selection = 1;

    Widget verSpace = SizedBox(height: FetchPixels.getPixelHeight(35));

    double margin = getHorizontalSpace(context);

    TextStyle theme = Theme.of(context).textTheme.titleSmall!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          backClicks();
        }
      },
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getDefaultIconWidget(context,
                        icon: AppAssets.backIcon,
                        folder: KeyUtil.themeYellowFolder, function: () {
                      backClicks();
                    }),
                    Expanded(
                        child: Center(
                            child: getCustomFont(
                                'Settings', 35, theme.color!, 1,
                                fontWeight: FontWeight.w600))),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                    ),
                  ],
                ),
                buildExpandedData(
                  selection,
                  verSpace,
                  context,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the progress report button widget
  ///
  /// [context] - BuildContext for theme and providers
  /// Returns a Container with the report button and description
  Widget _buildReportButton(BuildContext context) {
    final theme = Theme.of(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final reportProv = Provider.of<UserReportProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelWidth(30),
        vertical: FetchPixels.getPixelHeight(30),
      ),
      decoration: getDefaultDecoration(
        radius: FetchPixels.getPixelHeight(30),
        borderColor: Colors.grey,
        bgColor: null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSubTitleFonts("View Progress Report"),
                SizedBox(height: 6),
                Text(
                  "Tap to generate your latest performance & learning report.",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          _isGeneratingReport
              ? SizedBox(
                  width: FetchPixels.getPixelHeight(60),
                  height: FetchPixels.getPixelHeight(60),
                  child: const CircularProgressIndicator(strokeWidth: 3),
                )
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(30),
                      vertical: FetchPixels.getPixelHeight(20),
                    ),
                  ),
                  onPressed: () async {
                    if (!auth.isAuthenticated || auth.userEmail == null || auth.userEmail!.isEmpty) {
                      return; // Do nothing if not logged in
                    }
                    setState(() => _isGeneratingReport = true);
                    try {
                      final hasData = await reportProv.hasUserReportData(auth.userEmail!);
                      if (!hasData) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No progress report available yet. Please play a game to generate your report.')),
                          );
                        }
                        return;
                      }
                      await reportProv.generateReport(auth.userEmail!);
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserReportView(userEmail: auth.userEmail!),
                        ),
                      );
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to generate report: $e')),
                        );
                      }
                    } finally {
                      if (mounted) setState(() => _isGeneratingReport = false);
                    }
                  },
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text('View'),
                ),
        ],
      ),
    );
  }

  /// Builds the reset user data button widget
  ///
  /// [context] - BuildContext for theme and providers
  /// Returns a Container with the reset button and description
  Widget _buildResetButton(BuildContext context) {
    final theme = Theme.of(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelWidth(30),
        vertical: FetchPixels.getPixelHeight(30),
      ),
      decoration: getDefaultDecoration(
        radius: FetchPixels.getPixelHeight(30),
        borderColor: Colors.red.shade300,
        bgColor: Colors.red.shade50,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red.shade600, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Reset All Data",
                      style: TextStyle(
                        fontSize: fontTitleSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "This will permanently delete all your coins, scores, progress, and statistics. This action cannot be undone.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red.shade600,
                  ),
                ),
              ],
            ),
          ),
          _isResetting
              ? SizedBox(
                  width: FetchPixels.getPixelHeight(60),
                  height: FetchPixels.getPixelHeight(60),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.red.shade600,
                  ),
                )
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(30),
                      vertical: FetchPixels.getPixelHeight(20),
                    ),
                  ),
                  onPressed: auth.isAuthenticated ? () => _showResetDialog(context) : null,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
        ],
      ),
    );
  }

  /// Shows confirmation dialog for resetting user data
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red.shade600),
              SizedBox(width: 8),
              Text('Reset All Data', style: TextStyle(color: Colors.red.shade700)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This will permanently delete:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              _resetDialogItem('• All your coins and rewards'),
              _resetDialogItem('• Game scores and progress'),
              _resetDialogItem('• Statistics and achievements'),
              _resetDialogItem('• Level completion history'),
              _resetDialogItem('• Performance reports data'),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red.shade600, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This action cannot be undone!',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _performReset();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: Text('Reset All Data'),
            ),
          ],
        );
      },
    );
  }

  /// Creates a reset dialog item widget
  Widget _resetDialogItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(text, style: TextStyle(fontSize: 14)),
    );
  }

  /// Performs the actual reset operation
  Future<void> _performReset() async {
    setState(() => _isResetting = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final coinProvider = Provider.of<CoinProvider>(context, listen: false);
      final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

      // Get the current username before reset for verification
      final username = authProvider.username;

      // Reset all user data through AuthProvider
      await authProvider.resetCurrentUserData();

      // Reset scores through DashboardProvider
      print("Resetting scores for user: $username");
      await dashboardProvider.resetAllScoreData();
      print("Scores after reset - Overall score: ${dashboardProvider.overallScore}");

      // Force reload of coins to ensure UI updates
      await coinProvider.getCoin();

      // Double check the coins are actually reset
      if (username != null) {
        // Force reload of coins to verify reset
        await coinProvider.getCoin();
        final coins = coinProvider.coin;
        print("Verifying coins after reset for $username: $coins");

        // If coins still exist, reset them again
        if (coins > 0) {
          await coinProvider.resetCoins();
          await coinProvider.getCoin();
        }
      }

      // Show success message with verification
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'All data has been reset successfully. Coins: ${coinProvider.coin}, Trophies: ${dashboardProvider.overallScore}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            duration: Duration(seconds: 3),
          ),
        );

        // Force navigation refresh to ensure UI updates
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardView()),
        );
      }
    } catch (e) {
      // Show error message with more details
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Expanded(child: Text('Failed to reset data: $e')),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isResetting = false);
      }
    }
  }

  /// Builds the main scrollable content area with all settings
  ///
  /// [selection] - Current selection state
  /// [verSpace] - Vertical spacing widget
  /// [context] - BuildContext for theme
  /// Returns an Expanded widget containing all settings options
  Expanded buildExpandedData(
    int selection,
    Widget verSpace,
    BuildContext context,
  ) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            SizedBox(height: FetchPixels.getPixelHeight(30)),
            getTitleText("Progress Report"),
            SizedBox(height: FetchPixels.getPixelHeight(20)),
            _buildReportButton(context),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("User Data"),
            SizedBox(height: FetchPixels.getPixelHeight(20)),
            _buildResetButton(context),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("Sound"),
            verSpace,
            SizedBox(
              height: FetchPixels.getPixelHeight(125),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            child: getSubTitleFonts("Sound"),
                            flex: 1,
                          ),
                          ValueListenableBuilder(
                            valueListenable: soundOn,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: soundOn.value,
                                inactiveColor:
                                    lighten(KeyUtil.primaryColor1, 0.09),
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  soundOn.value = val;
                                  setSound(val);
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            child: getSubTitleFonts("Vibration"),
                            flex: 1,
                          ),
                          ValueListenableBuilder(
                            valueListenable: vibrateOn,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: vibrateOn.value,
                                inactiveColor:
                                    lighten(KeyUtil.primaryColor1, 0.09),
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  vibrateOn.value = val;
                                  setVibration(val);
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("Theme"),
            verSpace,
            SizedBox(
              height: FetchPixels.getPixelHeight(125),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            child: getSubTitleFonts("Dark Mode"),
                            flex: 1,
                          ),
                          ValueListenableBuilder(
                            valueListenable: darkMode,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: darkMode.value,
                                inactiveColor:
                                    lighten(KeyUtil.primaryColor1, 0.09),
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  context.read<ThemeProvider>().changeTheme();
                                  darkMode.value = val;
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("Accessibility & Assist"),
            SizedBox(height: FetchPixels.getPixelHeight(30)),
            _buildAccessibilityToggles(context),
            verSpace,
            getDivider(),
            getCell(
                string: "Share",
                function: () {
                  share();
                }),
            getDivider(),
            getCell(
                string: "Rate Us",
                function: () {
                  GradientModel model = GradientModel();
                  model.primaryColor = KeyUtil.primaryColor1;
                  showDialog<bool>(
                    context: context,
                    builder: (newContext) => CommonAlertDialog(
                      child: RateViewDialog(
                        colorTuple: Tuple2(model, 0),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                }),
            getDivider(),
            getCell(
                string: "Feedback",
                function: () async {
                  GradientModel model = GradientModel();
                  model.primaryColor = KeyUtil.primaryColor1;

                  showDialog<bool>(
                    context: context,
                    builder: (newContext) => CommonAlertDialog(
                      child: RateViewDialog(
                        colorTuple: Tuple2(model, 0),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                }),
            getDivider(),
            getCell(
                string: "Privacy Policy",
                function: () async {
                  _launchURL();
                }),
            getDivider(),
            // Add some bottom padding
            SizedBox(height: FetchPixels.getPixelHeight(50)),
          ],
        ),
      ),
      flex: 1,
    );
  }

  /// Launches the privacy policy URL
  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(privacyURL)))
      throw 'Could not launch $privacyURL';
  }

  /// Shares the app link using platform share functionality
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Math Games',
        text: getAppLink(),
        linkUrl: '',
        chooserTitle: 'Share');
  }

  /// Creates a settings cell with title and tap action
  ///
  /// [string] - The cell title
  /// [function] - Callback when cell is tapped
  /// Returns an InkWell with cell layout
  Widget getCell({required String string, required Function function}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: getTitleText(string),
              flex: 1,
            ),
            Icon(Icons.navigate_next,
                color: Theme.of(context).textTheme.titleMedium!.color)
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(45)),
      ),
    );
  }

  /// Creates a divider line
  ///
  /// Returns a Container with thin horizontal line
  Widget getDivider() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      height: 0.5,
    );
  }

  /// Creates a subtitle text with consistent styling
  ///
  /// [titles] - The text to display
  /// Returns a styled text widget
  Widget getSubTitleFonts(String titles) {
    TextStyle theme = Theme.of(context).textTheme.titleSmall!;
    return getCustomFont(titles, fontTitleSize, theme.color!, 1,
        fontWeight: FontWeight.w500, textAlign: TextAlign.start);
  }

  /// Creates a title text with consistent styling
  ///
  /// [string] - The text to display
  /// Returns a styled text widget
  Widget getTitleText(String string) {
    TextStyle theme = Theme.of(context).textTheme.titleSmall!;
    return getCustomFont(string, 30, theme.color!, 1,
        fontWeight: FontWeight.w600);
  }

  /// Builds accessibility toggle switches
  ///
  /// [context] - BuildContext for theme and providers
  /// Returns a Column with accessibility toggle options
  Widget _buildAccessibilityToggles(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();
    return Column(
      children: [
        _accessRow(
          label: 'Adaptive Difficulty',
          value: accessibility.adaptiveDifficultyEnabled,
          onChanged: (v) => accessibility.toggleAdaptiveDifficulty(v),
          help: 'Automatically adjusts level difficulty based on performance.'
        ),
        SizedBox(height: FetchPixels.getPixelHeight(25)),
        _accessRow(
          label: 'Dyslexic Mode',
          value: accessibility.dyslexicModeEnabled,
          onChanged: (v) => accessibility.toggleDyslexicMode(v),
          help: 'Uses fonts & layout optimized for dyslexic readers.'
        ),
        SizedBox(height: FetchPixels.getPixelHeight(25)),
        _accessRow(
          label: 'High Contrast',
          value: accessibility.highContrastEnabled,
          onChanged: (v) => accessibility.toggleHighContrast(v),
          help: 'Increases color contrast for better visual clarity.'
        ),
        SizedBox(height: FetchPixels.getPixelHeight(25)),
        _accessRow(
          label: 'Large Text',
          value: accessibility.largeTextEnabled,
          onChanged: (v) => accessibility.toggleLargeText(v),
          help: 'Enlarges text size & spacing for readability.'
        ),
      ],
    );
  }

  /// Creates an accessibility toggle row
  ///
  /// [label] - The setting name
  /// [value] - Current toggle state
  /// [onChanged] - Callback when toggled
  /// [help] - Optional help text
  /// Returns a Container with styled toggle switch
  Widget _accessRow({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    String? help
  }) {
    return Container(
      height: FetchPixels.getPixelHeight(125),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(30)),
      decoration: getDefaultDecoration(
        radius: FetchPixels.getPixelHeight(30),
        borderColor: Colors.grey,
        bgColor: null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getSubTitleFonts(label),
                if (help != null) ...[
                  SizedBox(height: 4),
                  Text(
                    help,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          FlutterSwitch(
            value: value,
            inactiveColor: lighten(KeyUtil.primaryColor1, 0.09),
            inactiveToggleColor: Colors.white,
            activeColor: KeyUtil.primaryColor1,
            width: FetchPixels.getPixelHeight(130),
            height: FetchPixels.getPixelHeight(75),
            onToggle: onChanged,
          ),
        ],
      ),
    );
  }
}

class SliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.

  SliderThumbShape(
    this.setColor, {
    this.enabledThumbRadius = 7.5,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  ///
  Color setColor = Colors.white;
  final double? enabledThumbRadius;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double? disabledThumbRadius;

  double? get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  /// The resting elevation adds shadow to the unpressed thumb.
  ///
  /// The default is 1.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  ///
  final double elevation;

  /// The pressed elevation adds shadow to the pressed thumb.
  ///
  /// The default is 6.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius! : _disabledThumbRadius!);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    @required Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    @required SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme!.disabledThumbColor != null);
    assert(sliderTheme!.thumbColor != null);
    assert(!sizeWithOverflow!.isEmpty);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );

    final double radius = radiusTween.evaluate(enableAnimation!);

    {
      Paint paint = Paint()..color = Colors.white;
      paint.strokeWidth = 5;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(
        center,
        radius,
        paint,
      );
      {
        Paint paint = Paint()..color = setColor;
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          radius,
          paint,
        );
      }
    }
  }
}

class GameCategory {
  String name;
  int score;

  GameCategory(this.name, this.score);
}

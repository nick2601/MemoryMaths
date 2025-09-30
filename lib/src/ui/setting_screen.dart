import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mathsgames/src/ui/feedback_screen.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/ui/common/rate_dialog_view.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'common/common_alert_dialog.dart';

import 'app/auth_provider.dart';
import 'app/theme_provider.dart';

// ---------------- Providers ---------------- //

final soundProvider = StateProvider<bool>((ref) => false);
final vibrationProvider = StateProvider<bool>((ref) => false);

const String privacyURL = "https://www.google.com"; // Placeholder URL

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  void _back(BuildContext context) {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) Navigator.of(context).pop();
      });
    } else {
      if (Navigator.canPop(context)) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FetchPixels(context);

    final margin = getHorizontalSpace(context);
    final theme = Theme.of(context).textTheme.titleSmall!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _back(context);
      },
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              children: [
                SizedBox(height: getScreenPercentSize(context, 2)),
                Row(
                  children: [
                    getDefaultIconWidget(
                      context,
                      icon: AppAssets.backIcon,
                      folder: KeyUtil.themeYellowFolder,
                      function: () => _back(context),
                    ),
                    const Spacer(),
                    getCustomFont(
                      'Settings',
                      35,
                      theme.color!,
                      1,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.logout,
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
                Expanded(child: _buildList(context, ref)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, WidgetRef ref) {
    final soundOn = ref.watch(soundProvider);
    final vibrateOn = ref.watch(vibrationProvider);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return ListView(
      children: [
        const SizedBox(height: 24),
        getTitleText("Sound"),
        const SizedBox(height: 16),
        Row(
          children: [
            _toggleTile(
              label: "Sound",
              value: soundOn,
              onChanged: (val) => ref.read(soundProvider.notifier).state = val,
            ),
            getHorSpace(FetchPixels.getDefaultHorSpace(context)),
            _toggleTile(
              label: "Vibration",
              value: vibrateOn,
              onChanged: (val) =>
              ref.read(vibrationProvider.notifier).state = val,
            ),
          ],
        ),
        getDivider(),
        getTitleText("Theme"),
        const SizedBox(height: 16),
        _toggleTile(
          label: "Dark Mode",
          value: isDarkMode,
          onChanged: (val) {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        getDivider(),
        _getCell(string: "Share", function: () => _share(context)),
        getDivider(),
        _getCell(
          string: "Rate Us",
          function: () {
            final model = GradientModel()..primaryColor = KeyUtil.primaryColor1;
            showDialog(
              context: context,
              builder: (_) => CommonAlertDialog(
                child: RateViewDialog(colorTuple: Tuple2(model, 0)),
              ),
              barrierDismissible: false,
            );
          },
        ),
        getDivider(),
        _getCell(
            string: "Feedback",
            function: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FeedbackScreen()))),
        getDivider(),
        _getCell(string: "Privacy Policy", function: _launchURL),
        getDivider(),
        _getCell(string: "Logout", function: () => ref.read(authProvider.notifier).logout()),
      ],
    );
  }

  Widget _toggleTile({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(30)),
        decoration: getDefaultDecoration(
          radius: FetchPixels.getPixelHeight(30),
          borderColor: Colors.grey,
        ),
        child: Row(
          children: [
            Expanded(child: getSubTitleFonts(label)),
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
      ),
    );
  }

  Widget _getCell({required String string, required Function function}) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelWidth(30),
          vertical: FetchPixels.getPixelHeight(20),
        ),
        decoration: getDefaultDecoration(
          radius: FetchPixels.getPixelHeight(30),
          borderColor: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getSubTitleFonts(string),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    final uri = Uri.parse(privacyURL);
    if (!await launchUrl(uri)) {
      debugPrint("Could not launch $privacyURL");
    }
  }

  String getAppLink() {
    // Replace with your actual app link
    return "https://play.google.com/store/apps/details?id=com.example.mathsgames";
  }

  Future<void> _share(BuildContext context) async {
    final link = getAppLink();
    await Clipboard.setData(ClipboardData(text: link));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("App link copied to clipboard: $link")),
      );
    }
  }
}

// ----------------- Helpers ----------------- //

Widget getDivider() => Divider(color: Colors.grey.shade300, height: 32);

Widget getSubTitleFonts(String title) {
  return getCustomFont(title, 30, Colors.black, 1,
      fontWeight: FontWeight.w500, textAlign: TextAlign.start);
}

Widget getTitleText(String string) {
  return getCustomFont(string, 30, Colors.black, 1,
      fontWeight: FontWeight.w600);
}

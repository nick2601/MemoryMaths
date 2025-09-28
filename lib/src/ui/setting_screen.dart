import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
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
final darkModeProvider = StateProvider<bool>((ref) => false);

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  void _back(BuildContext context) {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FetchPixels(context);

    final margin = getHorizontalSpace(context);
    final theme = Theme.of(context).textTheme.titleSmall!;
    final darkMode = ref.watch(darkModeProvider);

    return WillPopScope(
      onWillPop: () async {
        _back(context);
        return false;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getDefaultIconWidget(
                      context,
                      icon: AppAssets.backIcon,
                      folder: KeyUtil.themeYellowFolder,
                      function: () => _back(context),
                    ),
                    Expanded(
                      child: Center(
                        child: getCustomFont(
                          'Settings',
                          35,
                          theme.color!,
                          1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () async {
                        await ref.read(authProvider.notifier).signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
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
    final verSpace = SizedBox(height: FetchPixels.getPixelHeight(35));
    final soundOn = ref.watch(soundProvider);
    final vibrateOn = ref.watch(vibrationProvider);
    final darkMode = ref.watch(darkModeProvider);

    return ListView(
      children: [
        verSpace,
        getTitleText("Sound"),
        verSpace,
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
              onChanged: (val) => ref.read(vibrationProvider.notifier).state = val,
            ),
          ],
        ),
        verSpace,
        getDivider(),
        verSpace,
        getTitleText("Theme"),
        verSpace,
        Row(
          children: [
            _toggleTile(
              label: "Dark Mode",
              value: darkMode,
              onChanged: (val) {
                ref.read(darkModeProvider.notifier).state = val;
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ],
        ),
        verSpace,
        getDivider(),
        getCell(string: "Share", function: () => _share()),
        getDivider(),
        getCell(
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
        getCell(string: "Privacy Policy", function: () => _launchURL()),
        getDivider(),
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
          bgColor: null,
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

  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(privacyURL))) {
      throw 'Could not launch $privacyURL';
    }
  }

  Future<void> _share() async {
    await Share.share('Check out Math Games: ${getAppLink()}');
  }
}

// ----------------- Helpers ----------------- //

Widget getDivider() => Container(
  color: Colors.grey.shade300,
  height: 0.5,
);

Widget getSubTitleFonts(String title) {
  return getCustomFont(title, 30, Colors.black, 1,
      fontWeight: FontWeight.w500, textAlign: TextAlign.start);
}

Widget getTitleText(String string) {
  return getCustomFont(string, 30, Colors.black, 1,
      fontWeight: FontWeight.w600);
}
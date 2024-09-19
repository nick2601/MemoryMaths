import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/common/rate_dialog_view.dart';
import 'package:mathsgames/src/ui/model/gradient_model.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../core/app_assets.dart';
import 'app/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common_alert_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingScreen();
  }
}

class _SettingScreen extends State<SettingScreen> {
  void backClicks() {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  ValueNotifier soundOn = ValueNotifier(false);
  ValueNotifier darkMode = ValueNotifier(false);
  ValueNotifier vibrateOn = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    getSpeakerVol();
  }

  getSpeakerVol() async {
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

    TextStyle theme = Theme.of(context).textTheme.subtitle2!;

    return WillPopScope(
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
      onWillPop: () async {
        backClicks();
        return false;
      },
    );
  }

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
            SizedBox(
              height: FetchPixels.getPixelHeight(30),
            ),
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
            getCell(
                string: "Share",
                function: () {
                  share();
                }),
            getDivider(),
            getCell(
                string: "Rate Us",
                function: () {
                  // LaunchReview.launch();

                  GradientModel model = new GradientModel();
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
                  GradientModel model = new GradientModel();
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

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                  // final Email email = Email(
                  //   body: 'Math Matrix',
                  //   subject: "Feedback",
                  //   recipients: ['demo@gmail.com'],
                  //   isHTML: false,
                  // );
                  // await FlutterEmailSender.send(email);
                }),
            getDivider(),
            getCell(
                string: "Privacy Policy",
                function: () async {
                  _launchURL();
                }),
          ],
        ),
      ),
      flex: 1,
    );
  }

  _launchURL() async {
    if (!await launchUrl(Uri.parse(privacyURL)))
      throw 'Could not launch $privacyURL';
  }

  share() async {
    await FlutterShare.share(
        title: 'Math Games',
        text: getAppLink(),
        linkUrl: '',
        chooserTitle: 'Share');
  }

  getCell({required String string, required Function function}) {
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
                color: Theme.of(context).textTheme.subtitle1!.color)
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(45)),
      ),
    );
  }

  Widget getDivider() {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(50)),
      color: Colors.grey.shade300,
      height: 0.5,
    );
  }

  Widget getSubTitleFonts(String titles) {
    TextStyle theme = Theme.of(context).textTheme.subtitle2!;
    return getCustomFont(titles, fontTitleSize, theme.color!, 1,
        fontWeight: FontWeight.w500, textAlign: TextAlign.start);
  }

  getTitleText(String string) {
    TextStyle theme = Theme.of(context).textTheme.subtitle2!;

    // return getCustomFont(
    //   string,
    //   52,
    //   Colors.black,
    //   1,
    //   fontWeight: FontWeight.bold,
    // );
    return getCustomFont(string, 30, theme.color!, 1,
        fontWeight: FontWeight.w600);
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

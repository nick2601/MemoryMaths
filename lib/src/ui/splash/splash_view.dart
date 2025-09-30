import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/splash/animated_grid_item_view.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );
    });

    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, KeyUtil.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.splashIcon,
                height: getScreenPercentSize(context, 16),
              ),
              SizedBox(height: getScreenPercentSize(context, 2.3)),
              getTextWidget(
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Latinotype',
                ),
                'Memory Math',
                TextAlign.center,
                getScreenPercentSize(context, 3.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
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
    final fadedTextStyle = TextStyle(
      color: Colors.white24.withOpacity(0.25),
      fontFamily: "Poppins",
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    final boldTextStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 28,
      fontFamily: "Poppins",
    );

    if ((horizontalLine / 2 - 1) <= index &&
        (horizontalLine / 2 + 1) > index) {
      final tempIndex = (horizontalLine / 2 - 1) == index ? 0 : 1;
      return SizedBox(
        height: verticalLine,
        child: Row(
          children: list[tempIndex].map((e) {
            return Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 0.5),
                ),
                child: Text(e,
                    style: (e == "<" || e == ">")
                        ? fadedTextStyle
                        : boldTextStyle),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      final tempIndex = ((horizontalLine / 2 - 1) <= index &&
          (horizontalLine / 2 + 1) > index)
          ? index - 2
          : index;

      return SizedBox(
        height: verticalLine,
        child: Row(
          children: list2[tempIndex].map((e) {
            return Expanded(
              child: e.item1 == "."
                  ? AnimatedGridItemView(duration: e.item2)
                  : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 0.1),
                ),
                child: Text(
                  e.item1,
                  style: TextStyle(
                    color: Colors.white24.withOpacity(0.5),
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }
}

final list = [
  ["M", "A", "T", "H", "<", ">"],
  ["M", "A", "T", "R", "I", "X"],
];

final list2 = [
  [
    Tuple2("+", 0),
    Tuple2("0", 0),
    Tuple2("8", 0),
    Tuple2("1", 0),
    Tuple2("7", 0),
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
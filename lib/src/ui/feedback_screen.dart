import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/resizer/fetch_pixels.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/Constants.dart';

import '../core/app_assets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController feedbackController = TextEditingController();
  double rate = 0;

  @override
  void initState() {
    super.initState();
    _initThemeMode();
  }

  void _initThemeMode() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      // Currently only checks theme; extend later if needed
      final isDark = Theme.of(context).brightness == Brightness.dark;
      debugPrint("Dark mode: $isDark");
    });
  }

  void _handleBack() {
    if (!mounted) return;
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    final margin = getHorizontalSpace(context);
    final edgeInsets =
    EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context));
    final starSize = FetchPixels.getPixelHeight(80);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getScreenPercentSize(context, 2)),
                getDefaultIconWidget(
                  context,
                  icon: AppAssets.backIcon,
                  folder: KeyUtil.themeYellowFolder,
                  function: _handleBack,
                ),
                Expanded(
                  child: _buildFeedbackForm(edgeInsets, starSize, context),
                ),
                getButtonWidget(
                  context,
                  "Submit Feedback",
                  KeyUtil.primaryColor1,
                  _submitFeedback,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                getVerSpace(FetchPixels.getPixelHeight(75)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackForm(
      EdgeInsets edgeInsets,
      double starSize,
      BuildContext context,
      ) {
    final fontColor = Theme.of(context).textTheme.titleSmall?.color ?? Colors.black;

    return ListView(
      padding: edgeInsets,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(90)),
        getCustomFont("Give Feedback", 53, fontColor, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(25)),
        getCustomFont("Give your feedback about our app", 35, fontColor, 1,
            fontWeight: FontWeight.w500),
        getVerSpace(FetchPixels.getPixelHeight(100)),
        getCustomFont("Are you satisfied with this app?", 35, fontColor, 1,
            fontWeight: FontWeight.w800),
        getVerSpace(FetchPixels.getPixelHeight(45)),
        RatingBar(
          itemCount: 5,
          allowHalfRating: false,
          itemSize: starSize,
          initialRating: rate,
          updateOnDrag: true,
          glowColor: Theme.of(context).scaffoldBackgroundColor,
          ratingWidget: RatingWidget(
            full: getSvgImageWithSize(context, "star_fill.svg", starSize, starSize),
            empty: getSvgImageWithSize(context, "star.svg", starSize, starSize),
            half: getSvgImageWithSize(context, "star_fill.svg", starSize, starSize),
          ),
          itemPadding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(30),
          ),
          onRatingUpdate: (rating) {
            setState(() => rate = rating);
          },
        ),
        getVerSpace(FetchPixels.getPixelHeight(140)),
        getCustomFont("Tell us what can be improved!", 35, fontColor, 1,
            fontWeight: FontWeight.w800),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        _getDefaultTextFiled(
          context,
          "Write your feedback...",
          feedbackController,
          fontColor,
          Colors.grey,
          minLines: true,
        ),
      ],
    );
  }

  Widget _getDefaultTextFiled(
      BuildContext context,
      String s,
      TextEditingController textEditingController,
      Color fontColor,
      Color hintColor, {
        bool minLines = false,
      }) {
    return TextField(
      maxLines: minLines ? 5 : 1,
      controller: textEditingController,
      style: TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: s,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Future<void> _submitFeedback() async {
    if (rate >= 3) {
      final feedback = feedbackController.text.trim();
      final email = Email(
        body: feedback,
        subject: 'App Feedback',
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    } else {
      debugPrint("Feedback not sent: rating too low");
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/global_constants.dart';
import '../feedback_screen.dart';
import '../model/gradient_model.dart';
import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';

class RateViewDialog extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const RateViewDialog({
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double starSize = FetchPixels.getPixelHeight(80);

    double rate = 0;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child:  GestureDetector(
          //     onTap: (){
          //       Navigator.pop(context, false);
          //     },
          //     child: SvgPicture.asset(
          //       getFolderName(context, colorTuple.item1.folderName!)+AppAssets.closeIcon,
          //
          //       width: iconSize,
          //       height: iconSize,
          //     ),
          //   ),
          // ),

          Container(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(80),
                vertical: FetchPixels.getPixelHeight(80)),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(AppAssets.assetPath + "rate.png"),
            ),
          ),

          getTextWidget(
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              "Give Your Opinion",
              TextAlign.center,
              getScreenPercentSize(context, 2.5)),

          SizedBox(height: getScreenPercentSize(context, 1.5)),

          getTextWidget(
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              "Make better math goal for you,and would love to know how would rate our app?",
              TextAlign.center,
              getScreenPercentSize(context, 1.8)),

          SizedBox(height: getScreenPercentSize(context, 3)),

          RatingBar(
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(30)),
              allowHalfRating: false,
              itemSize: starSize,
              initialRating: 0,
              updateOnDrag: true,
              glowColor: Theme.of(context).scaffoldBackgroundColor,
              ratingWidget: RatingWidget(
                full: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
                empty: getSvgImageWithSize(
                    context, "star.svg", starSize, starSize),
                half: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rate = rating;
                });
              }),

          SizedBox(height: getScreenPercentSize(context, 5)),
          Row(
            children: [
              Expanded(
                child: getButtonWidget(
                    context, "Cancel", colorTuple.item1.primaryColor, () {
                  Navigator.pop(context);
                }, textColor: darken(KeyUtil.primaryColor1), isBorder: true),
                flex: 1,
              ),
              SizedBox(
                width: getWidthPercentSize(context, 3),
              ),
              Expanded(
                child: getButtonWidget(
                    context, "Submit", darken(colorTuple.item1.primaryColor!),
                    () async {
                  if (rate >= 3) {
                    Navigator.pop(context);

                    // if (feedbackController.value.text.isNotEmpty) {
                    //   feedback = feedbackController.text.toString();
                    // }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackScreen(),
                        ));

                    // final Email email = Email(
                    //   body: '',
                    //   subject: 'App Feedback',
                    //   recipients: ['john.doe@flutter.dev'],
                    //   isHTML: false,
                    // );
                    // await FlutterEmailSender.send(email);
                  }
                }, textColor: Colors.white),
                flex: 1,
              ),
            ],
          )
        ],
      );
    });
  }
}

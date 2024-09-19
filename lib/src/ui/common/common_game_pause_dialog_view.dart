import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/game_info_dialog.dart';
import 'package:mathsgames/src/utility/dialog_info_util.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';

class CommonGamePauseDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final double score;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonGamePauseDialogView({
    required this.gameCategoryType,
    required this.score,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = getScreenPercentSize(context, 3);

    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              getFolderName(context, colorTuple.item1.folderName!) +
                  AppAssets.closeIcon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
        SizedBox(height: getScreenPercentSize(context, 1.8)),

        getTextWidget(
            Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
            gameInfoDialog.title,
            TextAlign.center,
            getScreenPercentSize(context, 2.5)),

        SizedBox(height: getScreenPercentSize(context, 4)),

        getTextWidget(
            Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w600),
            score.toInt().toString(),
            TextAlign.center,
            getScreenPercentSize(context, 6)),
        SizedBox(height: getScreenPercentSize(context, 1)),

        getTextWidget(
            Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            "Your current score",
            TextAlign.center,
            getScreenPercentSize(context, 2.2)),

        SizedBox(height: getScreenPercentSize(context, 5)),

        Row(
          children: [
            Expanded(
              child: getButtonWidget(context, "Resume".toUpperCase(),
                  colorTuple.item1.primaryColor, () {
                Navigator.pop(context, true);
              }, textColor: Colors.black),
            ),
            SizedBox(
              width: getHorizontalSpace(context),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Container(
                height: getDefaultButtonSize(context),
                width: getDefaultButtonSize(context),
                decoration: getDefaultDecoration(
                    radius: getPercentSize(getDefaultButtonSize(context), 20),
                    bgColor: colorTuple.item1.primaryColor),
                child: Center(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),

        // Row(
        //   children: [
        //     Expanded(
        //       child: Card(
        //         elevation: 2,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: InkWell(
        //           onTap: () {
        //             Navigator.pop(context, true);
        //           },
        //           borderRadius: BorderRadius.all(Radius.circular(12)),
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(12),
        //             child: Container(
        //                 height: 44,
        //                 alignment: Alignment.center,
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     colors: [Color(0xffF48C06), Color(0xffD00000)],
        //                     begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter,
        //                   ),
        //                 ),
        //                 child: Text("RESUME",
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .subtitle1!
        //                         .copyWith(fontSize: 18, color: Colors.white))),
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 6),
        //     Card(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       elevation: 2,
        //       child: InkWell(
        //         onTap: () {
        //           Navigator.pop(context, false);
        //         },
        //         borderRadius: BorderRadius.all(Radius.circular(12)),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(12),
        //           child: Container(
        //             alignment: Alignment.center,
        //             height: 44,
        //             width: 44,
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                 colors: [Color(0xffF48C06), Color(0xffD00000)],
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //               ),
        //             ),
        //             child: Icon(
        //               Icons.refresh,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}

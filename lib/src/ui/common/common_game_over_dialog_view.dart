import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_assets.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../model/gradient_model.dart';

class CommonGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score;
  final int right;
  final int wrong;
  final int level;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;
  final VoidCallback? onRestart;
  final VoidCallback? onHome;
  final VoidCallback? onShare;

  const CommonGameOverDialogView({
    Key? key,
    required this.gameCategoryType,
    required this.score,
    required this.right,
    required this.wrong,
    required this.level,
    required this.totalQuestion,
    required this.colorTuple,
    this.onRestart,
    this.onHome,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Back Icon
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Image.asset(AppAssets.backIcon),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        SizedBox(height: getScreenPercentSize(context, 1.8)),

        // Title
        Text(
          "Game Over!!!",
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: getScreenPercentSize(context, 2)),

        // Score Display
        Text(
          "Score: $score",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorTuple.item1.primaryColor,
          ),
        ),

        SizedBox(height: getScreenPercentSize(context, 1.5)),

        // Correct / Wrong counts
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "✔ $right",
              style: textTheme.titleMedium?.copyWith(color: Colors.green),
            ),
            SizedBox(width: 16),
            Text(
              "✘ $wrong",
              style: textTheme.titleMedium?.copyWith(color: Colors.red),
            ),
          ],
        ),

        SizedBox(height: getScreenPercentSize(context, 2.5)),

        // Total Question Info
        Text(
          "You attempted $totalQuestion questions",
          style: textTheme.bodyMedium,
        ),

        SizedBox(height: getScreenPercentSize(context, 3)),

        // Buttons: Restart, Share, Home
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorTuple.item1.primaryColor!,
              ),
              onPressed: onRestart ?? () => Navigator.pop(context, true),
              child: const Text("Restart"),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: onShare ?? () {}, // TODO: implement share
              child: const Text("Share"),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: onHome ?? () => Navigator.pop(context),
              child: const Text("Home"),
            ),
          ],
        ),
      ],
    );
  }
}
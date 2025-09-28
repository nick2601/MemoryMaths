import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/resizer/widget_utils.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../model/gradient_model.dart';
import '../app/coin_provider.dart'; // Import your coin provider

class CommonHintDialog extends ConsumerStatefulWidget {
  final GameCategoryType gameCategoryType;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonHintDialog({
    required this.gameCategoryType,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CommonHintDialog> createState() => _CommonHintDialogState();
}

class _CommonHintDialogState extends ConsumerState<CommonHintDialog> {
  bool isHint = false;
  static const int hintCoin = 10;

  @override
  Widget build(BuildContext context) {
    final coin = ref.watch(coinProvider);
    final coinNotifier = ref.read(coinProvider.notifier);

    final double iconSize = getScreenPercentSize(context, 3);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getScreenPercentSize(context, 2),
        horizontal: getHorizontalSpace(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Stack(
            children: [
              Center(
                child: getTextWidget(
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  isHint ? '' : 'Hint',
                  TextAlign.center,
                  getScreenPercentSize(context, 3),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    "${widget.colorTuple.item1.folderName ?? ''}${AppAssets.closeIcon}",
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: getScreenPercentSize(context, 2)),

          // Content
          isHint
              ? _buildHintContent(context)
              : _buildHintOptions(context, coin, coinNotifier),
        ],
      ),
    );
  }

  Widget _buildHintContent(BuildContext context) {
    // You may need to pass the answer from outside or via props
    final answer = ''; // Replace with actual answer if available
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidthPercentSize(context, 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTextWidgetWithMaxLine(
                Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                'Answer:',
                TextAlign.center,
                getScreenPercentSize(context, 2),
                4,
              ),
              SizedBox(width: getWidthPercentSize(context, 1)),
              getTextWidgetWithMaxLine(
                Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                answer.isNotEmpty ? answer : '?',
                TextAlign.center,
                getScreenPercentSize(context, 3),
                4,
              ),
            ],
          ),
        ),
        SizedBox(height: getScreenPercentSize(context, 5)),
        getButtonWidget(
          context,
          "OK",
          widget.colorTuple.item1.primaryColor!,
              () => Navigator.pop(context),
          textColor: Colors.black,
        ),
      ],
    );
  }

  Widget _buildHintOptions(
      BuildContext context,
      int coin,
      CoinNotifier coinNotifier,
      ) {
    return Column(
      children: [
        SizedBox(height: getScreenPercentSize(context, 0.5)),
        getButtonWidget(
          context,
          "Use Coin",
          widget.colorTuple.item1.primaryColor!,
              () {
            if (coin >= hintCoin) {
              setState(() => isHint = true);
              coinNotifier.spendCoins(hintCoin);
            } else {
              showCustomToast('Not enough coins', context);
            }
          },
          textColor: Colors.black,
        ),
      ],
    );
  }
}

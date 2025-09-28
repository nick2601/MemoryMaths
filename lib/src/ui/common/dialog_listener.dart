import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/common/common_alert_dialog.dart';
import 'package:mathsgames/src/ui/common/common_alert_over_dialog.dart';
import 'package:mathsgames/src/ui/common/common_dual_game_over_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_game_exit_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_game_pause_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_game_over_dialog_view.dart'; // ✅ single player view
import 'package:mathsgames/src/ui/common/common_hint_dialog.dart';
import 'package:mathsgames/src/ui/common/common_info_dialog_view.dart';
import 'package:mathsgames/src/ui/numericMemory/numeric_view.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../app/game_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/widget_utils.dart';

class DialogListener extends ConsumerStatefulWidget {
  final Widget child;
  final Widget appBar;
  final GameCategoryType gameCategoryType;
  final int level;
  final Tuple2<GradientModel, int> colorTuple;
  final VoidCallback? nextQuiz;

  const DialogListener({
    Key? key,
    required this.appBar,
    required this.child,
    required this.gameCategoryType,
    required this.level,
    required this.colorTuple,
    this.nextQuiz,
  }) : super(key: key);

  @override
  ConsumerState<DialogListener> createState() => _DialogListenerState();
}

class _DialogListenerState extends ConsumerState<DialogListener> {
  bool isDialogOpen = false;

  @override
  void initState() {
    super.initState();

    // 🔑 Listen to changes in dialogType from GameNotifier
    ref.listen<GameState<dynamic>>(
      gameProvider(widget.gameCategoryType),
          (previous, next) {
        if (!isDialogOpen) {
          switch (next.dialogType) {
            case DialogType.over:
              _showOverDialog(next);
              break;
            case DialogType.info:
              _showInfoDialog();
              break;
            case DialogType.pause:
              _showPauseDialog(next);
              break;
            case DialogType.exit:
              _showExitDialog(next);
              break;
            case DialogType.hint:
              _showHintDialog(next);
              break;
            case DialogType.non:
              break;
          }
        }
      },
    );
  }

  void _showOverDialog(GameState state) {
    final notifier = ref.read(gameProvider(widget.gameCategoryType).notifier);

    if (widget.gameCategoryType == GameCategoryType.DUAL_GAME) {
      // ✅ Dual game over dialog
      isDialogOpen = true;
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CommonAlertDialog(
          isGameOver: true,
          child: CommonDualGameOverDialogView(
            gameCategoryType: widget.gameCategoryType,
            score1: state.rightCount, // map to dual player score1
            score2: state.wrongCount, // map to dual player score2
            index: state.index,
            totalQuestion: state.list.length,
            colorTuple: widget.colorTuple,
          ),
        ),
      ).then((value) {
        _resetDialogState();
        notifier.updateScore();
        if (value == true) {
          notifier.startGame(level: widget.level);
        } else {
          Navigator.pop(context);
        }
      });
    } else {
      // ✅ Single player game over dialog
      int level = widget.level;
      isDialogOpen = true;
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CommonAlertOverDialog(
          isGameOver: true,
          child: CommonGameOverDialogView(
            gameCategoryType: widget.gameCategoryType,
            score: state.currentScore.toInt(), // ensure it's int
            right: state.rightCount,
            wrong: state.wrongCount,
            level: widget.level,
            totalQuestion: state.list.length,
            colorTuple: widget.colorTuple,
            onRestart: () {
              Navigator.pop(context, true); // close dialog & restart
            },
            onHome: () {
              Navigator.pop(context); // close dialog
            },
            onShare: () {
              // TODO: implement share logic
            },
          ),
        ),
      ).then((value) {
        _resetDialogState();
        notifier.updateScore();
        if (value == true) {
          if (widget.gameCategoryType == GameCategoryType.NUMERIC_MEMORY &&
              widget.nextQuiz != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => NumericMemoryView(
                  colorTuple: Tuple2(widget.colorTuple.item1, level),
                ),
              ),
            );
          } else {
            notifier.resetGameCounters();
            notifier.startGame(level: level);
          }
        } else {
          Navigator.pop(context);
        }
      });
    }
  }

  void _showInfoDialog() {
    final notifier = ref.read(gameProvider(widget.gameCategoryType).notifier);
    final radius = getScreenPercentSize(context, 5);

    isDialogOpen = true;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      builder: (_) => CommonInfoDialogView(
        gameCategoryType: widget.gameCategoryType,
        color: widget.colorTuple.item1.primaryColor!,
      ),
    ).then((_) {
      _resetDialogState();
      notifier.gotItFromInfoDialog(widget.level);
    });
  }

  void _showPauseDialog(GameState state) {
    final notifier = ref.read(gameProvider(widget.gameCategoryType).notifier);

    isDialogOpen = true;
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CommonAlertDialog(
        child: CommonGamePauseDialogView(
          gameCategoryType: widget.gameCategoryType,
          score: state.currentScore,
          colorTuple: widget.colorTuple,
        ),
      ),
    ).then((value) {
      _resetDialogState();
      if (value == true) {
        notifier.pauseResumeGame();
      } else if (value == false) {
        notifier.updateScore();
        notifier.startGame(level: widget.level);
      } else {
        notifier.updateScore();
        Navigator.pop(context);
      }
    });
  }

  void _showExitDialog(GameState state) {
    final notifier = ref.read(gameProvider(widget.gameCategoryType).notifier);

    isDialogOpen = true;
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CommonAlertDialog(
        child: CommonGameExitDialogView(
          colorTuple: widget.colorTuple,
          score: state.currentScore,
        ),
      ),
    ).then((value) {
      _resetDialogState();
      if (value == true) {
        notifier.updateScore();
        Navigator.pop(context);
      } else {
        notifier.pauseResumeGame();
      }
    });
  }

  void _showHintDialog(GameState state) {
    final notifier = ref.read(gameProvider(widget.gameCategoryType).notifier);
    final radius = getScreenPercentSize(context, 5);

    isDialogOpen = true;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      builder: (_) => CommonHintDialog(
        gameCategoryType: widget.gameCategoryType,
        colorTuple: widget.colorTuple,
      ),
    ).then((_) {
      _resetDialogState();
      notifier.gotItFromInfoDialog(widget.level);
    });
  }

  void _resetDialogState() {
    isDialogOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(gameProvider(widget.gameCategoryType).notifier).exit();
        return true;
      },
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              widget.appBar,
              Expanded(child: widget.child),
            ],
          ),
        ),
      ),
    );
  }
}
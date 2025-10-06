import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/color_scheme.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import 'package:mathsgames/src/ui/common/common_alert_dialog.dart';
import 'package:mathsgames/src/ui/common/common_game_exit_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_game_over_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_game_pause_dialog_view.dart';
import 'package:mathsgames/src/ui/common/common_info_dialog_view.dart';
import 'package:mathsgames/src/ui/concentration/concentration_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/global_constants.dart';
import '../model/gradient_model.dart';
import 'common_alert_over_dialog.dart';
import 'common_dual_game_over_dialog_view.dart';
import 'common_hint_dialog.dart';

class DialogListener<T extends GameProvider> extends StatefulWidget {
  final Widget child;
  final Widget appBar;
  final GameCategoryType gameCategoryType;
  final int level;
  final Tuple2<GradientModel, int> colorTuple;
  final Function? nextQuiz;

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
  State<DialogListener<T>> createState() => _DialogListenerState<T>();
}

class _DialogListenerState<T extends GameProvider>
    extends State<DialogListener<T>> {
  late final T provider;
  bool? isDialogOpen = false;

  @override
  void initState() {
    provider = context.read<T>();
    provider.addListener(addListener);
    super.initState();
  }

  void addListener() {
    double radius = getScreenPercentSize(context, 5);
    print(
        "dialog---true---${provider.dialogType}----${context.read<T>().currentScore}");

    if (isDialogOpen != null && !isDialogOpen!) {
      if (provider.dialogType == DialogType.over &&
          provider.gameCategoryType == GameCategoryType.DUAL_GAME) {
        isDialogOpen = true;
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            isGameOver: true,
            child: CommonDualGameOverDialogView(
              gameCategoryType: widget.gameCategoryType,
              score1: context.read<T>().score1.toInt(),
              score2: context.read<T>().score2.toInt(),
              index: context.read<T>().currentIndex.toInt(),
              colorTuple: widget.colorTuple,
              totalQuestion: provider.currentIndex,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          isDialogOpen = false;
          context.read<T>().updateScore();
          if (value != null && value) {
            context.read<T>().startGame(level: widget.level);
          } else {
            Navigator.pop(context);
          }
        });
      } else {
        int level = context.read<T>().currentLevel;
        switch (provider.dialogType) {
          case DialogType.over:
            context.read<T>().homeViewModel.getCoin();
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertOverDialog(
                child: CommonGameOverDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: context.read<T>().currentScore.toInt(),
                  right: context.read<T>().rightCount.toInt(),
                  wrong: context.read<T>().wrongCount.toInt(),
                  level: context.read<T>().currentLevel.toInt(),
                  function: (nextLevel) {
                    level = nextLevel;
                  },
                  updateFunction: () {
                    context.read<T>().updateScore();
                  },
                  colorTuple: widget.colorTuple,
                  totalQuestion: provider.currentIndex,
                ),
                isGameOver: true,
              ),
              barrierDismissible: false,
            ).then((value) {
              print("level===$level");
              isDialogOpen = false;
              context.read<T>().updateScore();
              if (value != null && value) {
                if (widget.gameCategoryType ==
                    GameCategoryType.NUMERIC_MEMORY) {
                  // Fix: Reset the existing provider instead of creating new view
                  context.read<T>().rightCount = 0;
                  context.read<T>().wrongCount = 0;
                  // Reset index through protected access (this will be handled by startGame)

                  // Reset dialog state properly
                  context.read<T>().dialogType = DialogType.non;

                  // Start new game with proper state reset
                  context.read<T>().startGame(
                      level: level, isTimer: context.read<T>().isTimer);
                } else if (widget.gameCategoryType ==
                    GameCategoryType.CONCENTRATION) {
                  // Special handling for concentration game
                  context.read<T>().rightCount = 0;
                  context.read<T>().wrongCount = 0;
                  // Reset game state through startGame method

                  // Reset dialog state properly
                  context.read<T>().dialogType = DialogType.non;

                  // Stop any existing timers to prevent background changes
                  context.read<T>().pauseTimer();

                  // Reset concentration-specific state
                  if (context.read<T>() is ConcentrationProvider) {
                    final concentrationProvider = context.read<T>() as ConcentrationProvider;
                    concentrationProvider.first = -1;
                    concentrationProvider.second = -1;
                  }

                  // Start new game with proper state reset
                  context.read<T>().startGame(
                      level: level, isTimer: false); // Concentration should not use timer

                  // Trigger widget refresh by calling nextQuiz callback
                  if (widget.nextQuiz != null) {
                    widget.nextQuiz!();
                  }
                } else {
                  context.read<T>().rightCount = 0;
                  context.read<T>().wrongCount = 0;
                  // Reset index through startGame method

                  context.read<T>().startGame(
                      level: level, isTimer: context.read<T>().isTimer);
                }
              } else {
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.info:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (context) => CommonInfoDialogView(
                gameCategoryType: widget.gameCategoryType,
                color: widget.colorTuple.item1.primaryColor!,
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              if (value == true) {
                // User clicked "Go" - continue with game
                if (widget.gameCategoryType == GameCategoryType.NUMERIC_MEMORY) {
                  // For numeric memory, just set dialog type to non and let the view handle timing
                  context.read<T>().dialogType = DialogType.non;
                  // Don't call gotItFromInfoDialog - let numeric memory view handle its own logic
                } else {
                  context.read<T>().gotItFromInfoDialog(widget.level);
                }
              } else {
                // User clicked "Cancel" or dismissed dialog - exit game
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.pause:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGamePauseDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: context.read<T>().currentScore,
                  colorTuple: widget.colorTuple,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null) {
                if (value) {
                  context.read<T>().pauseResumeGame();
                } else {
                  context.read<T>().updateScore();
                  context.read<T>().startGame(level: widget.level);
                }
              } else {
                context.read<T>().updateScore();
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.exit:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGameExitDialogView(
                  colorTuple: widget.colorTuple,
                  score: context.read<T>().currentScore,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null && value) {
                context.read<T>().updateScore();
                Navigator.pop(context);
              } else {
                context.read<T>().pauseResumeGame();
              }
            });
            break;
          case DialogType.hint:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (c) => CommonHintDialog(
                gameCategoryType: widget.gameCategoryType,
                colorTuple: widget.colorTuple,
                provider: context.read<T>(),
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              if (value == true) {
                // User clicked "Ok" after viewing hint - keep game paused
                if (widget.gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
                  // For mental arithmetic, keep the game paused after viewing hint
                  // User needs time to input the answer they just saw
                  context.read<T>().dialogType = DialogType.non;
                  // Don't resume timer yet - let user input the answer first
                  // Timer will resume after they input an answer in checkResult
                } else {
                  context.read<T>().gotItFromInfoDialog(widget.level);
                }
              } else {
                // User clicked "Cancel" - resume the game timer
                if (widget.gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
                  context.read<T>().dialogType = DialogType.non;
                  context.read<T>().resumeTimer();
                } else {
                  context.read<T>().pauseResumeGame();
                }
              }
            });
            break;
          case DialogType.non:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: getNoneAppBar(context),
          body: SafeArea(
            bottom: true,
            child: Column(
              children: [
                widget.appBar,
                Expanded(
                  child: widget.child,
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          context.read<T>().showExitDialog();
          return false; // Prevent default back navigation
        });
  }

  @override
  void dispose() {
    provider.removeListener(addListener);
    super.dispose();
  }
}

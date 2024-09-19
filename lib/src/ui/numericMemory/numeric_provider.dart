import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumericMemoryProvider extends GameProvider<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  bool isTimer = true;
  Function? nextQuiz;

  NumericMemoryProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context,
      required Function nextQuiz,
      bool? isTimer})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            isTimer: isTimer,
            c: context) {
    this.level = level;
    this.isTimer = (isTimer == null) ? true : isTimer;
    this.context = context;
    this.nextQuiz = nextQuiz;

    startGame(level: this.level == null ? null : level, isTimer: isTimer);
  }

  Future<void> checkResult(String mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    print("mathPair===$mathPair===${currentState.answer}");

    if (mathPair == currentState.answer) {
      audioPlayer.playRightSound();
      currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

      addCoin();
    } else {
      minusCoin();
      wrongAnswer();
      audioPlayer.playWrongSound();
      first = -1;
    }

    await Future.delayed(Duration(seconds: 1));
    loadNewDataIfRequired(level: level == null ? 1 : level, isScoreAdd: false);

    if (nextQuiz != null) {
      nextQuiz!();
    }
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class PicturePuzzleProvider extends GameProvider<PicturePuzzle> {
  late String result;
  int? level;
  BuildContext? context;

  PicturePuzzleProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  void checkGameResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

        addCoin();

        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        wrongAnswer();
        minusCoin();
      }
    }
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}

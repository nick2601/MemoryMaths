import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';
import '../../data/models/cube_root.dart';
import '../soundPlayer/audio_file.dart';

class CubeRootProvider extends GameProvider<CubeRoot> {
  int? level;

  CubeRootProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.CUBE_ROOT,
            context: context) {
    this.level = level;

    startGame(level: this.level == null ? null : level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    print(
        "result===${int.parse(answer) == currentState.answer && timerStatus != TimerStatus.pause}");

    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      audioPlayer.playRightSound();
      rightAnswer(); // Uses standardized method from base class

      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level == null ? null : level);

      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      notifyListeners();
    } else {
      audioPlayer.playWrongSound();
      wrongAnswer(); // Uses standardized method from base class
    }
  }
}

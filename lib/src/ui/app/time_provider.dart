import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'coin_provider.dart';

class TimeProvider extends CoinProvider {
  Timer? timer;

  int currentTime = 0;

  TimeProvider({
    required TickerProvider vsync,
    required this.totalTime,
  }) {
    var oneSec = Duration(seconds: 1);
    currentTime = totalTime;

    timer = new Timer.periodic(oneSec, (Timer timer) {
      if (currentTime <= 1) {
        timer.cancel();
        if (dialogType == DialogType.non) {
          dialogType = DialogType.over;
          timerStatus = TimerStatus.pause;
          notifyListeners();
        }
      } else {
        currentTime = currentTime - 1;
        notifyListeners();
      }

      print("currentTime===$currentTime");
    });
  }

  startMethod(int seconds) {
    if (timer != null) {
      timer!.cancel();
    }
    var oneSec = Duration(seconds: 1);
    currentTime = seconds;

    timer = new Timer.periodic(oneSec, (Timer timer) {
      if (currentTime <= 1) {
        timer.cancel();
        currentTime = 0;

        if (dialogType == DialogType.non) {
          dialogType = DialogType.over;
          timerStatus = TimerStatus.pause;
          notifyListeners();
        }
      } else {
        currentTime = currentTime - 1;
        notifyListeners();
      }

      print("currentTime===$currentTime");
    });
  }

  final int totalTime;

  DialogType dialogType = DialogType.non;
  TimerStatus timerStatus = TimerStatus.restart;

  // late final AnimationController _animationController;
  // Animation<double> get animation => _animationController;

  void startTimer() {
    // _animationController.reverse();
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    // _animationController.stop();
    timerStatus = TimerStatus.pause;
  }

  void resumeTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    startMethod(currentTime);
    // _animationController.reverse();
    timerStatus = TimerStatus.play;
  }

  void reset() {
    startMethod(totalTime);
    // _animationController.value = 1.0;
  }

  void restartTimer() {
    // _animationController.reverse(from: 1.0);
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void increase() {
    // print("timerval===${_animationController.value}");
    // _animationController.value = _animationController.value + 0.05;
    // _animationController.reverse();
  }

  @override
  void dispose() {
    print("dispose---true");
    // _animationController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}

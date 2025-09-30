import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';

/// Provider for managing the game timer and dialog state.
/// Handles timer start, pause, resume, reset, and disposal.
class TimeProvider with ChangeNotifier {
  Timer? timer;
  int currentTime = 0;

  /// Total time for the timer in seconds.
  final int totalTime;

  /// Current dialog type (info, pause, over, etc.).
  DialogType dialogType = DialogType.non;
  /// Current timer status (play, pause, restart).
  TimerStatus timerStatus = TimerStatus.restart;

  /// Creates a TimeProvider with the given vsync and total time.
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

  /// Starts the timer with the specified number of seconds.
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

  /// Starts the timer for the game.
  void startTimer() {
    // _animationController.reverse();
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  /// Pauses the timer.
  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    timerStatus = TimerStatus.pause;
  }

  /// Resumes the timer from the current time.
  void resumeTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    startMethod(currentTime);
    // _animationController.reverse();
    timerStatus = TimerStatus.play;
  }

  /// Resets the timer to the total time.
  void reset() {
    startMethod(totalTime);
    // _animationController.value = 1.0;
  }

  /// Restarts the timer for a new round.
  void restartTimer() {
    // _animationController.reverse(from: 1.0);
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }


  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}

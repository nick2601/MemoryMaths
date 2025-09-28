import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/core/app_constant.dart';

/// Immutable timer state
class TimeState {
  final int currentTime;
  final int totalTime;
  final DialogType dialogType;
  final TimerStatus timerStatus;
  final int levelNo;
  final double currentScore;
  final int coin;

  const TimeState({
    required this.currentTime,
    required this.totalTime,
    this.dialogType = DialogType.non,
    this.timerStatus = TimerStatus.restart,
    this.levelNo = 1,
    this.currentScore = 0.0,
    this.coin = 0,
  });

  TimeState copyWith({
    int? currentTime,
    int? totalTime,
    DialogType? dialogType,
    TimerStatus? timerStatus,
    int? levelNo,
    double? currentScore,
    int? coin,
  }) {
    return TimeState(
      currentTime: currentTime ?? this.currentTime,
      totalTime: totalTime ?? this.totalTime,
      dialogType: dialogType ?? this.dialogType,
      timerStatus: timerStatus ?? this.timerStatus,
      levelNo: levelNo ?? this.levelNo,
      currentScore: currentScore ?? this.currentScore,
      coin: coin ?? this.coin,
    );
  }
}



/// Timer notifier
class TimeNotifier extends StateNotifier<TimeState> {
  Timer? _timer;

  TimeNotifier(int totalTime)
      : super(TimeState(currentTime: totalTime, totalTime: totalTime));

  void _startInternal(int seconds) {
    _timer?.cancel();
    state = state.copyWith(currentTime: seconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.currentTime <= 1) {
        timer.cancel();
        state = state.copyWith(
          currentTime: 0,
          dialogType: DialogType.over,
          timerStatus: TimerStatus.pause,
        );
      } else {
        state = state.copyWith(currentTime: state.currentTime - 1);
      }
    });
  }

  void startTimer() {
    _startInternal(state.totalTime);
    state = state.copyWith(
      timerStatus: TimerStatus.play,
      dialogType: DialogType.non,
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(timerStatus: TimerStatus.pause);
  }

  void resumeTimer() {
    _startInternal(state.currentTime);
    state = state.copyWith(timerStatus: TimerStatus.play);
  }

  void restartTimer() {
    _startInternal(state.totalTime);
    state = state.copyWith(
      timerStatus: TimerStatus.play,
      dialogType: DialogType.non,
    );
  }

  void reset() {
    _startInternal(state.totalTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Riverpod provider
final timeProvider =
StateNotifierProvider.family<TimeNotifier, TimeState, int>((ref, totalTime) {
  return TimeNotifier(totalTime);
});
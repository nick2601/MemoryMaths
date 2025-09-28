import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';
import '../../core/app_constant.dart';


class ComplexCalculationState {
  final TimerStatus timerStatus;
  final String result;
  final int rightCount;
  final int wrongCount;
  final ComplexModel? currentState;

  const ComplexCalculationState({
    this.timerStatus = TimerStatus.running,
    this.result = '',
    this.rightCount = 0,
    this.wrongCount = 0,
    this.currentState,
  });

  ComplexCalculationState copyWith({
    TimerStatus? timerStatus,
    String? result,
    int? rightCount,
    int? wrongCount,
    ComplexModel? currentState,
  }) {
    return ComplexCalculationState(
      timerStatus: timerStatus ?? this.timerStatus,
      result: result ?? this.result,
      rightCount: rightCount ?? this.rightCount,
      wrongCount: wrongCount ?? this.wrongCount,
      currentState: currentState ?? this.currentState,
    );
  }
}

class ComplexCalculationNotifier extends Notifier<ComplexCalculationState> {
  int? level;

  @override
  ComplexCalculationState build() {
    level = null;
    return const ComplexCalculationState();
  }

  void startGame({int? level}) {
    this.level = level;
    state = state.copyWith(
      currentState: ComplexModel(
        question: "2 + 3",
        answer: "5",
        optionList: ["5", "6", "7", "8"],
      ),
    );
  }

  Future<void> checkResult(String answer) async {
    if (state.timerStatus != TimerStatus.pause) {
      state = state.copyWith(result: answer);

      if (answer == state.currentState?.answer) {
        state = state.copyWith(rightCount: state.rightCount + 1);
      } else {
        state = state.copyWith(wrongCount: state.wrongCount + 1);
      }

      await Future.delayed(const Duration(milliseconds: 300));
      loadNewDataIfRequired();

      if (state.timerStatus != TimerStatus.pause) {
        restartTimer();
      }
    }
  }

  void loadNewDataIfRequired() {
    state = state.copyWith(
      currentState: ComplexModel(
        question: "4 * 3",
        answer: "12",
        optionList: ["9", "10", "11", "12"],
      ),
    );
  }

  void restartTimer() {
    state = state.copyWith(timerStatus: TimerStatus.running);
  }
}

final complexCalculationProvider =
NotifierProvider<ComplexCalculationNotifier, ComplexCalculationState>(
      () => ComplexCalculationNotifier(),
);

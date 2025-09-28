import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';

class ComplexCalculationState {
  final ComplexModel? currentState;
  final String? result;
  final int rightCount;
  final int wrongCount;
  final TimerStatus timerStatus;

  const ComplexCalculationState({
    this.currentState,
    this.result,
    this.rightCount = 0,
    this.wrongCount = 0,
    this.timerStatus = TimerStatus.running,
  });

  ComplexCalculationState copyWith({
    ComplexModel? currentState,
    String? result,
    int? rightCount,
    int? wrongCount,
    TimerStatus? timerStatus,
  }) {
    return ComplexCalculationState(
      currentState: currentState ?? this.currentState,
      result: result ?? this.result,
      rightCount: rightCount ?? this.rightCount,
      wrongCount: wrongCount ?? this.wrongCount,
      timerStatus: timerStatus ?? this.timerStatus,
    );
  }
}
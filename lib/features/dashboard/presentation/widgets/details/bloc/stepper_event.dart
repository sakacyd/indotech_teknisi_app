part of 'stepper_bloc.dart';

@immutable
sealed class StepperEvent {}

final class ChangeStep extends StepperEvent {
  final int step;

  ChangeStep(this.step);
}

part of 'stepper_bloc.dart';

@immutable
sealed class StepperState {}

final class StepperInitial extends StepperState {}

final class StepperLoading extends StepperState {}

final class StepperChanged extends StepperState {
  final int currentStep;

  StepperChanged(this.currentStep);
}

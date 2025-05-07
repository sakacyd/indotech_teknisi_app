part of 'viewer_bloc.dart';

@immutable
sealed class ViewerState {}

final class ViewerInitial extends ViewerState {}

final class ViewerLoading extends ViewerState {}

final class StepperChanged extends ViewerState {
  final int currentStep;

  StepperChanged(this.currentStep);
}

final class ViewerCompleted extends ViewerState {}

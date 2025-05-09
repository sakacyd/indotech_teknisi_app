part of 'viewer_bloc.dart';

@immutable
sealed class ViewerState {}

final class ViewerInitial extends ViewerState {}

final class ViewerLoading extends ViewerState {}

final class StepperChanged extends ViewerState {
  final int currentStep;

  StepperChanged(this.currentStep);
}

class UpdateTechnicianArrivedSuccess extends ViewerState {
  final AssignmentModel assignment;

  UpdateTechnicianArrivedSuccess(this.assignment);

  List<Object?> get props => [assignment];
}

final class ViewerCompleted extends ViewerState {}

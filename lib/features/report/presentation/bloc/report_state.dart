part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class StepperChanged extends ReportState {
  final int currentStep;

  StepperChanged(this.currentStep);
}

final class ReportCompleted extends ReportState {}

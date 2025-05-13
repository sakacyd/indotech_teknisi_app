part of 'report_bloc.dart';

@immutable
sealed class ReportState {
  final int currentStep;
  const ReportState({required this.currentStep});
}

final class ReportInitial extends ReportState {
  const ReportInitial() : super(currentStep: 0);
}

final class ReportLoading extends ReportState {
  const ReportLoading({required int currentStep}) : super(currentStep: currentStep);
}

final class UpdateArrivedSuccess extends ReportState {
  const UpdateArrivedSuccess() : super(currentStep: 1);
}

final class UpdateStartedSuccess extends ReportState {
  const UpdateStartedSuccess() : super(currentStep: 2);
}

final class UpdateFinishedSuccess extends ReportState {
  const UpdateFinishedSuccess() : super(currentStep: 3);
}

final class ReportCompleted extends ReportState {
  const ReportCompleted() : super(currentStep: 4);
}

final class ReportFailure extends ReportState {
  final String message;
  const ReportFailure(this.message, {required int currentStep})
    : super(currentStep: currentStep);
}

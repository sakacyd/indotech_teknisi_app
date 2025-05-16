part of 'submit_report_bloc.dart';

@immutable
sealed class SubmitReportState {
  const SubmitReportState();
}

final class SubmitReportInitial extends SubmitReportState {}

final class SubmitReportLoading extends SubmitReportState {}

final class SubmitReportSuccess extends SubmitReportState {
  final User user;

  const SubmitReportSuccess(this.user);
}

final class SubmitReportFailure extends SubmitReportState {
  final String message;

  const SubmitReportFailure(this.message);
}

part of 'submit_report_bloc.dart';

@immutable
sealed class SubmitReportState {}

final class SubmitReportInitial extends SubmitReportState {}

final class SubmitReportLoading extends SubmitReportState {}

final class SubmitReportSuccess extends SubmitReportState {}

final class SubmitReportFailure extends SubmitReportState {
  final String message;

  SubmitReportFailure(this.message);
}

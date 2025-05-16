part of 'submit_report_bloc.dart';

@immutable
sealed class SubmitReportEvent {}

final class SubmitReportForm extends SubmitReportEvent {
  final String email;
  final String password;
  final String name;

  SubmitReportForm({required this.email, required this.password, required this.name});
}

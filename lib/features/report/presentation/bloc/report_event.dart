part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class ChangeStep extends ReportEvent {
  final int step;

  ChangeStep(this.step);
}

final class CompleteReport extends ReportEvent {}

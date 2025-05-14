part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class UpdateArrived extends ReportEvent {
  final String assignmentId;

  UpdateArrived(this.assignmentId);
}

final class UpdateStarted extends ReportEvent {
  final String assignmentId;

  UpdateStarted(this.assignmentId);
}

final class UpdateFinished extends ReportEvent {
  final String assignmentId;

  UpdateFinished(this.assignmentId);
}

final class UpdateStatus extends ReportEvent {
  final String assignmentId;

  UpdateStatus(this.assignmentId);
}

final class CompleteReport extends ReportEvent {}

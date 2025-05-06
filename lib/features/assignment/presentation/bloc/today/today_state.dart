part of 'today_bloc.dart';

@immutable
sealed class AssignmentState {}

final class AssignmentInitial extends AssignmentState {}

final class AssignmentLoadingToday extends AssignmentState {}

final class AssignmentGetTodaySuccess extends AssignmentState {
  final List<Assignment> assignments;

  AssignmentGetTodaySuccess(this.assignments);
}

final class AssignmentFailure extends AssignmentState {
  final String message;

  AssignmentFailure(this.message);
}

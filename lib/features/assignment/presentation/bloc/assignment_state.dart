part of 'assignment_bloc.dart';

@immutable
sealed class AssignmentState {}

final class AssignmentInitial extends AssignmentState {}

final class AssignmentLoading extends AssignmentState {}

final class AssignmentGetTodaySuccess extends AssignmentState {
  final List<Assignment> assignments;

  AssignmentGetTodaySuccess(this.assignments);
}

final class AssignmentGetPreviousSuccess extends AssignmentState {
  final List<Assignment> assignments;

  AssignmentGetPreviousSuccess(this.assignments);
}

final class AssignmentFailure extends AssignmentState {
  final String message;

  AssignmentFailure(this.message);
}

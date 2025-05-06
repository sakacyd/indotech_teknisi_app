part of 'history_bloc.dart';

@immutable
sealed class AssignmentState {}

final class AssignmentInitial extends AssignmentState {}

final class AssignmentLoadingPrevious extends AssignmentState {}

final class AssignmentGetPreviousSuccess extends AssignmentState {
  final List<Assignment> assignments;

  AssignmentGetPreviousSuccess(this.assignments);
}

final class AssignmentFailure extends AssignmentState {
  final String message;

  AssignmentFailure(this.message);
}
